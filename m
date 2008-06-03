From: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
Subject: Re: [PATCH] Avoid git-rev-parse warnings in gitweb blame
Date: Tue, 3 Jun 2008 12:26:18 +0200
Message-ID: <b77c1dce0806030326m54850dabic58e519b494093ce@mail.gmail.com>
References: <1212488060-23251-1-git-send-email-rgarciasuarez@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 12:27:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3TjV-0006ru-47
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 12:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324AbYFCK0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 06:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbYFCK0U
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 06:26:20 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:47112 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbYFCK0T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 06:26:19 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1240512wfd.4
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 03:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=21YpS1U5eR9R1Y0/dKHgT5cjgYUefDPabuq6iXaW/uA=;
        b=p+F9bcbrS5dMncVD28EQN70ckxLW9XciPg5jHyGoG6Sk6cdIrWW+RjGTjEEUGUXWyHswzoSjO6RmdF11E/2OQw3HoVDKFbi//dmG9Iwo+yu0Yzka0lj7uAJ2cE9Pveb286EeFIlOv7y1aSwMHqd7yAgaMmL4JUqZFAGbLiPHnuk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NcKNUXNZb9lmmQZF1ybKUlb9xu32GL5AzmvQO5V49LBFhbhXQhHBNxLBWhI02oOzLlFotgssz288gUCE4UnSquMu112NwHJwad+E3vGtdXdJlRili43nQ8H57cbTZJgNvPGFsX7XSuYee19OgdGuNoEVfSihaX2b0qEHUJNmXzc=
Received: by 10.142.80.7 with SMTP id d7mr2033924wfb.173.1212488778990;
        Tue, 03 Jun 2008 03:26:18 -0700 (PDT)
Received: by 10.142.212.20 with HTTP; Tue, 3 Jun 2008 03:26:18 -0700 (PDT)
In-Reply-To: <1212488060-23251-1-git-send-email-rgarciasuarez@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83634>

2008/6/3 Rafael Garcia-Suarez <rgarciasuarez@gmail.com>:
> Adding a '--' to the command-line avoids git-rev-parse emitting an error
> message "ambiguous argument... Use '--' to separate paths from revisions".

Oh, well, scratch that. I'm (now obviously to me) trying to hide a bug
under the carpet here. Sorry for the noise.
