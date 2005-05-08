From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: cg-log patches
Date: Sun, 8 May 2005 15:23:50 -0400 (EDT)
Message-ID: <2014.10.10.10.24.1115580230.squirrel@linux1>
References: <1742.10.10.10.24.1115573750.squirrel@linux1>
    <1115574136.9031.147.camel@pegasus>
    <1856.10.10.10.24.1115576809.squirrel@linux1>
    <1115578807.8949.12.camel@pegasus>
    <20050508191831.GD9495@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20050508152350_14916"
Cc: "Marcel Holtmann" <marcel@holtmann.org>,
	"GIT Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 21:22:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUrLX-000241-6P
	for gcvg-git@gmane.org; Sun, 08 May 2005 21:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262975AbVEHT22 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 15:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbVEHT2Q
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 15:28:16 -0400
Received: from simmts12.bellnexxia.net ([206.47.199.141]:35822 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262974AbVEHTXx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2005 15:23:53 -0400
Received: from linux1 ([69.156.111.46]) by simmts12-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050508192350.NGSQ1542.simmts12-srv.bellnexxia.net@linux1>;
          Sun, 8 May 2005 15:23:50 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j48JNoFt027811;
	Sun, 8 May 2005 15:23:50 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sun, 8 May 2005 15:23:50 -0400 (EDT)
In-Reply-To: <20050508191831.GD9495@pasky.ji.cz>
To: "Petr Baudis" <pasky@ucw.cz>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

------=_20050508152350_14916
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Sun, May 8, 2005 3:18 pm, Petr Baudis said:

>> I am not a really good git expert, but maybe another option for it would
>> be fine.
>>
>> However there is another thing that I am missing. With Bitkeeper I was
>> able to do something like "bk changes -umarcel" to list all changes done
>> by the user "marcel". I like to have something similar with cg-log. Any
>> ideas on how to do that?
>
> What should it take in regard? Username portion of the email address?
> The email address itself? The realname?
>

Attached is a new version of cg-log that includes a -u option that takes a
single parameter.   Whatever you put in that parameter will be searched in
the author line, so it can be part or all of an authors name and/or email
address.

So you could do:

cg-log -c -f -u petr

or

cg-log -uxpasky

Sean

------=_20050508152350_14916
Content-Type: application/octet-stream; name="cg-log"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="cg-log"

IyEvdXNyL2Jpbi9lbnYgYmFzaAojCiMgTWFrZSBhIGxvZyBvZiBjaGFuZ2VzIGluIGEgR0lUIGJy
YW5jaC4KIyBDb3B5cmlnaHQgKGMpIFBldHIgQmF1ZGlzLCAyMDA1LgojIENvcHlyaWdodCAoYykg
RGF2aWQgV29vZGhvdXNlLCAyMDA1LgojIENvcHlyaWdodCAoYykgU2VhbiBFc3RhYnJvb2tzLCAy
MDA1LgojCiMgVGFrZXMgYSAtYyBvcHRpb24gdG8gYWRkIGNvbG9yIHRvIHRoZSBvdXRwdXQuCiMg
Q3VycmVudGx5LCB0aGUgY29sb3JzIGFyZToKIwojCWhlYWRlcgkJR3JlZW4JCiMJYXV0aG9yIAkJ
Q3lhbgojCWNvbW1pdHRlcglNYWdlbnRhCiMJZmlsZXMJCUJsdWUKIwlzaWdub2ZmCQlZZWxsb3cK
IwojIFRha2VzIGFuIC1mIG9wdGlvbiB0byBsaXN0IHdoaWNoIGZpbGVzIHdhcyBjaGFuZ2VkLgoj
CiMgVGFrZXMgYW4gLXIgZm9sbG93ZWQgd2l0aCBpZCByZXNvbHZpbmcgdG8gYSBjb21taXQgdG8g
c3RhcnQgZnJvbQojIChIRUFEIGJ5IGRlZmF1bHQpLCBvciBpZDE6aWQyIHJlcHJlc2VudGluZyBh
biAoaWQxO2lkMl0gcmFuZ2UKIyBvZiBjb21taXRzIHRvIHNob3cuCiMKIyBUaGUgcmVzdCBvZiBh
cmd1bWVudHMgYXJlIHRvb2sgYXMgZmlsZW5hbWVzOyBjZy1sb2cgdGhlbiBkaXNwbGF5cwojIG9u
bHkgY2hhbmdlcyBpbiB0aG9zZSBmaWxlcy4KCi4gY2ctWGxpYgojIFRyeSB0byBmaXggdGhlIGFu
bm95aW5nICJCcm9rZW4gcGlwZSIgb3V0cHV0LiBNYXkgbm90IGhlbHAsIGJ1dCBhcHBhcmVudGx5
CiMgYXQgbGVhc3Qgc29tZXdoZXJlIGl0IGRvZXMuIEJhc2ggaXMgYnJva2VuLgp0cmFwIGV4aXQg
U0lHUElQRQoKY29saGVhZGVyPQpjb2xhdXRob3I9CmNvbGNvbW1pdHRlcj0KY29sZmlsZXM9CmNv
bHNpZ25vZmY9CmNvbGRlZmF1bHQ9CgpsaXN0X2ZpbGVzPQoKbG9nX3N0YXJ0PQpsb2dfZW5kPQoK
dXNlcj0KCndoaWxlIGdldG9wdHMgY2ZyOnU6IG8KZG8KCWNhc2UgJG8gaW4KCWMpCSMgU2VlIHRl
cm1pbmZvKDUpLCAiQ29sb3IgSGFuZGxpbmciCgkJY29saGVhZGVyPSIkKHRwdXQgc2V0YWYgMiki
ICAgICMgR3JlZW4KCQljb2xhdXRob3I9IiQodHB1dCBzZXRhZiA2KSIgICAgIyBDeWFuCgkJY29s
Y29tbWl0dGVyPSIkKHRwdXQgc2V0YWYgNSkiICMgTWFnZW50YQoJCWNvbGZpbGVzPSIkKHRwdXQg
c2V0YWYgNCkiICAgICAjIEJsdWUKCQljb2xzaWdub2ZmPSIkKHRwdXQgc2V0YWYgMykiICAgIyBZ
ZWxsb3cKCQljb2xkZWZhdWx0PSIkKHRwdXQgb3ApIiAgICAgICAgIyBSZXN0b3JlIGRlZmF1bHQK
CQk7OwoJZikJbGlzdF9maWxlcz0xIAoJCTs7CglyKQlpZiBbIC16ICRsb2dfc3RhcnQgXTsgdGhl
bgoJCQlsb2dfc3RhcnQ9IiR7T1BUQVJHLzoqfSIKCQkJWyAkT1BUQVJHICE9ICRsb2dfc3RhcnQg
XSAmJiBsb2dfZW5kPSIke09QVEFSRy8qOn0iCgkJZWxzZQlsb2dfZW5kPSIkT1BUQVJHIgoJCWZp
CgkJOzsKCXUpCXVzZXI9IiRPUFRBUkciCgkJOzsKCSopCWV4aXQgMQoJCTs7Cgllc2FjCmRvbmUK
c2hpZnQgJCgoT1BUSU5ELTEpKQoKbGlzdF9jb21taXRfZmlsZXMoKQp7CgllY2hvCglpZiBbIC16
ICQyIF07IHRoZW4KCQlnaXQtbHMtdHJlZSAkMSAgIyBMaXN0IGFsbCBmaWxlcyBmb3IgaW5pdGlh
bCBjb21taXQKCWVsc2UJCgkJbG9jYWwgdHJlZTE9JDE7IHNoaWZ0CgkJZm9yIHRyZWUyOyBkbwoJ
CQlnaXQtZGlmZi10cmVlIC1yICR0cmVlMSAkdHJlZTIKCQlkb25lCglmaSB8IGN1dCAtZjQgfCBz
b3J0IC11IHwgY29sdW1uIHwgY29sdW1uIC10IHwgXAoJc2VkICJzL14vJGNvbGZpbGVzICAgICog
LztzLyQvJGNvbGRlZmF1bHQvIgp9CgppZDE9IiQoY29tbWl0LWlkICRsb2dfc3RhcnQpIiB8fCBl
eGl0IDEKaWYgWyAiJGxvZ19lbmQiIF07IHRoZW4KCWlkMj0iJChjb21taXQtaWQgJGxvZ19lbmQp
IiB8fCBleGl0IDEKCWdpdC1yZXYtdHJlZSAkaWQyIF4kaWQxIHwgc29ydCAtcm4gfCBjdXQgLWQn
ICcgLWYyCmVsc2UKCWdpdC1yZXYtbGlzdCAkaWQxCmZpIHwgXAp3aGlsZSByZWFkIGNvbW1pdApk
bwoJdHJhcCBleGl0IFNJR1BJUEUKCXRyZWVzPQoJaWYgWyAkIyAtbmUgMCBdOyB0aGVuCgkJcGFy
ZW50PSQoZ2l0LWNhdC1maWxlIGNvbW1pdCAkY29tbWl0IHwgc2VkIC1uICcycy9wYXJlbnQgLy9w
OzJRJykKCQlbICIkcGFyZW50IiBdICYmIFsgIiQoZ2l0LWRpZmYtdHJlZSAtciAkY29tbWl0ICRw
YXJlbnQgIiRAIikiIF0gfHwgY29udGludWUKCWZpCglpZiBbICEgLXogIiR1c2VyIiBdOyB0aGVu
CgkJZ2l0LWNhdC1maWxlIGNvbW1pdCAkY29tbWl0IHwgZ3JlcCAnXmF1dGhvciAnIHwgZ3JlcCAt
cWkgIiR1c2VyIiB8fCBjb250aW51ZQoJZmkKCWVjaG8gJGNvbGhlYWRlciIiY29tbWl0ICR7Y29t
bWl0JToqfSAkY29sZGVmYXVsdDsKCWdpdC1jYXQtZmlsZSBjb21taXQgJGNvbW1pdCB8IFwKCQl3
aGlsZSByZWFkIGtleSByZXN0OyBkbwoJCQl0cmFwIGV4aXQgU0lHUElQRQoJCQljYXNlICIka2V5
IiBpbgoJCQkiYXV0aG9yInwiY29tbWl0dGVyIikKCQkJCWlmIFsgIiRrZXkiID0gImF1dGhvciIg
XTsgdGhlbgoJCQkJCWNvbG9yPSIkY29sYXV0aG9yIgoJCQkJZWxzZQoJCQkJCWNvbG9yPSIkY29s
Y29tbWl0dGVyIgoJCQkJZmkKCgkJCQlkYXRlPSgke3Jlc3QjKj4gfSkKCQkJCXBkYXRlPSIkKHNo
b3dkYXRlICRkYXRlKSIKCQkJCWlmIFsgIiRwZGF0ZSIgXTsgdGhlbgoJCQkJCWVjaG8gLW4gJGNv
bG9yJGtleSAkcmVzdCB8IHNlZCAicy8+LiovPiAkcGRhdGUvIgoJCQkJCWVjaG8gJGNvbGRlZmF1
bHQKCQkJCWVsc2UKCQkJCQllY2hvICRjb2xvciRrZXkgJHJlc3QgJGNvbGRlZmF1bHQKCQkJCWZp
CgkJCQk7OwoJCQkidHJlZSJ8InBhcmVudCIpCgkJCQl0cmVlcz0iJHRyZWVzICRyZXN0IgoJCQkJ
ZWNobyAkY29saGVhZGVyJGtleSAkcmVzdCAkY29sZGVmYXVsdAoJCQkJOzsKCQkJIiIpCgkJCQll
Y2hvOyBzZWQgLXJlICIKCQkJCSBzL14oZnJvbXxjY3xzaWduZWQub2ZmLmJ5fGFja2VkLmJ5KTog
LiovJGNvbHNpZ25vZmYmJGNvbGRlZmF1bHQvSQoJCQkJIHMvXi8gICAgLyIKCQkJCVsgLW4gIiRs
aXN0X2ZpbGVzIiBdICYmIGxpc3RfY29tbWl0X2ZpbGVzICR0cmVlcwoJCQkJOzsKCQkJKikKCQkJ
CWVjaG8gJGNvbGhlYWRlciRrZXkgJHJlc3QgJGNvbGRlZmF1bHQKCQkJCTs7CgkJCWVzYWMKCgkJ
ZG9uZQoJZWNobwpkb25lIHwgJHtQQUdFUjotbGVzc30gJHtQQUdFUl9GTEFHUzotLVJ9Cg==
------=_20050508152350_14916--


