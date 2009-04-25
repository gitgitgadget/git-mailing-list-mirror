From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] Documentation: replace sha1 by SHA-1
Date: Sat, 25 Apr 2009 13:47:42 +0300
Message-ID: <94a0d4530904250347s55a66f47gbaaf5ea42d0c4eac@mail.gmail.com>
References: <1240584575-5702-1-git-send-email-git@drmicha.warpmail.net>
	 <1240584575-5702-2-git-send-email-git@drmicha.warpmail.net>
	 <20090424212856.GB14435@coredump.intra.peff.net>
	 <7vzle5ad8n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 12:49:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxfRe-0002HJ-Ng
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 12:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbZDYKrp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Apr 2009 06:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752683AbZDYKrp
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 06:47:45 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:41505 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbZDYKro convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Apr 2009 06:47:44 -0400
Received: by fg-out-1718.google.com with SMTP id d23so307679fga.17
        for <git@vger.kernel.org>; Sat, 25 Apr 2009 03:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EGJ5pqZOp+6+f39G+dQVJ9dMRmJDexmv2BfDbpruDz8=;
        b=h6vz92ZYmTan1z6FWW0OaBYvojCh+gCqWR6HxX5ZFVf+9BvKSrNQYVog45YZWlLBXt
         fb+RvFABRe1K6HT6jIor8cD4INcVE65SXNoQT35z8y1/bqivGaBmFib0IpYRbkCHdVvj
         xKl8eumZV99UpnG5uFUOv4M4oUe30BWhqQ+FQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LIMYjROSLxUHB2Mfu4cpyKDbCIXx7kFWq0Jr+dF5Jj/Xj5L6v02AljriaH6TeaI4EC
         9ioBAs6TYyAp4UWhI8Y3PKTvEgIELRisnQb1SiVGYasaion6KWvvFQLqWl4FGBZb3C06
         KBIM4LVWqIKo6EsreoqWr+gmKFe5LpiQsTA9g=
Received: by 10.86.59.18 with SMTP id h18mr1570731fga.44.1240656462365; Sat, 
	25 Apr 2009 03:47:42 -0700 (PDT)
In-Reply-To: <7vzle5ad8n.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117545>

On Sat, Apr 25, 2009 at 1:38 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jeff King <peff@peff.net> writes:
>
>> On Fri, Apr 24, 2009 at 04:49:34PM +0200, Michael J Gruber wrote:
>>
>>> --- a/Documentation/git-cat-file.txt
>>> +++ b/Documentation/git-cat-file.txt
>>> @@ -76,7 +76,7 @@ If '--batch' is specified, output of the followin=
g form is printed for each
>>> =C2=A0object specified on stdin:
>>>
>>> =C2=A0------------
>>> -<sha1> SP <type> SP <size> LF
>>> +<SHA-1> SP <type> SP <size> LF
>>> =C2=A0<contents> LF
>>> =C2=A0------------
>>
>> Maybe it is just me, but I find the original for this one easier to
>> read. Perhaps because <sha1> is really a variable name here (but for=
 a
>> human reader to interpret instead of a compiler), so I find the
>> punctuation and capitalization distracting.
>>
>> I wonder if all <sha1> should simply be left as-is.
>
> Or spell them using their official terminology "object name".

Why is the "official" terminology "object name", wouldn't "id" work bet=
ter?

SHA-1 is simply one hash function, what git has been referring to
"sha1" is actually the SHA-1 digest. This digest has been used as a
checksum (or hash sum) but also as a unique identifier, therefore "id"
would work just fine.

--=20
=46elipe Contreras
