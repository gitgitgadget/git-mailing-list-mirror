From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Can't find the revelant commit with git-log
Date: Sat, 29 Jan 2011 13:52:15 +0100
Message-ID: <m2sjwb6feo.fsf@gmail.com>
References: <m2ipxd2w78.fsf@gmail.com> <4D3EF650.20407@lsrfire.ath.cx>
	<m2ipxc27zi.fsf@gmail.com> <m239og12pe.fsf@gmail.com>
	<4D4063EC.7090509@lsrfire.ath.cx> <4D433CA7.9060200@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Jan 29 13:52:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjAHy-0008Du-Pv
	for gcvg-git-2@lo.gmane.org; Sat, 29 Jan 2011 13:52:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626Ab1A2MwW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Jan 2011 07:52:22 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44218 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516Ab1A2MwV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Jan 2011 07:52:21 -0500
Received: by wwa36 with SMTP id 36so4312150wwa.1
        for <git@vger.kernel.org>; Sat, 29 Jan 2011 04:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=uu3QPUQLVmKIbw1zl7oiRFs96DFYdr7WDRSM5oWz45o=;
        b=cZ8evFcWHuSLlC+BhbeLzgzpNjnyawiDqarjjvyOvCqLmysjGFJcthwwxCJXTB2Fg8
         T6A5ykGBK+L2uy5oFOwphd5RIA64AIy3DE6RbFfTDksk4LNJhd3nyFebo09asB7Bp8Hj
         fQ2g4VKhfa+gjcF74kHuLAGMCyl0fxT58ZUHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=PaVt5WrLPbyVsJPhrrZeAGfuEz9g8LSKqo16uekdt9ioviQOGJyRmHH1TQttkAQFVQ
         hALYeSE7jVTw9dwsilIiicW/Mi3yOBXrqF2yksR1LYYuQGOAflt69PrQu2owwdUJfBV6
         F5qnLEohXO3ACmp7SHMNZ02abdpQxplBkveDg=
Received: by 10.227.68.201 with SMTP id w9mr3943099wbi.101.1296305539816;
        Sat, 29 Jan 2011 04:52:19 -0800 (PST)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id c54sm9615268wer.6.2011.01.29.04.52.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 29 Jan 2011 04:52:17 -0800 (PST)
In-Reply-To: <4D433CA7.9060200@lsrfire.ath.cx> (=?iso-8859-1?Q?=22Ren=E9?=
 Scharfe"'s message of
	"Fri, 28 Jan 2011 23:01:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165657>

Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Am 26.01.2011 19:11, schrieb Ren=E9 Scharfe:
>> - Make git grep report non-matching path specs (new feature).
>
> This is a bit complicated because grep can work on files, index entri=
es
> as well as versioned objects and supports wildcards,
> so it's not that easy to tell if a path spec matches something or is =
a
> rather typo.  But it's not impossible either, of course.

I don't understand this for the following use case:

   $ cd ~/linux-2.6/drivers/pci/
   $ git grep blacklist v2.6.27 -- drivers/pci/intel-iommu.c

=46rom what you said, it sounds that git grep is actually searching the
string 'somewhere'. But where ?

Thanks
--=20
=46rancis
