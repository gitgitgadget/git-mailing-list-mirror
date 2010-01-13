From: Jeenu V <jeenuv@gmail.com>
Subject: Re: What to do with patches that should go upstream?
Date: Wed, 13 Jan 2010 16:04:33 +0530
Message-ID: <5195c8761001130234u59d7694bh699de788251f6764@mail.gmail.com>
References: <5195c8761001130151q12ac636cnc69513087320195@mail.gmail.com> 
	<7vzl4inwh1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 11:35:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV0Z7-0006hN-Sa
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 11:35:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755586Ab0AMKe4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jan 2010 05:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755515Ab0AMKez
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 05:34:55 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:16443 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755479Ab0AMKey convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jan 2010 05:34:54 -0500
Received: by qw-out-2122.google.com with SMTP id 8so3573778qwh.37
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 02:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=BdyZNHfEKaRTxOKGtLSImXhTFmzS/6YCgfjxr+UOx+c=;
        b=a7E5eWnDIjGwEa0GN4k2LtlbSoU+ZAjKFsjFf4iTCaygDLK5SbNc/9Q9tum/UkiJKI
         HYdM4CwAVW0+cio1JSYWSP4EDu0+7StI63/nUz8/Stx+aj6Etouaav85wH+LS9pX6iAX
         CJY2fcv1kQ/DlFUNwao7YRwgySjoqorijHDWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ThSsh/1I4FaPTcuc3xti5J7I4s7WUqikJtXGwM6drbfi3ff1A3vODkX9DK04GBovPw
         SxAols/aJsS+Xfxlcn9NZDyB5dQIOrWO9jMrezNJ/O5CnZp1LDcEOkuiwfo19RRDg3om
         +6erUDv+EYMRQekIKn1sbdr18dHeB8Ve+iQSw=
Received: by 10.220.3.211 with SMTP id 19mr1477112vco.7.1263378893176; Wed, 13 
	Jan 2010 02:34:53 -0800 (PST)
In-Reply-To: <7vzl4inwh1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136807>

On Wed, Jan 13, 2010 at 3:43 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jeenu V <jeenuv@gmail.com> writes:
>
>> For example, in the following figure,
>>
>> =A0 =A0 =A0A
>> -O---O-+
>> =A0 =A0 =A0 =A0 \ =A0 =A0 =A0 =A0A' =A0B'
>> -O---O---O---O---O---O---O W
>> =A0 =A0 =A0 =A0 =A0 =A0 /
>> =A0 -O----O--+
>>
>> W is the current working branch. But there are commits A' and B' whi=
ch
>> should go upstream. What I wanted to know is the next step from here=
=2E
>>
>> 1) Do I switch to A and B, and then cherry pick the commits A' and B=
'?
>> 2) If I send the patch out to include in upstream, wouldn't it
>> conflict the next time I happen to merge from A or B?
>
> I don't see B in your picture, so I may not be answering the question=
 you
> wanted to ask, or you perhaps asked something other than the question=
 you
> wanted to ask. =A0Having said that, I think you are asking two more-o=
r-less
> independent questions.

Sorry, B was meant to be the branch at the bottom. But anyway I think
I got hints on what I needed. Thank you for your descriptive reply.

--=20
:J
