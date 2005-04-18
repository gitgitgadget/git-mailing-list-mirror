From: randy_dunlap <rdunlap@xenotime.net>
Subject: Re: Re-done kernel archive - real one?
Date: Sun, 17 Apr 2005 18:33:44 -0700
Organization: YPO4
Message-ID: <20050417183344.50145c5b.rdunlap@xenotime.net>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org>
	<1113774736.3884.4.camel@localhost.localdomain>
	<Pine.LNX.4.58.0504171511210.7211@ppc970.osdl.org>
	<20050417152218.3501f2f1.rdunlap@xenotime.net>
	<1113780105.11910.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sun__17_Apr_2005_18_33_44_-0700_pjIY0aihC1gJMda_"
Cc: torvalds@osdl.org, git@vger.kernel.org, hpa@zytor.com
X-From: git-owner@vger.kernel.org Mon Apr 18 03:30:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNL5k-0005QL-Sy
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 03:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVDRBeH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 21:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbVDRBeH
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 21:34:07 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:38374 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261522AbVDRBd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 21:33:56 -0400
Received: from wbar2.sea1-4-5-049-023.sea1.dsl-verizon.net ([4.5.49.23] helo=midway.verizon.net)
	by titan.genwebhost.com with esmtpa (Exim 4.44)
	id 1DNL9C-0002L3-1b; Sun, 17 Apr 2005 21:33:58 -0400
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1113780105.11910.4.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Sun__17_Apr_2005_18_33_44_-0700_pjIY0aihC1gJMda_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Apr 2005 09:21:45 +1000 David Woodhouse wrote:

| On Sun, 2005-04-17 at 15:22 -0700, randy_dunlap wrote:
| > David did the commits-mailing-list script and I'm working on a
| > commits web-page like what was formerly seen at:
| > http://www.kernel.org/pub/linux/kernel/v2.6/testing/cset/
| > (with daily tarball)
| > 
| > based on some older scripts from David, however I'm wondering if
| > a variant of the gitlog.sh script wouldn't be a better starting
| > point for it.
| 
| My commits-list script is in fact based on gitlog.sh. You'll probably
| find useful things to crib from in both that and the original
| bkexport.sh script.

Yep, already had all of that in progress.

| The commits script also wants updating to print the date properly now
| that we've changed how it's stored -- I'll try to find some time this
| week to update it and set it running on master.kernel.org again, but it
| may end up waiting till after LCA.

Here's a working gitgenwebpage.sh script, although it may be possible
to do it better/faster, and merge it with the commits mail script
(as you mentioned).


---
~Randy

--Multipart=_Sun__17_Apr_2005_18_33_44_-0700_pjIY0aihC1gJMda_
Content-Type: application/x-sh;
 name="gitgenwebpage.sh"
Content-Disposition: attachment;
 filename="gitgenwebpage.sh"
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gKIwojIEdlbmVyYXRlIGEgd2ViIHBhZ2Ugb2YgcmVjZW50IGNvbW1pdHMuCiMg
KGMpIDIwMDUgUmFuZHkgRHVubGFwLgojCiMgQmFzZWQgb24gJ2dpdGZlZWRtYWlsbGlzdC5zaCcg
YnkgRGF2aWQgV29vZGhvdXNlLCB3aGljaCB3YXM6CiMgQmFzZWQgb24gJ2dpdGxvZy5zaCcgb3Jp
Z2luYWxseSB3cml0dGVuIGJ5IChjKSBSb3NzIFZhbmRlZ3JpZnQuCiMgQWRhcHRlZCB0byBoaXMg
c2NyaXB0cyBzZXQgYnkgKGMpIFBldHIgQmF1ZGlzLCAyMDA1LgojIE1ham9yIG9wdGltaXphdGlv
bnMgYnkgKGMpIFBoaWxsaXAgTG91Z2hlci4KIwojIFRha2VzIGFuIGlkIHJlc29sdmluZyB0byBh
IGNvbW1pdCB0byBzdGFydCBmcm9tIChIRUFEIGJ5IGRlZmF1bHQpLgoKIyMjIE1pc3Npbmc6CiMj
Iwlsb2NrczsKIyMjCWFueSBjb21tYW5kLWxpbmUgYXJnczsKClNUQUdJTkdESVI9Lmh0bWwKSFRN
TEZJTEU9JFNUQUdJTkdESVIvbmV3aW5kZXguJCQuaHRtbApCSUdQQVRDSD0kU1RBR0lOR0RJUi9j
c2V0LWBkYXRlIC11ICcrJVklbSVkXyVIJU0nYC50eHQKClsgLWQgJFNUQUdJTkdESVIgXSB8fCBt
a2RpciAkU1RBR0lOR0RJUiB8fCBleGl0IDEKcm0gLWYgJFNUQUdJTkdESVIvKgp0b3VjaCAkSFRN
TEZJTEUKCiMgQ0wgPSBjb21taXRzIGxpc3QsIENNID0gY29tbWl0cyBtZXNzYWdlLCBNRCA9IG1l
c3NhZ2UgZGlyLiwgRFMgPSBkaWZmc3RhdApUTVBDTD0kKG1rdGVtcCAtdCBnaXR3ZWIuWFhYWFhY
KQpUTVBDTT0kKG1rdGVtcCAtdCBnaXR3ZWIuWFhYWFhYKQpUTVBEUz0kKG1rdGVtcCAtdCBnaXR3
ZWIuWFhYWFhYKQpUTVBNRD0kKG1rdGVtcCAtdGQgZ2l0d2ViLlhYWFhYWCkKIyMjZWNobyAiIyMj
IFRNUENMPSRUTVBDTCwgVE1QQ009JFRNUENNLCBUTVBNRD0kVE1QTUQsIFRNUERTPSRUTVBEUyIK
CndyaXRlX2h0bWxfaGVhZGVyKCkgewogICAgY2F0ID4+ICRIVE1MRklMRSA8PEVPRgo8IURPQ1RZ
UEUgSFRNTCBQVUJMSUMgIi0vL1czQy8vRFREIEhUTUwgNC4wMSBUcmFuc2l0aW9uYWwvL0VOIj4K
PGh0bWw+CiAgPGhlYWQ+CiAgICA8dGl0bGU+TGludXgga2VybmVsIHBhdGNoZXMgZm9yIGBob3N0
bmFtZWA6PC90aXRsZT4KICA8L2hlYWQ+CgogIDxib2R5PgogIDxIMT5MaW51eCBrZXJuZWwgcGF0
Y2hlcyBzaW5jZSAnPCRsYXN0d2ViPic6ICRjaGFuZ2Vjb3VudCBjaGFuZ2VzZXRzPC9IMT4KCiAg
PEgyPjxBIEhSRUY9IiRCSUdQQVRDSC5neiI+R3ppcHBlZCBmdWxsIHBhdGNoIHNpbmNlICc8JGxh
c3R3ZWI+JzwvQT48L0gyPgogIChkaWZmc3RhdCBhdCBlbmQpPGJyPgoKRU9GCn0KCiMgYXJnMSBp
cyBmaWxlbmFtZSB3aG9zZSBjb250ZW50cyB0byBfYWRkXyB0byB3ZWIgcGFnZSBvdXRwdXQuCndy
aXRlX3dlYl9wYWdlKCkgewogICAgZWNobyAiPEhSPiIgPj4gJEhUTUxGSUxFCiAgICBlY2hvICI8
cHJlPiIgPj4gJEhUTUxGSUxFCiAgICBjYXQgJDEgPj4gJEhUTUxGSUxFCiAgICBlY2hvICI8L3By
ZT4iID4+ICRIVE1MRklMRQogICAgY2F0ICQxID4+ICRCSUdQQVRDSAp9CgpjcmVhdGVfbm9fY2hh
bmdlcygpIHsKICAgIGVjaG8gIjxIMz5ObyBjaGFuZ2VzIHNpbmNlIGxhc3QgdGFnPC9oMz4iID4+
ICRIVE1MRklMRQp9Cgp3cml0ZV9kaWZmc3RhdCgpIHsKICAgIGRpZmZzdGF0IC1wMSAkQklHUEFU
Q0ggPiAkVE1QRFMKICAgIGVjaG8gIjxIUj4iID4+ICRIVE1MRklMRQogICAgZWNobyAiPHByZT4i
ID4+ICRIVE1MRklMRQogICAgY2F0ICRUTVBEUyA+PiAkSFRNTEZJTEUKICAgIGVjaG8gIjwvcHJl
PiIgPj4gJEhUTUxGSUxFCn0KCndyaXRlX2h0bWxfZm9vdGVyKCkgewogICAgY2F0ID4+ICRIVE1M
RklMRSA8PEVPRgogIDxIUj4KICBJbmRleCBnZW5lcmF0ZWQgYXQgYGRhdGUgLXVgCiAgPC9ib2R5
Pgo8L0hUTUw+CkVPRgp9CgojIHRha2VzIGFuIG9iamVjdCBhbmQgZ2VuZXJhdGVzIHRoZSBvYmpl
Y3QncyBwYXJlbnQocykKZ2V0X2NvbW1pdF9vYmplY3RzICgpIHsKCWxvY2FsIHBhcmVudHMgbmV3
X3BhcmVudAoJZGVjbGFyZSAtYSBuZXdfcGFyZW50CgoJbmV3X3BhcmVudD0oIiRAIikKCXBhcmVu
dHM9JCMKCgl3aGlsZSBbICRwYXJlbnRzIC1ndCAwIF07IGRvCgkJcGFyZW50PSR7bmV3X3BhcmVu
dFskKCgkcGFyZW50cyAtIDEpKV19CgoJCWVjaG8gJHBhcmVudCA+PiAkVE1QQ0wKCgkJY2F0LWZp
bGUgY29tbWl0ICRwYXJlbnQgPiRUTVBDTQoKCQlwYXJlbnRzPTAKCQlpZ25vcmVkcGFyZW50cz0w
CgkJbGFzdHBhcmVudD0KCQlTVUJKRUNUPQoJCXdoaWxlIHJlYWQgdHlwZSB0ZXh0OyBkbwoJCQlp
ZiBbICIkdHlwZSIgPSAiIiBdOyB0aGVuCgkJCQlyZWFkIFNVQkpFQ1QKCQkJCWJyZWFrOwoJCQll
bGlmIFsgJHR5cGUgPSAncGFyZW50JyBdOyB0aGVuCgkJCSAgICBpZiBncmVwIC1xICR0ZXh0ICRU
TVBDTDsgdGhlbgoJCQkJaWdub3JlZHBhcmVudHM9JCgoJGlnbm9yZWRwYXJlbnRzICsgMSkpCgkJ
CQlsYXN0cGFyZW50PSR0ZXh0CgkJCSAgICBlbHNlCgkJCQluZXdfcGFyZW50WyRwYXJlbnRzXT0k
dGV4dAoJCQkJcGFyZW50cz0kKCgkcGFyZW50cyArIDEpKQoJCQkgICAgZmkKCQkJZmkKCQlkb25l
IDwgJFRNUENNCgkJaWYgWyAkKCgkcGFyZW50cyArICRpZ25vcmVkcGFyZW50cykpIC1lcSAxIF07
IHRoZW4KCQkgICAgWyAteiAiJGxhc3RwYXJlbnQiIF0gJiYgbGFzdHBhcmVudD0ke25ld19wYXJl
bnRbMF19CgkJICAgICMgT25seSBvbmUgcGFyZW50OyBub3QgYSBtZXJnZS4gVXNlIHRoaXMgY3Nl
dC4KCQkgICAgKAoJCSAgICBjYXQgJFRNUENNCgkJICAgIGVjaG8KCQkgICAgZ2l0IGRpZmYgJGxh
c3RwYXJlbnQgJHBhcmVudCA+ICRUTVBDTQoJCSAgICBkaWZmc3RhdCAkVE1QQ00gMj4vZGV2L251
bGwKCQkgICAgZWNobyAKCQkgICAgY2F0ICRUTVBDTQoJCSAgICApID4gJFRNUE1ELyRwYXJlbnQK
CQkgICAgY2hhbmdlY291bnQ9JCgoJGNoYW5nZWNvdW50ICsgMSkpCgkJZmkKCgkJaT0wCgkJd2hp
bGUgWyAkaSAtbHQgJCgoJHBhcmVudHMgLSAxKSkgXTsgZG8KCQkJY2hhbmdlbG9nICR7bmV3X3Bh
cmVudFskaV19CgkJCWk9JCgoJGkgKyAxKSkKCQlkb25lCglkb25lCn0KCmlmIFsgISAtZSAuZ2l0
L3RhZ3MvV2ViRG9uZSBdOyB0aGVuCiAgICBta2RpciAuZ2l0L3RhZ3MKICAgIHRvdWNoIC5naXQv
dGFncy9XZWJEb25lCmZpCgppZiBbIC16ICQyIF07IHRoZW4KICAgIGxhc3R3ZWI9YGNhdCAuZ2l0
L3RhZ3MvV2ViRG9uZWAKZWxzZQogICAgbGFzdHdlYj0kKGdpdFhub3JtaWQuc2ggLWMgJDIpCmZp
CgojaWYgWyAteiAkMyBdOyB0aGVuCiMgICAgdGFnbmFtZT1gbHMgLXJ0IC5naXQvdGFncyB8IGdy
ZXAgLXYgV2ViRG9uZSB8IHRhaWwgLTFgCiMgICAgcmVsZWFzZT1gY2F0IC5naXQvdGFncy8kdGFn
bmFtZWAKI2Vsc2UKIyAgICByZWxlYXNlPSQoZ2l0WG5vcm1pZC5zaCAtYyAkMykKI2ZpICAgIAoK
YmFzZT0kKGdpdFhub3JtaWQuc2ggLWMgJDEpIHx8IGV4aXQgMQoKIyMjZWNobyAiIyMjIGJhc2U9
PCRiYXNlPiwgbGFzdHdlYj08JGxhc3R3ZWI+IgoKaWYgWyAiJGJhc2UiICE9ICIkbGFzdHdlYiIg
XTsgdGhlbgogICAgIyBMaXN0IHRoZSBjb21taXRzIGF0IHdoaWNoIHdlIHNob3VsZCBzdG9wIGZv
bGxvd2luZyB0aGUgdHJlZSwgYmVjYXVzZQogICAgIyB3ZSd2ZSBjb21lIGJhY2sgdG8gY29tbWl0
cyB3aGljaCB3ZXJlIGFscmVhZHkgaW4gJGxhc3R3ZWIuCiAgICByZXYtdHJlZSAtLWVkZ2VzICRi
YXNlICRsYXN0d2ViIHwgc2VkICdzL1thLXowLTldKjoxLy9nJyA+PiAkVE1QQ0wKICAgIGNhdCAk
VE1QQ0wKCiAgICBjaGFuZ2Vjb3VudD0wCiAgICBnZXRfY29tbWl0X29iamVjdHMgJGJhc2UKICAg
ICMjI2VjaG8gIiMjIyBjaGFuZ2Vjb3VudDogJGNoYW5nZWNvdW50IgoKICAgICMgTm8gJ2dpdCB0
YWcgLUYnIC0tIGNoZWF0LgogICAgZWNobyAkYmFzZSA+IC5naXQvdGFncy9XZWJEb25lCgogICAg
d3JpdGVfaHRtbF9oZWFkZXIKCiAgICBpZiBbICIkY2hhbmdlY291bnQiIC1lcSAwIF0gOyB0aGVu
CgljcmVhdGVfbm9fY2hhbmdlcwogICAgZWxzZQoJdGFjICRUTVBDTCB8IHdoaWxlIHJlYWQgY29t
bWl0OyBkbwoJICAgIGlmIFsgLXIgIiRUTVBNRC8kY29tbWl0IiBdOyB0aGVuCgkJd3JpdGVfd2Vi
X3BhZ2UgIiRUTVBNRC8kY29tbWl0IgoJICAgIGZpCglkb25lCgl3cml0ZV9kaWZmc3RhdAoJZ3pp
cCAkQklHUEFUQ0gKICAgIGZpCgogICAgd3JpdGVfaHRtbF9mb290ZXIKICAgIG12ICRIVE1MRklM
RSAkU1RBR0lOR0RJUi9pbmRleC5odG1sCmZpCgpybSAtcmYgJFRNUENMICRUTVBDTSAkVE1QRFMg
JFRNUE1ECg==

--Multipart=_Sun__17_Apr_2005_18_33_44_-0700_pjIY0aihC1gJMda_--
