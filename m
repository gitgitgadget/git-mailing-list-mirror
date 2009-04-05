From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git send-email prompting too much
Date: Sat, 4 Apr 2009 22:13:17 -0400
Message-ID: <76718490904041913s2c769022t92ca194263e29eb0@mail.gmail.com>
References: <449c10960904041002s22124b74k8440af216b1de9ee@mail.gmail.com>
	 <80hc148hso.fsf@tiny.isode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dan McGee <dpmcgee@gmail.com>, git@vger.kernel.org
To: Bruce Stephens <bruce.stephens@isode.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 04:14:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqHss-0000T4-Hw
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 04:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756650AbZDECNU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Apr 2009 22:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756616AbZDECNU
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 22:13:20 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:15767 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756612AbZDECNT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Apr 2009 22:13:19 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1609441ywb.1
        for <git@vger.kernel.org>; Sat, 04 Apr 2009 19:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Y8gEha3nfxQrJdkJLWeHd6eUH2IalKAa+yy5xYRyqf0=;
        b=DZApGvi2h/RVWbXIcM3q9c3vI5me5FCG9RLQU1MZjGA5HbxOR4NaZKVTKc5VGksUDF
         A7fZQi7RJvXsOFClqQWyARvTqKSWnI5P0b9T6Zm3lZ25togm28UApWmojchUxrMuV8c2
         RKGMDwdwrKn1qe2m25JbrKSw7LFpODkZ7fI10=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ljtoGM8qJUR9gbjrFioRqYZC016VbzDbxdZn1OJDJt3d22/SiUgYonEIfVVzk+QjlG
         kQ7TdMMfNW8OZki6MocBMl3iVecY3HL4NryqxzzVwFLxwSmUd+uqGKhCuS5JG2Ku0mDn
         4njh05foI7gEmOv9KijIGpHzsHgRI5NjIugwQ=
Received: by 10.150.123.18 with SMTP id v18mr5371958ybc.109.1238897597772; 
	Sat, 04 Apr 2009 19:13:17 -0700 (PDT)
In-Reply-To: <80hc148hso.fsf@tiny.isode.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115619>

On Sat, Apr 4, 2009 at 1:12 PM, Bruce Stephens <bruce.stephens@isode.co=
m> wrote:
> Dan McGee <dpmcgee@gmail.com> writes:
>
>> I'm guessing this is related to commit
>> 6e1825186bd052fc1f77b7c8c9a31fbb9a67d90c but I haven't bisected yet.
>> Having to hit enter 10 times ad the Message-ID prompt seemed a bit o=
dd
>> to me. Has anyone else seen this behavior?
>
> Yes. =C2=A0Apparently one uses \C-d now.

Wait. Did hitting just enter work in the past? Because I tested this
before I made this commit and at least on my machine, hitting enter
just presented the prompt again. So I retained that behavior.

I looked over the Term::ReadLine code and I don't see how just hitting
return ever worked. But if you tell me it did, I believe that and I
can restore that behavior.

Out of curiosity, what is your OS and version, perl version, and what
does does perl -e 'use Term::ReadLine; print
"$Term::ReadLine::VERSION\n"' return?

Thanks,

j.
