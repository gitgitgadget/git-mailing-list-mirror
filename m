From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: git 1.5.1-rc1 doesn't like empty files
Date: Tue, 20 Mar 2007 13:04:05 +0600
Message-ID: <200703201304.05902.litvinov2004@gmail.com>
References: <1174361424.3143.42.camel@dv> <1174367312.3143.75.camel@dv> <Pine.LNX.4.64.0703192237100.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pavel Roskin <proski@gnu.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 08:04:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTYOI-0003sT-5t
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 08:04:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822AbXCTHEP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 20 Mar 2007 03:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbXCTHEP
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 03:04:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:26748 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbXCTHEO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Mar 2007 03:04:14 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1537615uga
        for <git@vger.kernel.org>; Tue, 20 Mar 2007 00:04:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UXxIKLdRmQB5Rv3W7CrrhJ6gH0shDbKl8N8MAcwN9uqNWjxuzU63jbyrMCk3QG0FTYpLXM0XtYIt6d8boiiLYUJsRwEEvr9mRWjZS4pPXJ9TqtApzEhH+s0nUa8YIIF8UBwW0VNtIjo5oX23wAuhO+skNx39nqm/Rtoo01IHSdA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bIuupCxyGOJtmn9sG2PwIUb0JxKj6uQVTynjC2ETn+ktXps7A/c68vNFYXivODOeLtkPqtaNLJAzUhhTrwNGZWGZxITvPCcd5w7uC7UgV5AyGx0WoRQXd+53N44Y0KFzsYyz1zjQJ2AGel7a2kjOW1BCKq7RnYGlJ7GXMkk2IVk=
Received: by 10.67.26.7 with SMTP id d7mr828300ugj.1174374252995;
        Tue, 20 Mar 2007 00:04:12 -0700 (PDT)
Received: from lan.ac-sw.lcl ( [81.1.223.2])
        by mx.google.com with ESMTP id s1sm169329uge.2007.03.20.00.04.11;
        Tue, 20 Mar 2007 00:04:12 -0700 (PDT)
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.64.0703192237100.6730@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42724>

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 Tuesday 20 March 2007 11:41 Linus Torvalds =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BB:
> Alexander - do you happen to have that "legacyheaders" setting too? M=
aybe
> that explains your pack corruption?

It seems no:

$  git config core.legacyheaders
$  git config -l
user.name=3DAlexander Litvinov
user.email=3DXXX
core.logallrefupdates=3Dtrue
core.filemode=3Dfalse
core.autocrlf=3Dtrue
diff.color=3Dauto
status.color=3Dauto
apply.whitespace=3Dstrip
core.repositoryformatversion=3D0
core.filemode=3Dfalse
core.bare=3Dfalse
remote.origin.url=3D/home/lan/src/XXX
remote.origin.fetch=3D+refs/heads/*:refs/remotes/origin/*
branch.master.remote=3Dorigin
branch.master.merge=3Drefs/heads/master
branch.XXX.remote=3Dorigin
branch.XXX.merge=3Drefs/heads/XXX
