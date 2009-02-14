From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] config: Use parseopt.
Date: Sat, 14 Feb 2009 23:01:18 +0200
Message-ID: <94a0d4530902141301x2cbf5ed1yb2a23299f84e4319@mail.gmail.com>
References: <1234577142-22965-1-git-send-email-felipe.contreras@gmail.com>
	 <7vab8pweod.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530902140237o7d26ff4j1c7350d926d12c1a@mail.gmail.com>
	 <7vhc2wu8a0.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530902141209j7a3a9976l80355bee526852ed@mail.gmail.com>
	 <7v8wo8sqnc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 22:02:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYRey-00087u-Dk
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 22:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbZBNVBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 16:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbZBNVBV
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 16:01:21 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:60868 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbZBNVBU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 16:01:20 -0500
Received: by fg-out-1718.google.com with SMTP id 16so76597fgg.17
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 13:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aXb2kHttmEZTY5kRbnN22YIU5HH6iqRUp0Bp56/6b+A=;
        b=Nth+UeJxaoEL5Gqf5ZfDr7Bbgse1P8fne+28HQM97o/0Gp/4ZjPz0HF7N+vn2oZlc8
         w5qtGlMagasZxwtbWTF0YXitC4f8HNKoKl7tpf7aUMWDzNMSMSKpjpLXLAvBT9J0Tdc3
         eArpZ4qAZiCMCJHx40K1gYxH0qaP+esxjGVc4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=j1wQyeB7O1VrAFhEW6uyly4Eoh9vpv4iPdlp3z4gV2bT4rxEG326lC+MsFHtuSMVpt
         kTWOAKs+TpCisBuPM0pi5FnYPT62R2e8h/zcFxu+BYwGDc1+7OQI5TzOZD/cnFePwRXA
         loJLq2qpaZsnt2eLaUb2SlnzYde1GROk5jAj0=
Received: by 10.86.92.4 with SMTP id p4mr524615fgb.36.1234645278846; Sat, 14 
	Feb 2009 13:01:18 -0800 (PST)
In-Reply-To: <7v8wo8sqnc.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109926>

On Sat, Feb 14, 2009 at 10:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> I personally do not think "I rewrote this command's option parser using
>>> parseopt" earns any "trust point".  I think the latter is a *great* thing
>>> to do, though.
>>
>> I disagree. Making a patch pass through all the filters must mean
>> something, and the more patches the more trust.
>
> Why are you arguing?
>
> I am saying I do not feel more trust in people _merely because_ they
> rewrote command parser to use parseopt.  Telling me that I am wrong and I
> should trust you more for such a patch would not help.

I'm not arguing, that's just my opinion.

I'm not saying writing a patch should give anyone penguin points, it's
going through the review process up to patch acceptance. Maybe not to
you, but maybe for other developers.

>>> Mistakes made in the past and resulting flaws that remain in the current
>>> source do not justify a new patch adding more mistakes to the codebase.
>>> Reviewers help the author from adding more.
>>>
>>> One bad thing about the current process (and I am certainly one of the
>>> guilty parties because I do a lot of reviews) around this area is that a
>>> review comment that points out a mistake similar to the ones made in the
>>> past sound to the author of the patch as if the reviewer is telling that
>>> the patch will not be accepted unless the existing mistakes are also fixed
>>> by the patch author.  Such a review certainly does not mean that ...
>>> ...
>> But, if there's code that already has the same issues the patch has,
>> it doesn't look like a good argument for patch rejection. Perhaps the
>> quality standards increased, but on the other hand things wouldn't get
>> worst by applying the patch.
>
> If you read the above quoted block again, you will notice that we are
> almost in full agreement, *if* you change "by applying the patch" in your
> last sentence to "by applying a patch that is revised to fix the problem
> pointed out during the review in it, even if it does not address the
> similar ones in the existing code".
>
> Adding more breakages of the same kind may not increase the number of
> classes of breakages, but surely it increases the number of places that
> need to be fixed later, and it is actively wrong to discard time and
> energy somebody already spent to prevent one more instance of known
> breakage to get into the codebase.

I think are in full agreement, it's just that I wasn't clear enough;
those are not the kind of issues I was talking about. If there's a
known way how to do something then it's obvious the patch should be
re-submitted with the 'right way'. I was thinking more on "FILE" vs
"file", or any kind of issue that would require a separate patch to
reach consistency in the existing code; those can wait until after the
original patch is accepted.

-- 
Felipe Contreras
