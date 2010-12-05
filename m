From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] commit: Add commit_list prefix to reduce_heads function.
Date: Sun, 5 Dec 2010 15:32:18 -0200
Message-ID: <AANLkTinjJpGW2OiXM3edWYaNhS+w4qNLrvg-0aBwsL=x@mail.gmail.com>
References: <a3f4bdc2d5f5d13c772a82de9afe2691b8a12863.1291514223.git.tfransosi@gmail.com>
	<20101205021837.GA24614@burratino>
	<AANLkTinAT3kotKQTS6eS1SLigNzSp6grAU7WNRbHf3N=@mail.gmail.com>
	<20101205170919.GA7913@burratino>
	<AANLkTikL4BWtzNgx1+MBYxRRdfL=Gu71KPjaiKXprvnb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 05 18:32:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPIRl-0005xk-TD
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 18:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756288Ab0LERcV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Dec 2010 12:32:21 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42079 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756144Ab0LERcU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Dec 2010 12:32:20 -0500
Received: by bwz15 with SMTP id 15so9896018bwz.19
        for <git@vger.kernel.org>; Sun, 05 Dec 2010 09:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6LXcbPgINf/lztWPpcqGJcdE/dGESiCFxLwPjTpyLXQ=;
        b=RHIxQlqBTD06mW6AoLMDkcHSx4Yxa8E3chykto1S/yFeF2749QHEMWxIkwqFfQVLpm
         UOUNXqoe5tJ1TTZzkHxxa5U/LjfGVwULSJIqrupHRB0T1ygKsSfwPLP6+b2N/dzSvpdK
         NCwfipoMRjktJKeKwVlQjjQ5x37lViiyhgFjk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sY7pBCVYeoUZtcB5LG9nn9rPVN5bFCUAb5MdBfoMyS0k+ZQoEh0SlB1dClkLmV5iQD
         tpQCoALBROP7fH7bnlNDoWxosLWGXW9V3UfbQH6ZdQpR+fvx2yehEkrUDupPAeAuDOqj
         DGgXdNQxJT7zfQUOENqJ4+wpfDR2Ojy9A3azk=
Received: by 10.204.60.66 with SMTP id o2mr4899105bkh.13.1291570339024; Sun,
 05 Dec 2010 09:32:19 -0800 (PST)
Received: by 10.204.58.71 with HTTP; Sun, 5 Dec 2010 09:32:18 -0800 (PST)
In-Reply-To: <AANLkTikL4BWtzNgx1+MBYxRRdfL=Gu71KPjaiKXprvnb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162954>

On Sun, Dec 5, 2010 at 3:29 PM, Thiago Farina <tfransosi@gmail.com> wro=
te:
> On Sun, Dec 5, 2010 at 3:09 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
>> =C2=A0- "At my office there is a style guide indicating that each fu=
nction
>> =C2=A0 should live in a module with some other functions and be name=
d to
>> =C2=A0 indicate so (like perf, with its sched__* etc functions). =C2=
=A0The idea
>> =C2=A0 is that code with a simple high-level structure tends to be e=
asier
>> =C2=A0 to understand and we need to understand the code we use. =C2=A0=
Can we
>> =C2=A0 start changing the code to fit this style guide, so there is =
less
>> =C2=A0 resistance to using it at my office?"
>>
> For me that is a good reason and I think it matches with what I had i=
n
> mind but didn't write. Thanks for pointing it out.
>

Also I thought that as Junio already picked up the other patch. It's
was a hint that the other functions that has "struct commit_list *l"
as its parameters could be renamed as well. But I was wrong it seems.
