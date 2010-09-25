From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC v2 2/4] rev-parse: Don't recognise --flags as an
 option if --no-flags has been specified.
Date: Sat, 25 Sep 2010 10:26:48 +0000
Message-ID: <AANLkTi=1UJ+BJGE+-CXXGsfGeNcejPUT=0BA5MSXjjSv@mail.gmail.com>
References: <1285405454-12521-1-git-send-email-jon.seymour@gmail.com>
	<1285405454-12521-4-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: robbat2@gentoo.org, casey@nrlssc.navy.mil, git@vger.kernel.org,
	brian@gernhardtsoftware.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 12:26:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzRy5-0008KH-SB
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 12:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756156Ab0IYK0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 06:26:52 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57464 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755842Ab0IYK0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 06:26:52 -0400
Received: by iwn5 with SMTP id 5so3104601iwn.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 03:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jlmVUpwB/gK3X7sEYi0uyUN4ocyUCS3oOfgvCU9JkLs=;
        b=VQFaRMQ1C1CTI1W6EUrpwmWNaXwisOUdMjlIUvkaQ36rr3R1rIZwG7/h6oKAlFHiP5
         t25K74ruii/XiFt+Ff5wTD2jZ6LPGHruPx6ckxs2owdI1sBsCab4uxtUVoqlvEvTbKv/
         Xf8nHGiCqvp5pQAva2RAD72qe5qcm1CNYIB9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jm0w7C1COuckycBfHDMINn4QFyxv85K5+Z5sRXzPr/u5lEUMq7lR+regRfl+UV2/n+
         fxetCJZXyXr1xW/xtPJl1xIa4V6025QwlRzbe0FOUehGGTWt5tHLB9C30qYqTga1e/P9
         PhHfKMfltOcujARq7D3RGw2Gbc7/OexmNx3MM=
Received: by 10.231.190.75 with SMTP id dh11mr5327823ibb.189.1285410408709;
 Sat, 25 Sep 2010 03:26:48 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sat, 25 Sep 2010 03:26:48 -0700 (PDT)
In-Reply-To: <1285405454-12521-4-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157142>

T24gU2F0LCBTZXAgMjUsIDIwMTAgYXQgMDk6MDQsIEpvbiBTZXltb3VyIDxqb24uc2V5bW91ckBn
bWFpbC5jb20+IHdyb3RlOgo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgaWYgKCEoZmlsdGVyICYgRE9fRkxBR1MpKSB7Cj4gKyDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAvLyAtLXByZWNlZGluZyAt
LW5vLWZsYWdzIG1lYW5zIC0tZmxhZ3MgaXMgaWdub3JlZAo+ICsgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY29udGludWU7Cj4gKyDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9CgpQbGVhc2UgdXNlIGEg
LyogQzg5IGNvbW1lbnQgKi8sIG5vdCB0aGUgQysrIC8gQzk5IHN0eWxlLgo=
