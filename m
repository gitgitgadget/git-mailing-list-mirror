From: =?Big5?B?pEG7xL5Z?= <ch3cooli@gmail.com>
Subject: bash completion patch
Date: Wed, 5 Feb 2014 23:13:33 +0800
Message-ID: <CAHtLG6Qgxq84Eo__vaXw5RAmyRuPnK-pt6n36+cjT8nVnRQN=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=047d7bdc0d6c41fb6d04f1aa33d2
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 05 16:13:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB4Aa-0000XI-8c
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 16:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbaBEPNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 10:13:35 -0500
Received: from mail-vb0-f42.google.com ([209.85.212.42]:51857 "EHLO
	mail-vb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbaBEPNe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 10:13:34 -0500
Received: by mail-vb0-f42.google.com with SMTP id i3so384482vbh.29
        for <git@vger.kernel.org>; Wed, 05 Feb 2014 07:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=eveNodSVlP9RrFFoH1cmHezWrkp17JhhVmvGrrXeAe4=;
        b=hWaTsECWyXvqaBjpAUuCYqzaYA3QdWGrAo7YvYH74Qcp9JOpf4W2nmsNKrX4sGYATF
         036F7jqf/suvhy7VkGQYZG6yv96+aENdJM2nVGXXjgOLXYvqxuozXCWhlDiMI0zWxVU3
         JeOiGOepjRQR5ag935h05wlitPjl7huYnBxoep85xFEn5EzJwh2XgvkwrkTIsqPnxq1n
         uQ2KSZvoizlaPU6iMNMLTDkR0fcVHHoLpwA8DQ6FYYsUbR/Bd/sLQZO88YT6DOZZUgr3
         jhwYa8N/LxXRfaFEQRXLp+USW/Xwz5eyMds4SE3PLveeV0yC1SXeGC3T/cxXE9xIuv+d
         ftgw==
X-Received: by 10.59.10.130 with SMTP id ea2mr208905ved.55.1391613213526; Wed,
 05 Feb 2014 07:13:33 -0800 (PST)
Received: by 10.220.151.139 with HTTP; Wed, 5 Feb 2014 07:13:33 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241603>

--047d7bdc0d6c41fb6d04f1aa33d2
Content-Type: text/plain; charset=ISO-8859-1

add --recurse-submodules

--047d7bdc0d6c41fb6d04f1aa33d2
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-bash-completion-Add-recurse-submodules.patch"
Content-Disposition: attachment; 
	filename="0001-bash-completion-Add-recurse-submodules.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hraqjw7r0

RnJvbSAwMzkwYTI0ZTI2NTNlMGNkYjZiZmI5YTU2OWMyOGU0ZDU4MDAyMDM4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdXAgWXV0IFN1bSA8Y2gzY29vbGlAZ21haWwuY29tPgpEYXRl
OiBXZWQsIDUgRmViIDIwMTQgMjM6MDk6NDYgKzA4MDAKU3ViamVjdDogW1BBVENIIDEvMV0gYmFz
aCBjb21wbGV0aW9uOiBBZGQgLS1yZWN1cnNlLXN1Ym1vZHVsZXMKCi0tLQogY29udHJpYi9jb21w
bGV0aW9uL2dpdC1jb21wbGV0aW9uLmJhc2ggfCAxOSArKysrKysrKysrKysrKysrKystCiAxIGZp
bGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L2NvbnRyaWIvY29tcGxldGlvbi9naXQtY29tcGxldGlvbi5iYXNoIGIvY29udHJpYi9jb21wbGV0
aW9uL2dpdC1jb21wbGV0aW9uLmJhc2gKaW5kZXggOTUyNTM0My4uODdkZTgwOSAxMDA2NDQKLS0t
IGEvY29udHJpYi9jb21wbGV0aW9uL2dpdC1jb21wbGV0aW9uLmJhc2gKKysrIGIvY29udHJpYi9j
b21wbGV0aW9uL2dpdC1jb21wbGV0aW9uLmJhc2gKQEAgLTEyMjEsMTQgKzEyMjEsMjAgQEAgX2dp
dF9kaWZmdG9vbCAoKQogCV9fZ2l0X2NvbXBsZXRlX3Jldmxpc3RfZmlsZQogfQogCitfX2dpdF9m
ZXRjaF9yZWN1cnNlX3N1Ym1vZHVsZXM9InllcyBvbi1kZW1hbmQgbm8iCisKIF9fZ2l0X2ZldGNo
X29wdGlvbnM9IgogCS0tcXVpZXQgLS12ZXJib3NlIC0tYXBwZW5kIC0tdXBsb2FkLXBhY2sgLS1m
b3JjZSAtLWtlZXAgLS1kZXB0aD0KLQktLXRhZ3MgLS1uby10YWdzIC0tYWxsIC0tcHJ1bmUgLS1k
cnktcnVuCisJLS10YWdzIC0tbm8tdGFncyAtLWFsbCAtLXBydW5lIC0tZHJ5LXJ1biAtLXJlY3Vy
c2Utc3VibW9kdWxlcz0KICIKIAogX2dpdF9mZXRjaCAoKQogewogCWNhc2UgIiRjdXIiIGluCisJ
LS1yZWN1cnNlLXN1Ym1vZHVsZXM9KikKKwkJX19naXRjb21wICIkX19naXRfZmV0Y2hfcmVjdXJz
ZV9zdWJtb2R1bGVzIiAiIiAiJHtjdXIjIy0tcmVjdXJzZS1zdWJtb2R1bGVzPX0iCisJCXJldHVy
bgorCQk7OwogCS0tKikKIAkJX19naXRjb21wICIkX19naXRfZmV0Y2hfb3B0aW9ucyIKIAkJcmV0
dXJuCkBAIC0xNTgzLDYgKzE1ODksMTAgQEAgX2dpdF9wdWxsICgpCiAJX19naXRfY29tcGxldGVf
c3RyYXRlZ3kgJiYgcmV0dXJuCiAKIAljYXNlICIkY3VyIiBpbgorCS0tcmVjdXJzZS1zdWJtb2R1
bGVzPSopCisJCV9fZ2l0Y29tcCAiJF9fZ2l0X2ZldGNoX3JlY3Vyc2Vfc3VibW9kdWxlcyIgIiIg
IiR7Y3VyIyMtLXJlY3Vyc2Utc3VibW9kdWxlcz19IgorCQlyZXR1cm4KKwkJOzsKIAktLSopCiAJ
CV9fZ2l0Y29tcCAiCiAJCQktLXJlYmFzZSAtLW5vLXJlYmFzZQpAQCAtMTU5NSw2ICsxNjA1LDgg
QEAgX2dpdF9wdWxsICgpCiAJX19naXRfY29tcGxldGVfcmVtb3RlX29yX3JlZnNwZWMKIH0KIAor
X19naXRfcHVzaF9yZWN1cnNlX3N1Ym1vZHVsZXM9ImNoZWNrIG9uLWRlbWFuZCIKKwogX2dpdF9w
dXNoICgpCiB7CiAJY2FzZSAiJHByZXYiIGluCkBAIC0xNjA3LDEwICsxNjE5LDE1IEBAIF9naXRf
cHVzaCAoKQogCQlfX2dpdGNvbXBfbmwgIiQoX19naXRfcmVtb3RlcykiICIiICIke2N1ciMjLS1y
ZXBvPX0iCiAJCXJldHVybgogCQk7OworCS0tcmVjdXJzZS1zdWJtb2R1bGVzPSopCisJCV9fZ2l0
Y29tcCAiJF9fZ2l0X3B1c2hfcmVjdXJzZV9zdWJtb2R1bGVzIiAiIiAiJHtjdXIjIy0tcmVjdXJz
ZS1zdWJtb2R1bGVzPX0iCisJCXJldHVybgorCQk7OwogCS0tKikKIAkJX19naXRjb21wICIKIAkJ
CS0tYWxsIC0tbWlycm9yIC0tdGFncyAtLWRyeS1ydW4gLS1mb3JjZSAtLXZlcmJvc2UKIAkJCS0t
cmVjZWl2ZS1wYWNrPSAtLXJlcG89IC0tc2V0LXVwc3RyZWFtCisJCQktLXJlY3Vyc2Utc3VibW9k
dWxlcz0KIAkJIgogCQlyZXR1cm4KIAkJOzsKLS0gCjEuOC41LjIKCg==
--047d7bdc0d6c41fb6d04f1aa33d2--
