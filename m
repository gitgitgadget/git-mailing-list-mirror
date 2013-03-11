From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [RFC/PATCH] git-completion.bash: remove bashism to fix ZSH compatibility
Date: Mon, 11 Mar 2013 18:09:08 +0100
Message-ID: <513E0FB4.40607@gmail.com>
References: <1363004487-1193-1-git-send-email-Matthieu.Moy@imag.fr> <7v38w1c3ms.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 11 18:09:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF6EM-0003Vi-Qo
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 18:09:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491Ab3CKRJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 13:09:20 -0400
Received: from mail-ea0-f180.google.com ([209.85.215.180]:64327 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919Ab3CKRJT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 13:09:19 -0400
Received: by mail-ea0-f180.google.com with SMTP id j14so1214198eak.25
        for <git@vger.kernel.org>; Mon, 11 Mar 2013 10:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=lyW5q5YQOXKdnovgU1Z1B6hxaOWB4hCNvbWyFnYjZ9Q=;
        b=J0ltL9VMGCBFMVudzewl9hiWIqgkEjpyPEJVauz4d0y3I2+Pai2rZVBnPSr70ijDMF
         FIafKFVB8VRGaJturU1ZR+jI5WR7doz46oubaNfZHccqDB4p7mURIHQEkPQOcJPT5p9J
         AhqeWAsTCXvSalfCmKNv5VJMCjWvFrsAgctyjwwfqDmeepWjKCpDcqg4Ea9is9OOkAEd
         cfOws/tHbEiS3d2G4IFySwvSwUt+xNOc5pofoBTGrDs3TrHDR1ymzun/6aQpe/T5FG7Y
         k0CySg0OyLIURONwoB97pGHbczgSKww02Kx6BDL4KaoNDJPnJ5rtQTfBXAPqY3iVr9fj
         HpSA==
X-Received: by 10.14.5.6 with SMTP id 6mr10409269eek.42.1363021758464;
        Mon, 11 Mar 2013 10:09:18 -0700 (PDT)
Received: from [192.168.0.3] ([151.70.200.211])
        by mx.google.com with ESMTPS id f47sm24692467eep.13.2013.03.11.10.09.14
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Mar 2013 10:09:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <7v38w1c3ms.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217893>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 11/03/2013 17:17, Junio C Hamano ha scritto:
> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
> 
>> The function-wide redirection used for __git_ls_files_helper and
>> __git_diff_index_helper work only with bash. Using ZSH, trying to
>> complete an inexistant directory gave this:
>>
>>   git add no-such-dir/__git_ls_files_helper:cd:2: no such file or directory: no-such-dir/
>>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
> 
> This is not bash-ism but POSIX.1, even though it is not very well
> known.  I recall commenting on this exact pattern during the review.
> 

Yes, I was plainning to send another patch to fix this (and your other
suggestion regarding the CDPATH environment variable, if I remember
correctly), but I was busy with other things; sorry.



> [...]


Regards  Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlE+D7QACgkQscQJ24LbaURBTgCffpMCPjmcsP53/WE/VIQ2FIIc
fiIAn3obBJ1yrHVUEmslz32ezvESCZ4G
=7nia
-----END PGP SIGNATURE-----
