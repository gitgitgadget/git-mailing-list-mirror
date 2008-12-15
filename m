From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [usability bug] git branch -a does not disambiguate remote and local branches
Date: Mon, 15 Dec 2008 20:24:10 +0100
Message-ID: <8c5c35580812151124h5f9b8704l492a5a9a7eb48d1a@mail.gmail.com>
References: <85647ef50812151015t4d5bc2b8p4ea53a0e4ad25e64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Constantine Plotnikov" <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 20:25:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCJ4N-0008QU-B9
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 20:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbYLOTYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 14:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbYLOTYM
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 14:24:12 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:30012 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbYLOTYL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 14:24:11 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1182755yxm.1
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 11:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=YnXPV1WtIh5UCS//kMr8mUyuoILDjOI7tiEYLnkZpFY=;
        b=k3jKNI4MI/jvdqZWo51cby7hDrK9J/hwh+O9EGph5afnM1m8bTeJfj2oxT7fywodvH
         yCYrYzg6204EwCab4C7ohqsThiAz0nE78BQ9YFQ/y0WVLmkTg0vJPLe9EcckeRGketZK
         HvZDVq/glzao41xz9YmO875NsCSPcIGpmS5q4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=oc0gd7ha4GCyqMeqRCAEml3y+lRvOOWS6kCvdCkALk7Wtt3ergMP20GvHd8cKjBffu
         eozmMHldSoNi11tsUS7oVsgdWL9kC31drTGrq9wzl1RHjlFyMgVe54lra/cGaadgNy7R
         x2DezE0ofo1GzpGSArG0UEvoxvuxCyMYmUjCU=
Received: by 10.150.211.4 with SMTP id j4mr12055882ybg.187.1229369050508;
        Mon, 15 Dec 2008 11:24:10 -0800 (PST)
Received: by 10.151.82.10 with HTTP; Mon, 15 Dec 2008 11:24:10 -0800 (PST)
In-Reply-To: <85647ef50812151015t4d5bc2b8p4ea53a0e4ad25e64@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103198>

On Mon, Dec 15, 2008 at 19:15, Constantine Plotnikov
<constantine.plotnikov@gmail.com> wrote:
> After this scenario is executed, git branch -a will give the following output:
>  master
> * origin/master
>  origin/master
>
> Note that there is two origin/master entries, but it is not clear
> which is remote is and which is the local.

You can use `git branch -a --color` to see the difference (issue `git
config --global color.branch true` to use --color automatically).

--
larsh
