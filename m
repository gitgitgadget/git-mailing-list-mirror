From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] Teach/Fix pull/fetch -q/-v options
Date: Fri, 7 Nov 2008 04:26:09 +0100
Message-ID: <4ac8254d0811061926m32183c2fx69ec5b5f4559e608@mail.gmail.com>
References: <1224606624-5082-1-git-send-email-tuncer.ayaz@gmail.com>
	 <20081027190816.6117@nanako3.lavabit.com>
	 <7vprllh0ao.fsf@gitster.siamese.dyndns.org>
	 <4ac8254d0811011023r10a4ce45ka962344ceef564f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nanako Shiraishi" <nanako3@lavabit.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 04:27:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyI0P-0007rk-GR
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 04:27:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbYKGD0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 22:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbYKGD0L
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 22:26:11 -0500
Received: from rv-out-0506.google.com ([209.85.198.236]:65451 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbYKGD0K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 22:26:10 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1105202rvb.1
        for <git@vger.kernel.org>; Thu, 06 Nov 2008 19:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=/DdQUQir/GGZ4rbYDrc4UWHwYZxvI2I9L0QjgjmgcNM=;
        b=xekAAQXnB6OWM2Nyk/fCL/eaW+SfcWW2nMD2bN3b94oyLUhKsosgaADGBngo5ztBaI
         xQkqfITjN/hcM7oRjkDz/53nah04VDJVlHXDiJHxVMkrJdRE82Pd795E0LlPgg/xcU+F
         U3/mNqH9ecd/6n3c0fkON7797jY6mn3z29w6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=tS/+22U/V8X5NAXyTIj3Psbf+javik3M4Gwcr+IA6LTn4Rpg3Qz59bGa8mFFusRCBp
         iOxi74BroFsbL/P/E5fBzBfb7JmK54lMMYH9n0TK9U80/7UXnyAekW+VkpKblgNLJWDf
         d7mm8O79fSsjGIWWAnPGycOJYgM0SMRJ/sTc4=
Received: by 10.141.115.6 with SMTP id s6mr1634796rvm.235.1226028369215;
        Thu, 06 Nov 2008 19:26:09 -0800 (PST)
Received: by 10.141.33.13 with HTTP; Thu, 6 Nov 2008 19:26:09 -0800 (PST)
In-Reply-To: <4ac8254d0811011023r10a4ce45ka962344ceef564f0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100282>

On Sat, Nov 1, 2008 at 6:23 PM, Tuncer Ayaz <tuncer.ayaz@gmail.com> wrote:
> On Tue, Oct 28, 2008 at 4:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Nanako Shiraishi <nanako3@lavabit.com> writes:
>>
>>> Quoting Tuncer Ayaz <tuncer.ayaz@gmail.com>:
>>>
>>>> After fixing clone -q I noticed that pull -q does not do what
>>>> it's supposed to do and implemented --quiet/--verbose by
>>>> adding it to builtin-merge and fixing two places in builtin-fetch.
>>>
>>> Junio, may I ask what the status of this patch is? Maybe the patch was
>>> lost in the noise? The commit log message is written very differently from
>>> existing commits in the history of git, and I am thinking that maybe that is
>>> why you did not like the whole patch? Or is it lack of any test script?
>>
>> Well, perhaps you've been with us long enough to get too picky like
>> myself, but this was genuinely lost in the noise and my scrambling to get
>> back to normal.  We do not typically say "I did this, I did that", but the
>> first paragraph in Tuncer's message is perfectly fine.  I would probably
>> liked the second paragraph better if it were after --- lines (it is more
>> about the possible enhancements in other areas, and does not belong to the
>> commit log message for this change), but it is not a grave enough offence
>> to get the patch rejected.
>
> Should I resend the patch with a short and simple commit message
> like the following?
> --8<--
> Implement git-pull --quiet and --verbose by adding the
> options to git-pull and fixing verbosity handling in git-fetch.
> -->8--
>
>> The patch itself looks Ok; the lack of test script additions does indeed
>> bother me somewhat, but it is not too big a deal.
>
> I took a look at t/ and am not quite sure whether I should test -v/-q
> by analyzing stdout output's length & content.
>
> I think testing -q and -v makes more sense on a global and not
> git-pull or git-fetch level. For that to be possible I envision building
> common verbosity-based logging functions/macros.
>
> I don't like the idea of scanning stdout for length or content as
> long as we're not sure that all errors and warnings are sent
> to stderr and stdout is for info and verbose only.
>
>> P.S. We are having fun at GitTogether'08 in the first half of this week,
>> so please expect slower response than usual.
>

Please see my next patch revision arriving here in a moment.
