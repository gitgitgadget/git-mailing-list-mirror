From: Adam Monsen <haircut@gmail.com>
Subject: Re: [PATCH 0/3] "commit --template" fixes
Date: Thu, 05 Apr 2012 07:29:53 -0700
Message-ID: <4F7DAC61.3000104@gmail.com>
References: <7vaa2ylzrm.fsf@alter.siamese.dyndns.org> <1333136719-12657-1-git-send-email-gitster@pobox.com> <4F775ACF.50007@gmail.com> <7vaa2vhyso.fsf@alter.siamese.dyndns.org> <4F7B2F35.40807@gmail.com> <7v1uo4cwg7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig845A5989EAD5B80082DB039D"
Cc: git@vger.kernel.org, Ivan Heffner <iheffner@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 16:30:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFnhL-0007Jg-RJ
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 16:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214Ab2DEO36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 10:29:58 -0400
Received: from mail-qa0-f42.google.com ([209.85.216.42]:49937 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779Ab2DEO35 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 10:29:57 -0400
Received: by qafi31 with SMTP id i31so1752973qaf.1
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 07:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        bh=JtikYZrcjqFQ2oyKOocSv85hW6v/VLLbmxBs4a9dX1Y=;
        b=xebvCA67TbeuIzB8gy2aK8Qc1rxOsjd7MpdgoPAFnQL3Z8LS26ZnouWy1MdibtwbMP
         VipCWNMG2q/7zc1p325LCiwESUyx7zYFDoiLG+25sAKLuwy8rOPMgzW6sI5O4ZB8KoH7
         mP9NH6Tw8m/gOCiwfGolUIWKG80k7Fjs+5wNRrMdZL3CYa9riezZMY9wpUftQHyH3TfM
         kmreEvCZLxOGb55d6c7X4ov8sV1ScoNCHXx9cqLYuhHM/WOYHZWZM0q2oowImb0iVsAH
         yZRFlVUqsszUJXf05fP78Lofbbvj+4gYUik0DMMyq7vkiLlBZDYyfP9PbDYcXYkNwm41
         vP6A==
Received: by 10.224.185.82 with SMTP id cn18mr4155770qab.97.1333636196994;
        Thu, 05 Apr 2012 07:29:56 -0700 (PDT)
Received: from [192.168.13.92] (c-67-183-137-177.hsd1.wa.comcast.net. [67.183.137.177])
        by mx.google.com with ESMTPS id i8sm6347670qah.4.2012.04.05.07.29.54
        (version=SSLv3 cipher=OTHER);
        Thu, 05 Apr 2012 07:29:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
In-Reply-To: <7v1uo4cwg7.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194775>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig845A5989EAD5B80082DB039D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/03/2012 02:55 PM, Junio C Hamano wrote:
> When editing the commit message, start the editor with the contents in =
the
> given file.  The `commit.template` configuration variable is often used=
 to
> give this option implicitly to the command.  This mechanism can be used=
 by
> projects that want to guide participants with some hints on what to wri=
te
> in the message in what order.  If the user exits the editor without edi=
ting
> the message, the commit is aborted.  This has no effect when a message =
is
> given by other means, e.g. with the `-m` or `-F` options.

I like it!


--------------enig845A5989EAD5B80082DB039D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJPfaxhAAoJEJtdmT+DbynAesEIAMtvD7IlqoIr+ckd2yv+xdGc
jhZov78OXcguXCIU3x1FonzH8fq863EFe3K5uQyeG9V2mhCQ+JDA+E1xhWbMcbRj
UApvst+O1uZlQAWDlBWXxvMJ/G+RYf8wpl32dSlBsZSgaehRSH5n0btQrxZZd/iL
TIBqqrr5pTzl6tbno3LF8i1y7zAG1S25/Vk/1d7hI7qrS/5bHWmVvYwpoe6wd4GJ
ScDtg/CMxaF/etug0v13ooV/1BLq1HBqp0GWibg7vHse4as7lgch89QFp0xe4lkt
rwxxr62TAmb33lb7X/nedh7fdAS0i3UTnJqTPSzxWg92rgEU5PNdpyNjzHVxMzU=
=x8Iv
-----END PGP SIGNATURE-----

--------------enig845A5989EAD5B80082DB039D--
