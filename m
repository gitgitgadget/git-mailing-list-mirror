From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: 'git status' is not read-only fs friendly
Date: Sat, 10 Feb 2007 15:31:37 +0100
Message-ID: <e5bfff550702100631w1b6243e7i44039ceaa8d3fe93@mail.gmail.com>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
	 <Pine.LNX.4.63.0702101517360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, "GIT list" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 10 15:31:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFtGR-0001P9-Oc
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 15:31:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbXBJObl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 09:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbXBJObl
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 09:31:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:11421 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932333AbXBJObk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 09:31:40 -0500
Received: by ug-out-1314.google.com with SMTP id 44so197169uga
        for <git@vger.kernel.org>; Sat, 10 Feb 2007 06:31:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H8o7W6zOvIcFgiTDcKDGvidtIeAfLopzywUmQWwJSDNS1UEF8jn2fmdMS58Re3Y0XiG4WpBhL/btRxYfNiCqO5lXtAVpfLCHhaeRFYB7XyurFpEz1+yxXu7T/ekhCxkEfFRFtYmdbhUpuzZW5Icbj65DgccHLNxlyoMiNijKsnY=
Received: by 10.115.54.1 with SMTP id g1mr5395302wak.1171117897732;
        Sat, 10 Feb 2007 06:31:37 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Sat, 10 Feb 2007 06:31:37 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0702101517360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39219>

On 2/10/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 9 Feb 2007, Marco Costalba wrote:
>
> > I just need to know if current working directory is clean and report
> > back to qgit user, so read-only access would be ok for me.
>
> So, why don't you just do a
>
>         git diff --name-only HEAD
>
> and check for an empty output???
>

It seems to have the same issues of 'git runstatus' in case of ntfs
filesystems, so I would prefer, eventually, use 'git runstatus' that
at least gives me index status of the files.

> No need for a patch to Git (so late in the -rc phase), or backwards
> incompatibility...
>

Well, it's a _new_ option so I fail to see backwards incompatibility.
Perhaps you are referring to qgit backward incompatibility, but in any
case a new version of qgit is due to fix a parsing bug that shows
after a modification of 'git rev-list' output occurred in git 1.5
development.

  Marco
