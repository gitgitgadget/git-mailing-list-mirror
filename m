From: Thomas Adam <thomas@xteddy.org>
Subject: Re: Please revert e371046b6473907aa6d62b7862a3afe9d33561e1
Date: Wed, 6 Jun 2012 18:54:10 +0100
Message-ID: <CA+39Oz4f_Wn1cVzqNWO76HZWa4AswSBpbriaRc0OznapVLJfGg@mail.gmail.com>
References: <m24nqoohss.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: John Wiegley <jwiegley@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 19:54:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScKRC-0000pb-SB
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 19:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757638Ab2FFRy0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jun 2012 13:54:26 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:50955 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756352Ab2FFRyZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jun 2012 13:54:25 -0400
Received: by obbtb18 with SMTP id tb18so10577219obb.19
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 10:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=e+jQBZevADVwB2T9JHeTHgERUKriN+2TBysDaifHu/s=;
        b=BQXACGMUhB6+MNgMA9C4hHawp+vsVSmyb4E1/wszEzLaAnHueQYFV9Idi3PesVV4sy
         0j+13NTNo1KaURn6wLvr0nM83qidPWXXedtFaMBVV+ALwYRu27WrnQUt03rMqlXJskVU
         tPWmyzfcVl5846GE9i03iwFBG8zGZiSnqUO51Cjw2MoIcOoLs87sl7l2DHMA0Tu/brEt
         lyf7j5QsEjVRJZPnOP59kQvGGt8Y2nBDxF2/IxYvBb8LTdSPS1rYvrjwJZwgPC/6LRX+
         S/35MSRXomeaMlSXeqhjrncvkZ5EefPmry2Be/oqB27OtSsTUZJ6czaouUPmisFCMLUy
         Hh2Q==
Received: by 10.182.207.41 with SMTP id lt9mr21456473obc.41.1339005265315;
 Wed, 06 Jun 2012 10:54:25 -0700 (PDT)
Received: by 10.182.37.5 with HTTP; Wed, 6 Jun 2012 10:54:10 -0700 (PDT)
In-Reply-To: <m24nqoohss.fsf@gmail.com>
X-Google-Sender-Auth: c5K8nFpGUfs94vaBphNB6Kbju5c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199341>

On 6 June 2012 11:28, John Wiegley <jwiegley@gmail.com> wrote:
> I've spoken to the author of this commit, Matthias Urlichs. =C2=A0Her=
e is an
> excerpt of our conversation:
>
>> On Sat, 2012-04-21 at 00:08 -0500, John Wiegley wrote:
>> > Just wanted to let you know that this bit me. =C2=A0I have a clien=
t whose CVS
>> > repository I'm converting to Git, and they have _many_ log message=
s that
>> > are larger than 32k in size.
>>
>> Feel free to submit a patch that reverts this. These days, there's p=
robably
>> no user of cvs2git left, but at that time it was important to get th=
e same

This assertion is not only wrong, it's just ludicrous.  The intended
functionality has a statement of intent with regards to its
functionality -- and as a user of cvs2git, I'd not want to lose *any*
of that functionality.

Don't be stupid with this.  Please.

-- Thomas Adam
