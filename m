From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [RFC/PATCH 1/2] for-each-ref: add new format 'refbasename'
Date: Fri, 29 Aug 2008 20:21:17 +0200
Message-ID: <36ca99e90808291121j7b202917r2308719970668be3@mail.gmail.com>
References: <0329f1ab2642e1dab701b5fc6517bfb1b4ea2d46.1220004755.git.szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "=?UTF-8?Q?SZEDER_G=C3=A1bor?=" <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Aug 29 20:22:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ8c3-0008EF-K2
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 20:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754296AbYH2SVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 14:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbYH2SVT
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 14:21:19 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:5603 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbYH2SVS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 14:21:18 -0400
Received: by an-out-0708.google.com with SMTP id d40so166828and.103
        for <git@vger.kernel.org>; Fri, 29 Aug 2008 11:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3q7hvl1zoMHtofmIFvSenJkfQFh7emUh5VJcZYNE/u8=;
        b=KK513YinYCvDRcK1fPexuCvVmr8l4idyVkg++6JcAV0dN86WfnX6jK5YzeBhvomnIR
         tlWLW4uUemK1ihfPhI6elLwmE/DeDVy+Yb5QMBTJIxZumuAsjzE+0Kpkgx8E+je2BrLH
         fTaCCX3EHheJpjGq+VrAv8DXkgceMDynk3ARM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=YHcQAtmvSD4OYPP630Wuxrq7Mwnv0ol5ox2Ig24hTGF1R2AuBy21X0OZyMEUYkP4Sm
         IK5uX1d6xCSYbAg37QUCkOFRinvxwwDLeU/6qtlQlNZ1g26cvZSeHIQRPbOABmN6ud7X
         B02xNXws22lJUZTvXSV07JBNq+yw/VlFjYZMg=
Received: by 10.100.172.16 with SMTP id u16mr3669896ane.50.1220034077330;
        Fri, 29 Aug 2008 11:21:17 -0700 (PDT)
Received: by 10.70.49.12 with HTTP; Fri, 29 Aug 2008 11:21:17 -0700 (PDT)
In-Reply-To: <0329f1ab2642e1dab701b5fc6517bfb1b4ea2d46.1220004755.git.szeder@ira.uka.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94314>

T24gRnJpLCBBdWcgMjksIDIwMDggYXQgMTI6MzcsIFNaRURFUiBHw6Fib3IgPHN6ZWRlckBpcmEu
dWthLmRlPiB3cm90ZToKPiBmb3QtZWFjaC1yZWYncyByZWZuYW1lIGZvcm1hdCBvdXRwdXRzIGVh
Y2ggcmVmIGluIGl0cyBmdWxsIGZvcm1hdCwgZS5nLgo+ICdyZWZzL2hlYWRzL2ZvbycgYW5kICdy
ZWZzL3RhZ3MvYmFyJy4gIEhvd2V2ZXIsIHRoZXJlIGFyZSB0b29scyB0aGF0Cj4gbmVlZCBvbmx5
IHRoZSBsYXN0IHBhcnQgb2YgdGhlIHJlZm5hbWUsIGUuZy4gb25seSAnZm9vJyBhbmQgJ2Jhcicu
ICBTdWNoCj4gYSB0b29sIGlzIGdpdCdzIGJhc2ggY29tcGxldGlvbiBzY3JpcHQsIHdoaWNoIHNw
ZW5kcyBjb25zaWRlcmFibGUgYW1vdW50Cj4gb2YgdGltZSByZW1vdmluZyB0aGUgdW5uZWVkZWQg
cGFydHMgZnJvbSBmb3ItZWFjaC1yZWYncyBvdXRwdXQuCj4KPiBUaGVyZWZvcmUsIHdlIGludHJv
ZHVjZSBhIG5ldyBmb3ItZWFjaC1yZWYgZm9ybWF0IGNhbGxlZCAncmVmYmFzZW5hbWUnLAo+IHdo
aWNoIHN0cmlwcyBldmVyeXRoaW5nIGJlZm9yZSBhbmQgaW5jbHVkaW5nIHRoZSBzZWNvbmQgJy8n
IGluIHRoZSByZWYncwo+IG5hbWUgZnJvbSB0aGUgb3V0cHV0LgoKV2h5IG5vdCBzdHJpcCB0aGUg
cGF0dGVybiAoZ2l2ZW4gb24gdGhlIGNvbW1hbmQgbGluZSkgZnJvbSB0aGUKcmVmbmFtZT8gSS5l
LiB3aXRoIGEgbmV3IGZvcm1hdCAncmVmc2hvcnQnIGEgJ2dpdCBmb3ItZWFjaC1yZWYKLS1mb3Jt
YXQ9JShyZWZzaG9ydCkgcmVmcy9oZWFkcy8nIHdvdWxkIHN0cmlwIG9mZiB0aGUgcmVmcy9oZWFk
cy8gZnJvbQplYWNoIHJlZi4KClRoaXMgc2hvdWxkIGFsc28gd29yayBmb3IgbXVsdGlwbGUgcGF0
dGVybnMgKHJlZnMvaGVhZHMvIHJlZnMvdGFncy8pCmFuZCBmb3IgcGF0dGVybnMgd2hpY2ggbmVl
ZHMgYSBmbm1hdGNoIGNhbGwgKHdoaWNoIGhhcyB0aGUKRk5NX1BBVEhOQU1FIG9wdGlvbikuCgpU
aGUgYmFzaCBjb21wbGV0aW9uIHNjcmlwdCBjYWxscyBmb3ItZWFjaC1yZWYgYWx3YXlzIHdpdGgg
cGF0dGVybnMuCgpCZXJ0Cg==
