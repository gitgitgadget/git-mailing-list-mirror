From: "Geoffrey Irving" <irving@naml.us>
Subject: Re: cherry picking changesets instead of commits
Date: Wed, 28 May 2008 14:14:59 -0700
Message-ID: <7f9d599f0805281414x6b97070ag7a1cc36f5d3c5a36@mail.gmail.com>
References: <7f9d599f0805281106w746a0469u6c483d64cf75b823@mail.gmail.com>
	 <7v1w3muw8j.fsf@gitster.siamese.dyndns.org>
	 <190C4133-35C9-4CE0-816B-603B8F661A56@gmail.com>
	 <7vod6qtgfs.fsf@gitster.siamese.dyndns.org>
	 <7f9d599f0805281242w5769a100s1153c2101992ff55@mail.gmail.com>
	 <7v3ao2tawd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 28 23:16:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1T0C-0004xn-Mc
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 23:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbYE1VPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 17:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753220AbYE1VPE
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 17:15:04 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:7074 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210AbYE1VPB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 17:15:01 -0400
Received: by rv-out-0506.google.com with SMTP id l9so3714911rvb.1
        for <git@vger.kernel.org>; Wed, 28 May 2008 14:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=NFcNs/yaGGSmOuudctkplO0ufIP8ep2gfl9U3rwqyfg=;
        b=hG+68kS93YNnUGUVLkTebrjy/hpJid/GiHKWkaXTxLACkdobM1jN/h96NXizzFUEIM0VmY8odWIYsZ11yfuoj2JJ9srHztQ2RJ/P3teDTIBTLBI4PJqKmuQ1BxG/VCibOO6I6ONwL4PwEoJKGOAeGJqvKzbIGwAcll/UekgSGfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=TcJD8BjSvB9t5pB/tI83glMbqn9wFz1pPC/rF5aoMpvFx60IJ2pE51Yz3n+U88yKwTdfM6texObDBpNfl0WuiYSlpiM5gDTBp5t3KpUzggSqkXhhHU//OnmN44Ks1JSytjGsQg+J7U3Uva/Wb43X/w6gTr+XqWmZ7B4l4Dfe0wk=
Received: by 10.141.79.12 with SMTP id g12mr1590096rvl.126.1212009299190;
        Wed, 28 May 2008 14:14:59 -0700 (PDT)
Received: by 10.140.178.16 with HTTP; Wed, 28 May 2008 14:14:59 -0700 (PDT)
In-Reply-To: <7v3ao2tawd.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: b742f0ce066849cb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83135>

On Wed, May 28, 2008 at 1:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Geoffrey Irving" <irving@naml.us> writes:
>
>> commit a1bac5e1aa52f9a78733aa35a0a7e820df618301
>> Author: Geoffrey Irving <irving@naml.us>
>> Date:   Wed May 28 12:38:11 2008 -0700
>>
>>     doc: mention git-patch-id in git-cherry documentation
>>
>> diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
>> index b0468aa..9817fb5 100644
>> --- a/Documentation/git-cherry.txt
>> +++ b/Documentation/git-cherry.txt
>> @@ -41,6 +41,8 @@ has been applied <upstream> under a different commit
>> id.  For example,
>>  this will happen if you're feeding patches <upstream> via email rather
>>  than pushing or pulling commits directly.
>>
>> +For details about how patches are compared, see git-patch-id.
>> +
>
> Thanks.
>
> In manual pages, "SEE ALSO" section is a more appropriate place to do this
> kind of thing.

Here's an improved patch.

Geoffrey

commit 2417df3ffc04e05c187a93ae58f620f2709ae950
Author: Geoffrey Irving <irving@naml.us>
Date:   Wed May 28 12:38:11 2008 -0700

    doc: reference git-patch-id in git-cherry documentation

diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index b0468aa..dbf8895 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -56,6 +56,11 @@ OPTIONS
 <limit>::
        Do not report commits up to (and including) limit.

+See Also
+--------
+'git-patch-id(1)'::
+       The mechanism git-cherry uses to compare changesets.
+
 Author
 ------
 Written by Junio C Hamano <junkio@cox.net>
