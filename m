From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH] git.c: add --index-file command-line option.
Date: Sat, 15 Dec 2012 19:53:47 +0100
Message-ID: <50CCC73B.3070802@gmail.com>
References: <1355484219-7517-1-git-send-email-manlio.perillo@gmail.com> <7vpq2btcqp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 19:54:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjwsR-0005Fc-2v
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 19:54:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431Ab2LOSxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 13:53:55 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:49294 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab2LOSxy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 13:53:54 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so2200680bkw.19
        for <git@vger.kernel.org>; Sat, 15 Dec 2012 10:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=6uHcs6Gp4ss/ryM3Wgid0zs2L2AzBnpmI4h91lR8jYY=;
        b=aTv/NLhCdSzu3iVg/158n1tiJuKZ6g0kIorARx2cJvvT+OJx9d4MNVd9u7PRQMsYIy
         gNyw1O2ue5FS51YITnleWQAZq8jd3ltRbGNPiU44ZRBr9aEYltI1a3Nf6+VOFfeWwOJm
         u7gVFxB8FWt10r+f8Ht+PcDKUWQfWEEcl2gc8s9XyMw2SOXbBivq8LSAVpwEIpAwkK36
         Ka+TsdUIvwXFPMvwPfbcq8KX8oEfsTEZtyskJ4CbOWDmZI6yCdy1+PGUjIQOmtqaiBYT
         hVS49Jn1JOt+pUm+TRNwr6SjQl3MywTMXiaqws8AB97wMsNBPtkHgcsovg36lPAQBYrh
         BK1Q==
Received: by 10.204.131.74 with SMTP id w10mr4106500bks.4.1355597633116;
        Sat, 15 Dec 2012 10:53:53 -0800 (PST)
Received: from [192.168.0.3] ([151.70.213.162])
        by mx.google.com with ESMTPS id o9sm6665579bko.15.2012.12.15.10.53.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 15 Dec 2012 10:53:52 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121027 Icedove/3.0.11
In-Reply-To: <7vpq2btcqp.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211558>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 15/12/2012 19:02, Junio C Hamano ha scritto:
> Manlio Perillo <manlio.perillo@gmail.com> writes:
> 
>> Unlike other environment variables (e.g. GIT_WORK_TREE,
>> GIT_NAMESPACE), it was not possible to set the GIT_INDEX_FILE
>> environment variable using the command line.
> 
> Is this necessary?  I'd prefer to see a better reason than "just
> because others have it".

A long running program will be able to tell git to use an alternate
index file, without having to modify its own environment, or having to
use execvpe (I assume this is the reason why it is possible to specify
GIT_WORK_TREE from command line).



Regards  Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEUEARECAAYFAlDMxzsACgkQscQJ24LbaUSzEQCYymkZa6JrT42OzigRfDgc5Hss
gwCgjIzs1b0hEyu1WAgDgCir9XalDN8=
=GtMF
-----END PGP SIGNATURE-----
