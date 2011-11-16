From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/7] sequencer: handle single-commit pick as special case
Date: Wed, 16 Nov 2011 12:00:15 +0530
Message-ID: <CALkWK0mW4MOw_vvqRengbDrf4sd8NJZptr57b8LKDmfAhxevpA@mail.gmail.com>
References: <1321181181-23923-1-git-send-email-artagnon@gmail.com>
 <1321181181-23923-4-git-send-email-artagnon@gmail.com> <7vpqgvmwtl.fsf@alter.siamese.dyndns.org>
 <CALkWK0krTY+szqPrE9wxwfK76VBbFXh_Xaz8EyWZayLa_SFQTw@mail.gmail.com> <7v62ilujya.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 07:30:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQZ1K-0004ww-7O
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 07:30:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753937Ab1KPGai convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Nov 2011 01:30:38 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61625 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486Ab1KPGah convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2011 01:30:37 -0500
Received: by wyh11 with SMTP id 11so89541wyh.19
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 22:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=cZUOe/fUIKvXVSKtGZxpoXPGCCMmTSr/aCEuE5sG82Q=;
        b=o1MAIcNbhzBQ9Fqg0gep3E4KN1hp6oAOXT4C84/qEG176TVW8GrZ1ysGWC7PT/s6xk
         BAKwHA0d2Ie9Ax7Fb71sybSPUu/Id/AuLKBNEXBpoUC5kMJJ//u5CQOGeSMS651Jpofd
         BR8P/+maE7IRM2RFD+YMN6i+p7dk77KIOA4Ec=
Received: by 10.216.133.155 with SMTP id q27mr251562wei.101.1321425036279;
 Tue, 15 Nov 2011 22:30:36 -0800 (PST)
Received: by 10.216.19.209 with HTTP; Tue, 15 Nov 2011 22:30:15 -0800 (PST)
In-Reply-To: <7v62ilujya.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185511>

Hi Junio,

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>> [...]
> But we are already in agreement on this point, I think. Didn't I say:

Yes, yes.  I was just thinking out loud so it'll help me write a new
commit message.  Sorry for the noise.

>> 2. In the case of multi-commit picking, there's an additional layer =
of
>> decision making: did the conflict occur in the last commit in the
>> range?
>
> Again, it would be the same thing. If the implementation forces that
> decision, that would be a bug, no?
>
> My understanding is that multi-commit form of cherry-pick and revert
> intended to allow two forms of "user done helping and telling the com=
mand
> to continue" at any stage, be it the first, in the middle, or the las=
t
> operation in a series:
>
> =C2=A0- User resolves, adds and commits, and then tells the command t=
o
> =C2=A0 continue. The command notices that the user has committed, and=
 goes on
> =C2=A0 to the next task; or
>
> =C2=A0- User resolves, adds, and then tells the command to continue. =
The
> =C2=A0 command notices that the user has not committed, makes a commi=
t and
> =C2=A0 goes on to the next task.

Yep, this is exactly how it'll work after the series :D

Thanks.

-- Ram
