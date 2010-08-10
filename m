From: James <purpleidea@gmail.com>
Subject: [Patch] Use a default for a bad env config file variable
Date: Tue, 10 Aug 2010 11:11:16 -0400
Message-ID: <AANLkTi=42V8=26oEwcNOHubuK+VAf-QaYnvCLAKQ0xtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636417b2d698c7b048d798b00
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 17:11:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiqU7-0003kP-4X
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 17:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198Ab0HJPLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 11:11:18 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:40362 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932129Ab0HJPLR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 11:11:17 -0400
Received: by pxi10 with SMTP id 10so101505pxi.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 08:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=5PLoiYyLbDBkaKx3QcbBug78goDPnpDyncTX4vNISYI=;
        b=IMIlTrUUGSCIQb4v2DmJ+YvLQ49+coDtH77PCxNJNLpVEA07Gq/fXQxSuctF8s9BdQ
         bjgueAk1siQJ6hOGiQ0rlVMemt7u5aToAysT4bIjVeeUmlV5RsDtm6qb4c07767I3R2u
         XZ+vRPeRzPxSUr7vjpV83/3T/NvtgirJcl3xI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=WAXZzwPEYe/Mnw9pRAY8lbbli0hFdSe/pzgRSKN8NlTuFLj+pgOqH/ws8KQmG/swgw
         aizRqIYWmj+gqRogT3fXHIeq1tfLl7/PGFi46Mm70T6jPdb8yD+6icFb7MRX/YwBDNbl
         6SZIypV9t9MTOXQr0RFITUDBP13FQRhC1elq4=
Received: by 10.114.26.6 with SMTP id 6mr15975794waz.82.1281453076306; Tue, 10 
	Aug 2010 08:11:16 -0700 (PDT)
Received: by 10.220.46.69 with HTTP; Tue, 10 Aug 2010 08:11:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153117>

--001636417b2d698c7b048d798b00
Content-Type: text/plain; charset=UTF-8

Hi git list, my name is James, and this is my first patch.

It's quite trivial really, all that changes is that if someone sets
the environment variable: $GITWEB_CONFIG_SYSTEM, and this points to
something like: /srv/gitosis/gitweb.conf, which doesn't actually
exist, then gitweb will default to trying out the built in default of
/etc/gitweb.conf (if it was built with that var).

This patch should make it easier for people who are configuring
gitweb+gitosis, so that a separate gitweb.conf config file can be used
to call the main config, but which doesn't null out the system
defaults if it is missing.

Thank you in advance,
_James

--001636417b2d698c7b048d798b00
Content-Type: application/octet-stream; 
	name="0001-Use-a-default-for-a-bad-env-config-file-variable.patch"
Content-Disposition: attachment; 
	filename="0001-Use-a-default-for-a-bad-env-config-file-variable.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gcovc33r

RnJvbSBkMjlhZGY4Yzc4OGI4YTc0N2JmZDM4ZGQ3ZTEwZjY4NGRlOWFhOGU5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYW1lcyBTaHViaW4gPHB1cnBsZWlkZWFAZ21haWwuY29tPgpE
YXRlOiBUdWUsIDEwIEF1ZyAyMDEwIDEwOjMwOjIyIC0wNDAwClN1YmplY3Q6IFtQQVRDSF0gVXNl
IGEgZGVmYXVsdCBmb3IgYSBiYWQgZW52IGNvbmZpZyBmaWxlIHZhcmlhYmxlLgoKLS0tCiBnaXR3
ZWIvZ2l0d2ViLnBlcmwgfCAgICA0ICsrKysKIDEgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2dpdHdlYi9naXR3ZWIucGVybCBiL2dp
dHdlYi9naXR3ZWIucGVybAppbmRleCA0ZWZlZWJjLi40MzI5NGUxIDEwMDc1NQotLS0gYS9naXR3
ZWIvZ2l0d2ViLnBlcmwKKysrIGIvZ2l0d2ViL2dpdHdlYi5wZXJsCkBAIC02MDUsNiArNjA1LDEw
IEBAIHN1YiBldmFsdWF0ZV9naXR3ZWJfY29uZmlnIHsKIAl9IGVsc2lmICgtZSAkR0lUV0VCX0NP
TkZJR19TWVNURU0pIHsKIAkJZG8gJEdJVFdFQl9DT05GSUdfU1lTVEVNOwogCQlkaWUgJEAgaWYg
JEA7CisJIyBpZiBjb25maWcgZmlsZSBmcm9tIGVudiBpcyBtaXNzaW5nLCB0aGVuIHRyeSB0aGUg
ZGVmYXVsdCBhbnl3YXlzCisJfSBlbHNpZiAoLWUgIisrR0lUV0VCX0NPTkZJR19TWVNURU0rKyIp
IHsKKwkJZG8gIisrR0lUV0VCX0NPTkZJR19TWVNURU0rKyI7CisJCWRpZSAkQCBpZiAkQDsKIAl9
CiB9CiAKLS0gCjEuNy4wLjQKCg==
--001636417b2d698c7b048d798b00--
