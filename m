From: =?windows-1251?B?wOvl6vHl6SDK8OXn7uI=?= <zapped@mail.ru>
Subject: Bug reports & patches: git-svn, git-completion, git diff hunk headers for Pascal
Date: Fri, 24 Dec 2010 15:46:26 +0300
Message-ID: <6110634424.20101224154626@mail.ru>
Reply-To: =?windows-1251?B?wOvl6vHl6SDK8OXn7uI=?= <zapped@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----------437225415D421EF"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 24 13:51:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PW77g-0000pX-3r
	for gcvg-git-2@lo.gmane.org; Fri, 24 Dec 2010 13:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293Ab0LXMvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Dec 2010 07:51:44 -0500
Received: from fallback3.mail.ru ([94.100.176.58]:60189 "EHLO
	fallback3.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180Ab0LXMvn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Dec 2010 07:51:43 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Dec 2010 07:51:42 EST
Received: from smtp6.mail.ru (smtp6.mail.ru [94.100.176.48])
	by fallback3.mail.ru (mPOP.Fallback_MX) with ESMTP id 5BE294A0368A
	for <git@vger.kernel.org>; Fri, 24 Dec 2010 15:47:01 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Content-Type:MIME-Version:Subject:To:Message-ID:Reply-To:From:Date; bh=PIa08eYBZxxpD3D3t9T/X0pWuD7sWQbdM4PveBAWZGI=;
	b=u2esQDsnvX2cT3tDn4zwef+MjfHSKjeb3FSkGoeWSFu8HAO1bIS7tFXqL2Ipzfe4wELD7/f63n7XT6MoZYX75PWHEfq/OAVDe9LlwsrvxUD+zAfTDGR7OSe+MGGp/DnE;
Received: from [83.237.54.31] (port=22946 helo=ppp83-237-54-31.pppoe.mtu-net.ru)
	by smtp6.mail.ru with asmtp 
	id 1PW72R-0002BT-00
	for git@vger.kernel.org; Fri, 24 Dec 2010 15:46:27 +0300
X-Mailer: The Bat! (v3.99.3) Professional
X-Priority: 3 (Normal)
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164153>

------------437225415D421EF
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello!
I've found some bugs in Git:
1. git-svn:
  git svn set-tree/dcommit do not respect svn.pathnameencoding config variable
  although git svn fetch does
  here is the my patch - see attach git-svn.patch
2. git-completion
  when GIT_PS1_SHOWDIRTYSTATE is set diff.ignoreSubmodules config
  variable is not respected
  here is the my patch - see attach git-completion.bash.patch
3. CLASS procedures/functions are not detected (just
procedures/functions do) in hunk headers
for git diff for Pascal files
  here is the my patch - see attach userdiff.c.patch

P.S. All patches is against Git v1.7.3.4
  

mailto:zapped@mail.ru
------------437225415D421EF
Content-Type: application/octet-stream;
 name="userdiff.c.patch"
Content-transfer-encoding: base64
Content-Disposition: attachment;
 filename="userdiff.c.patch"

ZGlmZiAtLWdpdCBhL3VzZXJkaWZmLmMgYi91c2VyZGlmZi5jCmluZGV4IGY5ZTA1YjUuLjI1
OWEzODIgMTAwNjQ0Ci0tLSBhL3VzZXJkaWZmLmMKKysrIGIvdXNlcmRpZmYuYwpAQCAtNTIs
NyArNTIsNyBAQCBQQVRURVJOUygib2JqYyIsCiAJICJ8Wy0rKi88PiUmXnw9IV09fC0tfFxc
K1xcK3w8PD0/fD4+PT98JiZ8XFx8XFx8fDo6fC0+IgogCSAifFteWzpzcGFjZTpdXXxbXHg4
MC1ceGZmXSsiKSwKIFBBVFRFUk5TKCJwYXNjYWwiLAotCSAiXigocHJvY2VkdXJlfGZ1bmN0
aW9ufGNvbnN0cnVjdG9yfGRlc3RydWN0b3J8aW50ZXJmYWNlfCIKKwkgIl4oKChjbGFzc1sg
XHRdKyk/KHByb2NlZHVyZXxmdW5jdGlvbil8Y29uc3RydWN0b3J8ZGVzdHJ1Y3RvcnxpbnRl
cmZhY2V8IgogCQkiaW1wbGVtZW50YXRpb258aW5pdGlhbGl6YXRpb258ZmluYWxpemF0aW9u
KVsgXHRdKi4qKSQiCiAJICJcbiIKIAkgIl4oLio9WyBcdF0qKGNsYXNzfHJlY29yZCkuKikk
IiwK
------------437225415D421EF
Content-Type: application/octet-stream;
 name="git-svn.patch"
Content-transfer-encoding: base64
Content-Disposition: attachment;
 filename="git-svn.patch"

ZGlmZiAtLWdpdCBhL2dpdC1zdm4ucGVybCBiL2dpdC1zdm4ucGVybAppbmRleCA3NTdkZTgy
Li4zOTliZjRjIDEwMDc1NQotLS0gYS9naXQtc3ZuLnBlcmwKKysrIGIvZ2l0LXN2bi5wZXJs
CkBAIC00NDUxLDYgKzQ0NTEsNyBAQCBzdWIgbmV3IHsKIAkkc2VsZi0+e3BhdGhfcHJlZml4
fSA9IGxlbmd0aCAkc2VsZi0+e3N2bl9wYXRofSA/CiAJICAgICAgICAgICAgICAgICAgICAg
ICAiJHNlbGYtPntzdm5fcGF0aH0vIiA6ICcnOwogCSRzZWxmLT57Y29uZmlnfSA9ICRvcHRz
LT57Y29uZmlnfTsKKwkkc2VsZi0+e3BhdGhuYW1lZW5jb2Rpbmd9ID0gR2l0Ojpjb25maWco
J3N2bi5wYXRobmFtZWVuY29kaW5nJyk7CiAJcmV0dXJuICRzZWxmOwogfQogCg==
------------437225415D421EF
Content-Type: application/octet-stream;
 name="git-completion.bash.patch"
Content-transfer-encoding: base64
Content-Disposition: attachment;
 filename="git-completion.bash.patch"

ZGlmZiAtLWdpdCBhL2NvbnRyaWIvY29tcGxldGlvbi9naXQtY29tcGxldGlvbi5iYXNoIGIv
Y29udHJpYi9jb21wbGV0aW9uL2dpdC1jb21wbGV0aW9uLmJhc2gKaW5kZXggZDMwMzdmYy4u
NTBmYzM4NSAxMDA3NTUKLS0tIGEvY29udHJpYi9jb21wbGV0aW9uL2dpdC1jb21wbGV0aW9u
LmJhc2gKKysrIGIvY29udHJpYi9jb21wbGV0aW9uL2dpdC1jb21wbGV0aW9uLmJhc2gKQEAg
LTI4MCw3ICsyODAsOCBAQCBfX2dpdF9wczEgKCkKIAkJZWxpZiBbICJ0cnVlIiA9ICIkKGdp
dCByZXYtcGFyc2UgLS1pcy1pbnNpZGUtd29yay10cmVlIDI+L2Rldi9udWxsKSIgXTsgdGhl
bgogCQkJaWYgWyAtbiAiJHtHSVRfUFMxX1NIT1dESVJUWVNUQVRFLX0iIF07IHRoZW4KIAkJ
CQlpZiBbICIkKGdpdCBjb25maWcgLS1ib29sIGJhc2guc2hvd0RpcnR5U3RhdGUpIiAhPSAi
ZmFsc2UiIF07IHRoZW4KLQkJCQkJZ2l0IGRpZmYgLS1uby1leHQtZGlmZiAtLXF1aWV0IC0t
ZXhpdC1jb2RlIHx8IHc9IioiCisJCQkJCWlzPSQoZ2l0IGNvbmZpZyBkaWZmLmlnbm9yZVN1
Ym1vZHVsZXMpCisJCQkJCWdpdCBkaWZmIC0tbm8tZXh0LWRpZmYgLS1xdWlldCAtLWV4aXQt
Y29kZSAtLWlnbm9yZS1zdWJtb2R1bGVzPSRpcyB8fCB3PSIqIgogCQkJCQlpZiBnaXQgcmV2
LXBhcnNlIC0tcXVpZXQgLS12ZXJpZnkgSEVBRCA+L2Rldi9udWxsOyB0aGVuCiAJCQkJCQln
aXQgZGlmZi1pbmRleCAtLWNhY2hlZCAtLXF1aWV0IEhFQUQgLS0gfHwgaT0iKyIKIAkJCQkJ
ZWxzZQo=
------------437225415D421EF--
