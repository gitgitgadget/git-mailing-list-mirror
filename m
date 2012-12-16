From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH] git.c: add --index-file command-line option.
Date: Sun, 16 Dec 2012 09:20:59 +0100
Message-ID: <50CD846B.2040604@gmail.com>
References: <1355484219-7517-1-git-send-email-manlio.perillo@gmail.com> <7vpq2btcqp.fsf@alter.siamese.dyndns.org> <50CCC73B.3070802@gmail.com> <7vliczrttq.fsf@alter.siamese.dyndns.org> <50CCF324.5060802@gmail.com> <7vvcc2r0z8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 09:24:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tk9W8-0005SQ-0u
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 09:24:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311Ab2LPIVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 03:21:11 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:40358 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190Ab2LPIVL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 03:21:11 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so2289517bkw.19
        for <git@vger.kernel.org>; Sun, 16 Dec 2012 00:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=H3078FcgkqnA8hUbFzJ3UpNRuIVROf+bJloUSazviUQ=;
        b=rFTfn9u0tOI3XJ8a/kb/kwK+ds9VUxxNpX8RAbdnPY/3oIE9iA2Ri7VfCvkhgnHV5z
         H2/II06nfNqi10Zz8OXei54G6bkXmdnjTCKBGZ3+wj7PTFeyqKG/XdHTEaFfMofrmyZU
         A8JJKorRbbTy9Nt8ZBJjxfJHu6XwzHZvS5LZCJi7XkTNfdX6fHV8EstfmmEfQeYGhVvm
         GDFMaeD64QuOJt13E6OfrUovqhje0Qqsk0qwNIhZx3vgyB2tOFLXpmnu3py5ZPtDcExG
         6SBmmBL2MQ6LPMWCK9GmKkUrQoACFGgURPOOs3VluV3c0bhOBDz3J0lVM1PpXtispPh2
         RW/w==
Received: by 10.204.141.4 with SMTP id k4mr4537264bku.60.1355646068097;
        Sun, 16 Dec 2012 00:21:08 -0800 (PST)
Received: from [192.168.0.3] ([151.70.213.162])
        by mx.google.com with ESMTPS id f24sm7124841bkv.7.2012.12.16.00.21.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Dec 2012 00:21:07 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121027 Icedove/3.0.11
In-Reply-To: <7vvcc2r0z8.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211583>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 16/12/2012 06:59, Junio C Hamano ha scritto:
> I
> Manlio Perillo <manlio.perillo@gmail.com> writes:
> 
>> This works with a shell.
>> I'm using Python to write a custom git command.
> 
> I would be very surprised if Python lacked a way to spawn a
> subprocess with an environment modified from the current process.

Of course it is possible, but a command-line option is more convenient,
IMHO.



Regards  Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDNhGsACgkQscQJ24LbaUQ0dQCglUAw8zwRKNeDUGznfrm1xFKf
GQsAnA/ucztku4v9LnIr0Lv/gyl5ULiT
=j/1w
-----END PGP SIGNATURE-----
