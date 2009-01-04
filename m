From: "alec resnick" <alec@sproutward.org>
Subject: unclear description of git-rm on kernel.org
Date: Sun, 4 Jan 2009 17:10:11 -0500
Message-ID: <62a60dd90901041410j283866e5ja39c3bda447fed36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 04 23:11:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJbCA-0006sP-Hp
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 23:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbZADWKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 17:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbZADWKP
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 17:10:15 -0500
Received: from rn-out-0910.google.com ([64.233.170.191]:10182 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbZADWKO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 17:10:14 -0500
Received: by rn-out-0910.google.com with SMTP id k40so4793640rnd.17
        for <git@vger.kernel.org>; Sun, 04 Jan 2009 14:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=rPH4ZpIxoYGKot9AuknaEEf1ZiYx1xKHsQNAZY+Fr90=;
        b=IVz4Lxp0pFkClQYt3U7TQXhrESk+PZLw/SvkXlktjej3LE1osE2xHtZzOyNZJxn95U
         pWFVG/SvQSD4AZOKlv00QMpTCB1+nL0gseBbPsHRIyxTqVAlCiWxZi2hSijpJIO2Arcc
         dWdPA85cxxmDr53/5c1GX1M8Ifx7kYlFQ31GU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=nFHqRfRI53ILgNqfsJkKcW7OHNNujhD0qZBoBvcbbWUcF9qUHAN82gVS+I5jORTPvG
         01Lz9m/6+g8eVgymrTFzxRLzd4Z2yMmY4/a0mObdipSfDWBVPL2od9rmotHtW+HhSkN4
         r4iIggh6rrG1Z6JnO2UjM8UgqX/gnThB5w0So=
Received: by 10.231.30.198 with SMTP id v6mr662404ibc.22.1231107011840;
        Sun, 04 Jan 2009 14:10:11 -0800 (PST)
Received: by 10.231.31.136 with HTTP; Sun, 4 Jan 2009 14:10:11 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: 78f2b129b6d18ed9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104545>

SGkhCgpJIHdhcyB0cnlpbmcgdG8gcmVtb3ZlIGEgbnVtYmVyIG9mIGZpbGVzIGZyb20gYSBnaXQg
cmVwbyBJIGhhZC4gIEkKcmVhZCBodHRwOi8va2VybmVsLm9yZy9wdWIvc29mdHdhcmUvc2NtL2dp
dC9kb2NzL3YxLjQuNC40L2dpdC1ybS5odG1sCndoaWNoIEkgaW50ZXJwcmV0ZWQgdG8gbWVhbiB0
aGF0IGdpdC1ybSByZW1vdmVkIG9ubHkgZnJvbSB0aGUgaW5kZXgsCmFuZCBub3QgZnJvbSB0aGUg
d29ya2luZyB0cmVlLiAgSW4gcmV0cm9zcGVjdCwgdGhlIHNob3J0IGRlc2NyaXB0aW9uCmlzIGNs
ZWFyOiAiZ2l0LXJtIC0gUmVtb3ZlIGZpbGVzIGZyb20gdGhlIHdvcmtpbmcgdHJlZSBhbmQgZnJv
bSB0aGUKaW5kZXgsIiBidXQgSSB3YXMgY29uZnVzZWQgYnkgdGhlIGxhbmd1YWdlOgoiPGZpbGU+
4oCmCgogICAgRmlsZXMgdG8gcmVtb3ZlIGZyb20gdGhlIGluZGV4IGFuZCBvcHRpb25hbGx5LCBm
cm9tIHRoZSB3b3JraW5nCnRyZWUgYXMgd2VsbC4KLWYKCiAgICBSZW1vdmUgZmlsZXMgZnJvbSB0
aGUgd29ya2luZyB0cmVlIGFzIHdlbGwgYXMgZnJvbSB0aGUgaW5kZXguIgoKQmVjYXVzZSBvZiAi
b3B0aW9uYWxseSIgYW5kIHRoZSB2ZXJ5IGV4aXN0ZW5jZSBvZiB0aGUgIi1mIiBvcHRpb24Kc3Vn
Z2VzdHMgdGhhdCB5b3UgaGF2ZSB0byBkbyBzb21ldGhpbmcgZXh0cmEgdG8gYXNrIGdpdC1ybSB0
byBtZXNzCndpdGggdGhlIHdvcmtpbmcgdHJlZS4KClRoZSBtYW5wYWdlIGlzIG11Y2ggY2xlYXJl
ciwgYW5kIHdoaWxlIEkgcmVjb3ZlcmVkIHRoZSBmaWxlcyBJCmFjY2lkZW50YWxseSByZW1vdmVk
IHNpbXBseSB3aXRoIGdpdCBjaGVja291dCwgSSBzdWdnZXN0IHRoYXQgdGhlCndlYnBhZ2UgYmUg
bWFkZSBhIGJpdCBjbGVhcmVyLiAgSW4gcGFydGljdWxhciwgYWRkaW5nIGluZm8gYWJvdXQgaG93
CnRvIF9vbmx5XyByZW1vdmUgZmlsZXMgZnJvbSB0aGUgaW5kZXggd291bGQgYmUgaGVscGZ1bC4K
CkknZCBiZSBoYXBweSB0byBtYWtlIHRoZSBjaGFuZ2VzIHRvIHRoZSB3ZWJwYWdlOyBJIGRvbid0
IGtub3cgaG93IHRvCmRvIHRoYXQgb3IgaWYgaXQncyBhcHByb3ByaWF0ZS4KClRoYW5rcyEKCgot
YS4K
