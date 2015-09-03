From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v5] git-p4: add config git-p4.pathEncoding
Date: Thu, 3 Sep 2015 17:20:35 +0200
Message-ID: <5E77893F-8E13-4696-B7A6-46E10FE41989@gmail.com>
References: <1441226355-61103-1-git-send-email-larsxschneider@gmail.com> <1441226355-61103-2-git-send-email-larsxschneider@gmail.com> <983771583.1014619.1441268816360.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, luke@diamand.org, gitster@pobox.com,
	tboegi@web.de, sunshine@sunshineco.com
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 03 17:20:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXWJi-0003aK-Mc
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 17:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756920AbbICPUn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Sep 2015 11:20:43 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37710 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755526AbbICPUj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Sep 2015 11:20:39 -0400
Received: by wicfx3 with SMTP id fx3so56139079wic.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 08:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=oOZuFTico2HlgZ3CLH9nwt1CnCAeOnFuMeQYlM4oL2M=;
        b=nkEczWeGo+s5ffHpJATZ8pA2F7yIZt1SJ5NshVjYuyyTjopPaMRd7ALZt2acW+mx6W
         OUdUtO2xvjebnSE0VkmsLz2y/cFIEID9fwRNKMS69J1IAwrn1I+xlLSEI0bMJ4H6wxWH
         1ZCHBRpksWTH4zGMMC+512hFHR+rW7DjYtkc3CXEzlpJCWHrlK09blg7YfY68e0UYIiO
         lkWY8EXkMTZIQRcY1gl+aQRfSKNLH2sRWZPZ/p//PJ1npAFtQpn0LabyXSpwPzM8iZm2
         fJsTz18oERI5EPU6axh0iYikZDIoMRqhZ3AxlAeXEH7i8FwubMWQ8KrXoZ6HK3xGcyNx
         pHxA==
X-Received: by 10.180.109.67 with SMTP id hq3mr15465672wib.40.1441293637965;
        Thu, 03 Sep 2015 08:20:37 -0700 (PDT)
Received: from slxbook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id r8sm9527316wiz.2.2015.09.03.08.20.37
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 08:20:37 -0700 (PDT)
In-Reply-To: <983771583.1014619.1441268816360.JavaMail.zimbra@ensimag.grenoble-inp.fr>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277212>


On 03 Sep 2015, at 10:26, Remi Galan Alfonso <remi.galan-alfonso@ensima=
g.grenoble-inp.fr> wrote:

> Hi Lars,
>=20
> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>> +test_expect_success 'Clone repo containing iso8859-1 encoded paths =
with git-p4.pathEncoding' '
>> +
>> +        test_when_finished cleanup_git &&
>> +        (
>> +                cd "$git" &&
>> +                git init . &&
>> +                git config git-p4.pathEncoding iso8859-1 &&
>=20
> Wouldn't 'test_config' be better here?
>=20
If I got Eric=92s explanation right in "[PATCH v1] t9821: use test_conf=
ig=94 then we should not use =93test_config=94 here?

Thanks,
Lars