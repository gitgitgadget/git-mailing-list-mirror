From: Mark Allen <mrallen1@yahoo.com>
Subject: [PATCH] Make cvs2git support remote CVS repos
Date: Wed, 25 May 2005 11:11:32 -0700 (PDT)
Message-ID: <20050525181132.75705.qmail@web41204.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-895427932-1117044692=:74000"
X-From: git-owner@vger.kernel.org Wed May 25 20:12:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db0KY-0001eo-VH
	for gcvg-git@gmane.org; Wed, 25 May 2005 20:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbVEYSLs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 14:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVEYSLs
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 14:11:48 -0400
Received: from web41204.mail.yahoo.com ([66.218.93.37]:43643 "HELO
	web41204.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262380AbVEYSLd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2005 14:11:33 -0400
Received: (qmail 75707 invoked by uid 60001); 25 May 2005 18:11:32 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=HHihE8FtNlVwNlBU+hxThNzf0T7cFFXEroZuKg70cG7vbw0EypBz8/ywHtKEqkmOUnlvzgGOG173VapytSCl+XCa0MY4n74SnX8qCMNoGI7jNU9LHt9hVW5FVl2mdWQ5JtDSv8kFwYDY3Ree51TBSL9yN8LWaNJQQZevkwPDjEM=  ;
Received: from [65.173.207.2] by web41204.mail.yahoo.com via HTTP; Wed, 25 May 2005 11:11:32 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--0-895427932-1117044692=:74000
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Added a "--module=cvsmodule" command line option and (since we're going to process argv
anyway) made "-v" for verbose mode a command line option too, instead of a compile time
option.

I've tested it on some (small) private CVS repos and it *seems* to work, although some of
the initial commit ordering is wrong, but I think this is due to the commit time being
wrong within my CVS repo itself.

I didn't make author and email prettyprint, but I really want to make it a command line
option, the discussion from yesterday about whether prettyprinting should be at the
plumbing or porcelain layer notwithstanding.

Regards,

--Mark
--0-895427932-1117044692=:74000
Content-Type: application/octet-stream; name="add-remote-cvs.patch"
Content-Transfer-Encoding: base64
Content-Description: 1888918109-add-remote-cvs.patch
Content-Disposition: attachment; filename="add-remote-cvs.patch"

SW5kZXg6IGN2czJnaXQuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBh
MGUwZDM5NDBjMzUwZjE0NTQ1YTQ4MWIxNzkyMTdmNjI2YzkzNDQwL2N2czJn
aXQuYyAgKG1vZGU6MTAwNjQ0KQorKysgdW5jb21taXR0ZWQvY3ZzMmdpdC5j
ICAobW9kZToxMDA2NDQpCkBAIC0zMiw2ICszMiw4IEBACiB9OwogCiBzdGF0
aWMgY2hhciAqcmNzZGlyOworc3RhdGljIGNoYXIgKmN2c3Jvb3Q7CitzdGF0
aWMgY2hhciAqY3ZzbW9kdWxlOwogCiBzdGF0aWMgY2hhciBkYXRlWzEwMF07
CiBzdGF0aWMgY2hhciBhdXRob3JbMTAwXTsKQEAgLTE5NCw5ICsxOTYsMTMg
QEAKIAlpZiAoZGlyKQogCQlwcmludGYoIm1rZGlyIC1wICUuKnNcbiIsIChp
bnQpKGRpciAtIG5hbWUpLCBuYW1lKTsKIAotCWdldF9yY3NfbmFtZShyY3Nw
YXRobmFtZSwgbmFtZSwgZGlyKTsKLQkJCi0JcHJpbnRmKCJjbyAtcSAtcCAt
ciVzICclcycgPiAnJXMnXG4iLCB2ZXJzaW9uLCByY3NwYXRobmFtZSwgbmFt
ZSk7CisJaWYgKCAhY3ZzbW9kdWxlICkgeworCQlnZXRfcmNzX25hbWUocmNz
cGF0aG5hbWUsIG5hbWUsIGRpcik7CisJCXByaW50ZigiY28gLXEgLXAgLXIl
cyAnJXMnID4gJyVzJ1xuIiwgdmVyc2lvbiwgcmNzcGF0aG5hbWUsIG5hbWUp
OworCX0gZWxzZSB7CisJCXByaW50ZigiY3ZzIC1kICVzIGNoZWNrb3V0IC1y
JXMgLXAgJyVzLyVzJyA+ICclcydcbiIsIGN2c3Jvb3QsIHZlcnNpb24sIGN2
c21vZHVsZSwgbmFtZSwgbmFtZSk7CisJfQorCiAJcHJpbnRmKCJnaXQtdXBk
YXRlLWNhY2hlIC0tYWRkIC0tICclcydcbiIsIG5hbWUpOwogfQogCkBAIC0y
MTcsMTMgKzIyMywzNCBAQAogewogCXN0YXRpYyBjaGFyIGxpbmVbMTAwMF07
CiAJZW51bSBzdGF0ZSBzdGF0ZSA9IEhlYWRlcjsKKwlpbnQgaTsKKworCWZv
ciAoaSA9IDE7IGkgPCBhcmdjOyBpKyspIHsKKwkJY29uc3QgY2hhciAqYXJn
ID0gYXJndltpXTsKKwkJaWYgKCFtZW1jbXAoYXJnLCAiLS1tb2R1bGU9Iiwg
OSkpIHsKKwkJCWN2c3Jvb3QgPSBnZXRlbnYoIkNWU1JPT1QiKTsKKwkJCWN2
c21vZHVsZSA9IChjaGFyICopYXJnKzk7CisJCQljb250aW51ZTsKKwkJfSAK
KwkJaWYgKCFzdHJjbXAoYXJnLCAiLXYiKSkgeworCQkJdmVyYm9zZSA9IDE7
CisJCQljb250aW51ZTsKKwkJfQorCX0KKworCWlmICghY3ZzbW9kdWxlKQor
CQlyY3NkaXIgPSBnZXRlbnYoIlJDU0RJUiIpOwogCi0JcmNzZGlyID0gZ2V0
ZW52KCJSQ1NESVIiKTsKLQlpZiAoIXJjc2RpcikgeworCWlmICghY3ZzbW9k
dWxlICYmICFyY3NkaXIpIHsKIAkJZnByaW50ZihzdGRlcnIsICJJIG5lZWQg
YW4gJFJDU0RJUlxuIik7CiAJCWV4aXQoMSk7CiAJfQogCisJaWYgKGN2c21v
ZHVsZSAmJiAhY3Zzcm9vdCkgeworCQlmcHJpbnRmKHN0ZGVyciwgIkkgbmVl
ZCBhICRDVlNST09UXG4iKTsKKwkJZXhpdCgxKTsKKwl9CisKIAlwcmludGYo
IlsgLWQgLmdpdCBdICYmIGV4aXQgMVxuIik7CiAJcHJpbnRmKCJnaXQtaW5p
dC1kYlxuIik7CiAJcHJpbnRmKCJta2RpciAtcCAuZ2l0L3JlZnMvaGVhZHNc
biIpOwo=

--0-895427932-1117044692=:74000--
