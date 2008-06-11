From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: "git pull . <branch>" versus "git merge <branch>"
Date: Wed, 11 Jun 2008 11:06:32 +1000
Message-ID: <ee77f5c20806101806u6dc04152rb8307eb12a6167c@mail.gmail.com>
References: <484F2174.9020508@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "Rene Herman" <rene.herman@keyaccess.nl>
X-From: git-owner@vger.kernel.org Wed Jun 11 03:07:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6EoE-00005S-Uk
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 03:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811AbYFKBGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 21:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754697AbYFKBGh
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 21:06:37 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:57352 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601AbYFKBGg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 21:06:36 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1960702fgg.17
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 18:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=kdsy3YlZIpHRhFfQqVlausIwoGDGzFRwox+7cyFovCo=;
        b=Y3Vsrt3VNmI5fR+5oV2feYUkkQe0KU+WWVO4N/RqDm6FlJ4zYP1Gqcr/ALmpvo2X5y
         vl98BV5ytG8niTOasJsotMU6wISFz6mIFBzDiy++jUWuVTHmxLuMcqGelxt5Tlh8hQ00
         CQtwmGO4ur8pj1qEuaxqNC6tXJCFbf6tmB6XE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Vz1gVepYRFd2vdIPxwexNDPMXissVEdDzDGF79bN0kYPpD3LOfM8ahRprSz+/K28cQ
         ehAAWNom8jW6CmcHpWu6m1HKkkYEi0FGWdgC/EYTE+W++3zqFeikST4xClhXEueaaQdZ
         eIpxc93fqDOqnJJc57/T8ibu0DDs2EKxH+6uk=
Received: by 10.86.80.17 with SMTP id d17mr6461528fgb.24.1213146392745;
        Tue, 10 Jun 2008 18:06:32 -0700 (PDT)
Received: by 10.86.74.8 with HTTP; Tue, 10 Jun 2008 18:06:32 -0700 (PDT)
In-Reply-To: <484F2174.9020508@keyaccess.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84569>

On Wed, Jun 11, 2008 at 10:51 AM, Rene Herman <rene.herman@keyaccess.nl> wrote:

> The manpages seem to be making somewhat of a point of mentioning "git pull .
> <branch>" as the way to merge a local branch into the current one but a
> simple "git merge <branch>" seems to work well. Is there a difference?

git pull also does a fetch in it's usual mode of operation, and runs
git merge to do merge changes in the remote-tracking branches.


Dave.
