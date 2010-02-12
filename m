From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: Re: [PATCH 3/4] git-am: Add command line parameter `--keep-cr`
	passing it to git-mailsplit.
Date: Fri, 12 Feb 2010 22:05:46 +0100
Organization: -no organization-
Message-ID: <20100212210546.GC32018@pille.home>
References: <1265923579-24900-1-git-send-email-stefan.hahn@s-hahn.de> <1265923579-24900-4-git-send-email-stefan.hahn@s-hahn.de> <7vocjvqryb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 22:06:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng2i9-0000gD-Kz
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 22:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757739Ab0BLVF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 16:05:56 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:50464 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755645Ab0BLVFz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 16:05:55 -0500
Received: from pille.home (port-92-203-117-198.dynamic.qsc.de [92.203.117.198])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MgYEB-1NJAfP3zMd-00O5tA; Fri, 12 Feb 2010 22:05:53 +0100
Received: from pille.home (localhost [127.0.0.1])
	by pille.home (8.14.3/8.14.3/Debian-5) with ESMTP id o1CL5p4B013821;
	Fri, 12 Feb 2010 22:05:51 +0100
Received: (from hs@localhost)
	by pille.home (8.14.3/8.14.3/Submit) id o1CL5k5E013819;
	Fri, 12 Feb 2010 22:05:46 +0100
X-Authentication-Warning: pille.home: hs set sender to stefan.hahn@s-hahn.de using -f
Content-Disposition: inline
In-Reply-To: <7vocjvqryb.fsf@alter.siamese.dyndns.org>
X-Mailer: Mutt 1.5.18 http://www.mutt.org/
X-Editor: GNU Emacs 22.2.1 http://www.gnu.org/
X-Accept-Language: de en
X-Location: Europe, Germany, Wolfenbuettel
X-GPG-Public-Key: gpg --keyserver keys.gnupg.net --recv-keys E4FCD563
X-GPG-key-ID/Fingerprint: 0xE4FCD563 / EF09 97BB 3731 7DC7 25BA 5C39 185C
	F986 E4FC D563
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V01U2FsdGVkX18Xh+vcr9bgtZki2fcsfjA4r+b6M7ZQSpeLjDd
 atSk8cjPD73+q3c5NBtrOjpY15bLNfETlvDCp6Z/7xph4Xba4Z
 1cKTh9ngP956YY3aTgGzA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139747>

Also sprach Junio C Hamano am Thu, 11 Feb 2010 at 15:21:32 -0800:
> "Stefan-W. Hahn" <stefan.hahn@s-hahn.de> writes:
> 
> > If applying patches with the following command sequence
> >
> >    git format-patch --stdout ... | git am ...
> >
> > in repositories having files with dos and unix line endings
> > git-mailsplit, which is called from git-am must be called with
> > `--keep-cr` parameter since commit c2ca1d79.
> 
> Sorry, I cannot parse this.

What?

> Perhaps you meant to have a comma between "git-am" and "must be"?
> 
> > +e,keep-cr       pass --keep-cr flag to git-mailsplit for mbox format
> 
> This short form -e does not make much sense to me.  Why is it -e, and do
> we even need a short form in the first place?

Just for shortening the commandline.

> or even:
> 
> 	if test -n "$r$k"
>         then
>         	keep_cr=--keep-cr
> 	else
>         	keep_cr=
> 	fi

This one. I will make a patch soon.

Stefan
-- 
Stefan-W. Hahn                          It is easy to make things.
/ mailto:stefan.hahn@s-hahn.de /        It is hard to make things simple.			

Please note that according to the German law on data retention,
information on every electronic information exchange with me is
retained for a period of six months.
Bundesgesetzblatt:
http://www.bgblportal.de/BGBL/bgbl1f/bgbl107s3198.pdf
