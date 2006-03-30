From: Krzysiek Pawlik <krzysiek.pawlik@people.pl>
Subject: [PATCH] Ability to automaticaly push tags to remote repositories.
Date: Thu, 30 Mar 2006 14:56:02 +0200
Message-ID: <442BD562.3030207@people.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030007070600020302090307"
X-From: git-owner@vger.kernel.org Thu Mar 30 14:56:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOwh6-0004zy-3i
	for gcvg-git@gmane.org; Thu, 30 Mar 2006 14:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWC3Mz7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Mar 2006 07:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWC3Mz6
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Mar 2006 07:55:58 -0500
Received: from people.pl ([212.85.96.54]:58050 "HELO v00054.home.net.pl")
	by vger.kernel.org with SMTP id S932196AbWC3Mz6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Mar 2006 07:55:58 -0500
Received: from localhost (HELO ?192.168.1.1?) (krzysiek.pawlik.people@home@127.0.0.1)
  by matrix01.home.net.pl with SMTP; Thu, 30 Mar 2006 12:55:54 -0000
User-Agent: Mail/News 1.5 (X11/20060321)
To: Git Mailing List <git@vger.kernel.org>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=BC555551
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18195>

This is a multi-part message in MIME format.
--------------030007070600020302090307
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


- From `cg-push --long-help`:

- -t TAG::
        Tells cg-push to also push the given tag. Note that in the
        future, cg-push should push tags automatically. Also note
        that even if you pass `cg-push` the '-t' arguments, your
        HEAD is still pushed as well in addition to the tags.

One of possible ways of doing it is in attached patch. Comments,
suggestions?

- --
Krzysiek Pawlik (Nelchael)
RLU #322999 GPG Key ID: 0xBC555551
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEK9Vigo/w9rxVVVERAvXkAJ42ESjs3REY0ECqIYlbz+9WX/3+ZQCfSQs/
B4X6U2io0Wq0/0oiolpUW1g=
=3ZR7
-----END PGP SIGNATURE-----

--------------030007070600020302090307
Content-Type: text/plain;
 name="cg-push-tags.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="cg-push-tags.patch"

QWJpbGl0eSB0byBhdXRvbWF0aWNhbHkgcHVzaCB0YWdzIHRvIHJlbW90ZSByZXBvc2l0b3Jp
ZXMuCgotLS0KY29tbWl0IDZlNTgxY2Y0M2NjZjcyMzZlYTQ3YWM0YmE5YjUxZGY5Y2RhM2M2
NzEKdHJlZSBiNDQwY2I4ZTQ2MjljNWM3N2UzOGZiNjE3OTk5MmI1MmVkZjhjODYxCnBhcmVu
dCA4OTFjNmQ4NWYzOGEzMjZlOTFkNjI5MDZlMTY5NmEzOGQyOGZiMTA1CmF1dGhvciBLcnp5
c2llayBQYXdsaWsgPGtwYXdsaWtAc2lsdmVybWVkaWEucGw+IFRodSwgMzAgTWFyIDIwMDYg
MTQ6NDg6MzYgKzAyMDAKY29tbWl0dGVyIEtyenlzaWVrIFBhd2xpayA8a3Bhd2xpa0BzaWx2
ZXJtZWRpYS5wbD4gVGh1LCAzMCBNYXIgMjAwNiAxNDo0ODozNiArMDIwMAoKIGNnLXB1c2gg
fCAgIDE1ICsrKysrKysrKysrKysrKwogMSBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25z
KCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2NnLXB1c2ggYi9jZy1wdXNoCmlu
ZGV4IDQzMzJiMjguLjg2NWNiZDUgMTAwNzU1Ci0tLSBhL2NnLXB1c2gKKysrIGIvY2ctcHVz
aApAQCAtNDMsMTcgKzQzLDMyIEBAIHNlbmRfcGFja191cGRhdGUoKQogCiBsb2NicmFuY2g9
IiRfZ2l0X2hlYWQiCiB0YWdzPSgpCithdXRvX3B1c2hfdGFncz15ZXMKIHdoaWxlIG9wdHBh
cnNlOyBkbwogCWlmIG9wdHBhcnNlIC1yPTsgdGhlbgogCQlsb2NicmFuY2g9IiRPUFRBUkci
CiAJCVsgIiQoY2ctb2JqZWN0LWlkIC1jICIkbG9jYnJhbmNoIikiIF0gfHwgZXhpdCAxCiAJ
ZWxpZiBvcHRwYXJzZSAtdD07IHRoZW4KIAkJdGFnc1skeyN0YWdzW0BdfV09InJlZnMvdGFn
cy8kT1BUQVJHIgorCQlhdXRvX3B1c2hfdGFncz1ubwogCWVsc2UKIAkJb3B0ZmFpbAogCWZp
CiBkb25lCiAKK2lmIFsgIiR7YXV0b19wdXNoX3RhZ3N9IiA9ICJ5ZXMiIF07IHRoZW4KKwlp
ZiBbICEgLWQgIiRfZ2l0L2NvZ2l0by10YWdzLXB1c2hlZCIgXTsgdGhlbgorCQlta2RpciAi
JF9naXQvY29naXRvLXRhZ3MtcHVzaGVkIiB8fCBkaWUgImNhbid0IGNyZWF0ZSBjYWNoZSBm
b3IgcHVzaGVkIHRhZ3MiCisJZmkKKwlmb3IgaSBpbiBgY2ctdGFnLWxzIHwgYXdrICd7cHJp
bnQgJDF9J2A7IGRvCisJCWlmIFsgISAtZiAiJF9naXQvY29naXRvLXRhZ3MtcHVzaGVkLyR7
aX0iIF07IHRoZW4KKwkJCWVjaG8gIkFkZGluZyAke2l9IHRvIGxpc3Qgb2YgdGFncyB0byBw
dXNoIgorCQkJdGFnc1skeyN0YWdzW0BdfV09InJlZnMvdGFncy8ke2l9IgorCQkJdG91Y2gg
IiRfZ2l0L2NvZ2l0by10YWdzLXB1c2hlZC8ke2l9IgorCQlmaQorCWRvbmUKK2ZpCisKIFsg
JHsjQVJHU1tAXX0gLWd0IDEgXSAmJiBkaWUgInRvbyBtYW55IGFyZ3VtZW50cywgSSBjYW4g
cHVzaCBvbmx5IG9uZSBicmFuY2ggYXQgb25jZSIKIG5hbWU9IiR7QVJHU1swXX0iCiAKCgoM
CiEtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tZmxpcC0KCgo=
--------------030007070600020302090307--
