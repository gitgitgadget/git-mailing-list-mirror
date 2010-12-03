From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv2 1/7] CodingGuidelines: mention whitespace preferences
 for shell scripts
Date: Fri, 3 Dec 2010 23:02:03 +0100
Message-ID: <AANLkTi=PmGR23AMog4UWQVNKPWrDUM_kYWV_Bn1vvSwE@mail.gmail.com>
References: <1291394861-11989-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291394861-11989-2-git-send-email-giuseppe.bilotta@gmail.com> <7vsjyemt1f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 23:02:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POdi2-0003Go-AY
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 23:02:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916Ab0LCWCZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Dec 2010 17:02:25 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45557 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab0LCWCY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Dec 2010 17:02:24 -0500
Received: by iwn6 with SMTP id 6so367145iwn.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 14:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=nGQvILLlrXM4I0y7YLWGfUKW6wS5YOmPWHyWmLiI1T4=;
        b=LTS7ipYTORx3lRRWv6hp10Ok7+YIHq0rdoXb6lMF4k7CulgyNPkP2IpVeyGvSh5com
         OvfXnbH1QLB/bcKy7mPiZHkq2FRAxEmKEjjtRQOB2ogFtkK5Mn5FA2rf/tDpY94OvQ+L
         KSlhaTSpBEDis3CsWP5wmp542wqrxV/ky5Oy8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=r2iLLnVoPNyHPtGAgf1XZ/HQgEVwU0ZoSOB7dd+5X1opmF9aj6QWwNSQoPVtrvy7w+
         gyczQneDduoazuiF0n+v+jnOBK+kAQY3rkJsciJMKi9D4OdYYSCcOznerJCZyeUdc2Rq
         kHe7iQnzoZ7+KJc2W9BzelxxVBkyCcEfhU/3M=
Received: by 10.231.36.12 with SMTP id r12mr2371375ibd.156.1291413744036; Fri,
 03 Dec 2010 14:02:24 -0800 (PST)
Received: by 10.231.39.3 with HTTP; Fri, 3 Dec 2010 14:02:03 -0800 (PST)
In-Reply-To: <7vsjyemt1f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162866>

On Fri, Dec 3, 2010 at 10:43 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>> ---
>> =A0Documentation/CodingGuidelines | =A0 =A04 ++++
>> =A01 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGu=
idelines
>> index 5aa2d34..a9191d0 100644
>> --- a/Documentation/CodingGuidelines
>> +++ b/Documentation/CodingGuidelines
>> @@ -31,6 +31,10 @@ But if you must have a list of rules, here they a=
re.
>>
>> =A0For shell scripts specifically (not exhaustive):
>>
>> + - We use tabs for indentation.
>> +
>> + - Case arms are not indented with respect to the case and esac lin=
es.
>
> Thanks.
> I am tempted to rephrase the latter as:
>
> =A0 =A0Case arms are indented at the same depth as case and esac line=
s.
>
> It makes it less hard to read and understand without negation.

Good idea. I'll rephrase in that sense and add a couple more entries
about the | spacing and long case arm splitting, for the next rehash
of the series.

--=20
Giuseppe "Oblomov" Bilotta
