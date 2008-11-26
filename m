From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: Re: [PATCH] git-gui: update Japanese translation
Date: Thu, 27 Nov 2008 00:27:37 +0300
Organization: HOME
Message-ID: <200811270027.38629.angavrilov@gmail.com>
References: <20081126192144.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 22:30:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5Ry3-0002yr-7Z
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 22:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbYKZV3S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Nov 2008 16:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbYKZV3S
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 16:29:18 -0500
Received: from mu-out-0910.google.com ([209.85.134.184]:14361 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbYKZV3R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Nov 2008 16:29:17 -0500
Received: by mu-out-0910.google.com with SMTP id g7so544559muf.1
        for <git@vger.kernel.org>; Wed, 26 Nov 2008 13:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=/emvHQKKJ9m3pMdaUnyG1PF3llNYGBAKHfDnFrNwkok=;
        b=O9EEpqt9CV1A4pykuNCJGgLKr8yLl56yxxhu3cRINdLJMiM8Zm74O/ojlDTANpszE6
         NmuSB9YP3y6ah/TGeuPsBJKWEQ+fnujg1QlO7OEuxgnwRBQs2P6Wku4ZSoOoF7cmi61/
         9q5OAFI044VMHfbcjB31qF7/wH0cLP0EpbNkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=c6yIygDOzSQjkxNqQ/6DnXagVi0xEBDHieA9ZdR1S14Z7mnZ6BhuvTEd6rum520aoU
         E1bjEw95dvTvEXopV+mLZRTpLkvYRvvmiEC0B4WrCaUaja/774X4hkoogarqeHFhqX0u
         D3sQw2tJsXmxMN7FrCeRtthg9K0ZBul4+47Zs=
Received: by 10.181.240.7 with SMTP id s7mr2083112bkr.110.1227734955029;
        Wed, 26 Nov 2008 13:29:15 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id k29sm1074672fkk.17.2008.11.26.13.29.14
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 26 Nov 2008 13:29:14 -0800 (PST)
User-Agent: KMail/1.10.1 (Linux/2.6.27.5-117.fc10.i686; KDE/4.1.2; i686; ; )
In-Reply-To: <20081126192144.6117@nanako3.lavabit.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101772>

On Wednesday 26 November 2008 13:21:44 Nanako Shiraishi wrote:
> -#: lib/blame.tcl:388
> +#: lib/blame.tcl:288
> +msgid "Show History Context"
> +msgstr "=E6=96=87=E8=84=88=E3=82=92=E8=A6=8B=E3=81=9B=E3=82=8B"

> -#: lib/option.tcl:128
> +#: lib/option.tcl:151
> +msgid "Blame History Context Radius (days)"
> +msgstr "=E8=A8=BB=E9=87=88=E3=81=99=E3=82=8B=E5=B1=A5=E6=AD=B4=E5=8D=
=8A=E5=BE=84=EF=BC=88=E6=97=A5=E6=95=B0=EF=BC=89"

I obviosly should have chosen a less ambiguous name for this
option. Everybody seems to think that the key item here is Blame,
while actually it is "History Context", i.e. the option specifies the
Radius of the History Context that is shown by the corresponding
menu item in the Blame viewer. It was probably better to name it
simply "History Context Radius".

This menu item starts gitk, auto-selecting the commit that the clicked
line of the blame viewer is annotated with, and restricting view to
commits that are within the specified time radius of it. The feature is=
 mainly
intended to aid analysis of repositories with poorly structured history=
,
where related changes are often scattered into multiple nearby commits.
It can easily happen as a consequence of importing history from
a file-centered VCS, like CVS or Visual SourceSafe. That's why no
limiting on file path is done.

Of course, it is also a handy way to view the commit diff...

Alexander
