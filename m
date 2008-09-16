From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 16/16] ls-files: add --overlay option
Date: Tue, 16 Sep 2008 19:00:03 +0700
Message-ID: <fcaeb9bf0809160500y4b67c621g45b0c6ddf3745a84@mail.gmail.com>
References: <1221397685-27715-1-git-send-email-pclouds@gmail.com>
	 <1221397685-27715-10-git-send-email-pclouds@gmail.com>
	 <1221397685-27715-11-git-send-email-pclouds@gmail.com>
	 <1221397685-27715-12-git-send-email-pclouds@gmail.com>
	 <1221397685-27715-13-git-send-email-pclouds@gmail.com>
	 <1221397685-27715-14-git-send-email-pclouds@gmail.com>
	 <1221397685-27715-15-git-send-email-pclouds@gmail.com>
	 <1221397685-27715-16-git-send-email-pclouds@gmail.com>
	 <1221397685-27715-17-git-send-email-pclouds@gmail.com>
	 <7vljxtb3tf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 14:01:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfZF8-0003Rl-Ke
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 14:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754153AbYIPMAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 08:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754102AbYIPMAI
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 08:00:08 -0400
Received: from gv-out-0910.google.com ([216.239.58.190]:31015 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753957AbYIPMAF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 08:00:05 -0400
Received: by gv-out-0910.google.com with SMTP id e6so1271552gvc.37
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 05:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=YEutxGH9906fgZjp9uYv3fJjKPid0MK0qUe795NGgBk=;
        b=TGwl76crKOntviy9siiDPwq5Idjfm2IbTGIt0gBFyaEx1cmHBwLnWbJoAA+s+NAvn5
         p19nLdeBr2pVMpEYdm/YOXmrEdt8aDmHrmJym5k3ABA1kt0UaWARo6PP95nMDv7njMXd
         zfQqzFCpB7B8wszn2jEJ9Zu6ZnIPY3b6UnFlY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=d0ctmn5VXvJoKLZ/SEoiF3BxVfGL+b6NuAJcCtnkTuZgVfoCowwd09CxU3yAnY6G5T
         ux9BE4H/GV8R1qm/xFdknOWgrtq5vxVypysNGVH4GkoRlJYczBan86EQT1JcS1bKLKn7
         fpm8/smuTRgFm+all53LDxqzcW168I/aU2Rrg=
Received: by 10.86.29.8 with SMTP id c8mr682975fgc.30.1221566403705;
        Tue, 16 Sep 2008 05:00:03 -0700 (PDT)
Received: by 10.86.59.5 with HTTP; Tue, 16 Sep 2008 05:00:03 -0700 (PDT)
In-Reply-To: <7vljxtb3tf.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95995>

T24gOS8xNi8wOCwgSnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJAcG9ib3guY29tPiB3cm90ZToKPiBO
Z3V54buFbiBUaMOhaSBOZ+G7jWMgRHV5ICA8cGNsb3Vkc0BnbWFpbC5jb20+IHdyaXRlczoKPgo+
ICA+IFRoZSBzYW1lIHNpdHVhdGlvbiBoYXBwZW5zIGZvciAiYXNzdW1lIHVuY2hhbmdlZCIgYml0
LCBidXQgSSB3b3VsZAo+ICA+IGV4cGVjdCBuYXJyb3cgY2hlY2tvdXQgdG8gYmUgbW9yZSB1c2Vy
LWZyaWVuZGx5IGFuZCBzaG91bGQgbm90aWZ5IHVzZXJzCj4gID4gdGhlc2UgY2FzZXMgc28gdXNl
cnMgd2lsbCBub3QgYmUgY29uZnVzZWQuIE9uIHRoaXMgZmlyc3Qgc3RlcCwgdXNlcnMKPgo+ID4g
bWF5IGNoZWNrIGJ5IHRoZW1zZWx2ZXMgd2l0aCAiZ2l0IGxzLWZpbGVzIC0tb3ZlcmxheSIsLi4u
Cj4KPiAgQ291bGQgeW91IGV4cGxhaW4gaG93IHRoZSBlYXJsaWVyIC0tbmFycm93LWNoZWNrb3V0
IG9wdGlvbiBpbnRyb2R1Y2VkIGluCj4gIFswNS8xNl0gaW50ZXJhY3RzIHdpdGggdGhpcyBvbmU/
Cj4KPiAgVGhlIHVzZXIgaGFzIFggaW5zaWRlIG5hcnJvdyBhcmVhIGFuZCBZIG91dHNpZGUuICBs
cy1maWxlcyByZXBvcnRzIGJvdGggWAo+ICBhbmQgWS4gICdscy1maWxlcyAtLW5hcnJvdy1jaGVj
a291dCcgcmVwb3J0cyBvbmx5IFguICBZIGlzIHRyYWNrZWQgYnV0IG5vdAo+ICByZWFsbHksIHNv
ICdscy1maWxlcyAtLW5hcnJvdy1jaGVja291dCAtbycgc2hvdWxkbid0IHNheSBZIGlzIHVudHJh
Y2tlZDsKPiAgdGhlcmUgaXMgbm8gY3VlIHRvIHRlbGwgYmV0d2VlbiBYIGFuZCBZLgoKUmlnaHQs
ICJscy1maWxlcyAtbyIgc2hvdWxkIG5vdCBsaXN0IFkgYXMgdW50cmFja2VkLgoKPiAgQnV0IHdp
dGggYSBoYWxmIG9mIHlvdXIgcGF0Y2ggdG8gJ2xzLWZpbGVzIC10JywgeW91IGFscmVhZHkgY2Fu
IHNob3cgdGhlc2UKPiAgcG90ZW50aWFsbHkgc3RhbGUgKGxlZnRvdmVyIGZyb20gYW4gYW5jaWVu
dCBjaGVja291dCB1bi11cGRhdGVkIGJlY2F1c2Ugb2YKPiAgbmFycm93bmVzcykgZmlsZXMuICBD
b3VsZCBhIHNpbXBsZXIgYWx0ZXJuYXRpdmUgYmUgdG8gZG8gdGhpcyBwcm9jZXNzaW5nCj4gIG5v
dCBpbnNpZGUgImlmIChzaG93X2RlbGV0ZWQvbW9kaWZpZWQpIiBwYXJ0IG9mIHNob3dfZmlsZXMo
KSwgYnV0IGluc2lkZQo+ICAiaWYgKHNob3dfY2FjaGVkL3N0YWdlKSIgcGFydCBvZiBpdD8gIElu
c3RlYWQgb2Ygc2F5aW5nIHRhZ19jYWNoZWQKPiAgdW5jb25kaXRpb25hbGx5LCBpZiB0aGUgZW50
cnkgaXMgbWFya2VkIG5vX2NoZWNrb3V0LCB0aGVuIHlvdSB3b3VsZAo+ICBsc3RhdCgyKSBpdCB0
aGVyZSBhbmQgcmVwb3J0IHRoYXQgdGhlIHBhdGggaXMgIm1hcmtlZCBub3QgdG8gYmUgY2hlY2tl
ZAo+ICBvdXQgYnV0IHNvbWVob3cgc29tZXRoaW5nIGV4aXN0cyB0aGVyZSIuCgpZZXMsIG1ha2Vz
IHNlbnNlLgoKPiAgQnkgdGhlIHdheSwgSSBkbyBub3Qgc2VlIGFuIGVhc3kgd2F5IHRvIHJldmll
dyB3aGF0IHBhdGhzIGFyZSBtYXJrZWQgd2l0aAo+ICBuby1jaGVja291dCBlYXNpbHkgZnJvbSB5
b3VyIGNvbW1hbmQgc2V0LiAgSXQgbWlnaHQgYmUgd29ydGh3aGlsZSB0byBhZGQgYQo+ICBuZXcg
b3B0aW9uIHRoYXQgaXRlcmF0ZXMgb3ZlciB0aGUgaW5kZXgsIGZpbmRzIGEgc2V0IG9mIGNvbW1v
biBwcmVmaXhlcyB0bwo+ICBuby1jaGVja291dCBlbnRyaWVzIGFuZCByZXBvcnRzIHRoYXQgc2V0
LgoKV2hhdCBpcyBpdCBmb3I/IEkgY2FuIG9ubHkgdGhpbmsgb2YgaXQgKGFjdHVhbGx5IHRoZSBv
cHBvc2l0ZSwgZmluZCBhCnNldCBvZiBjb21tb24gcHJlZml4ZXMgdG8gY2hlY2tvdXQgZW50cmll
cykgYXMgYSB3YXkgdG8gcmVjb25zdHJ1Y3QKbmFycm93IHNwZWMgKHNpbXBsZSBydWxlcyBvbmx5
KS4KLS0gCkR1eQo=
