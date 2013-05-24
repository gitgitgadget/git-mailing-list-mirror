From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6] Add new git-related helper to contrib
Date: Thu, 23 May 2013 19:22:53 -0500
Message-ID: <CAMP44s1GrtCFBdCRVDAAG+J24uDFiBc+mQ-jOesLdwVp-Qg_Dg@mail.gmail.com>
References: <1368978823-18247-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4gyizti.fsf@alter.siamese.dyndns.org>
	<CAMP44s0pXLmjVUwsVWiN2G5QReh80spXjvy_6GuUGRz1RmUbLQ@mail.gmail.com>
	<7vd2siiqsr.fsf@alter.siamese.dyndns.org>
	<CAMP44s2ETSxebGxXJV_BYEqTC5gJMVdQLbnTUomrie2rHhdmDg@mail.gmail.com>
	<7v8v36iq3e.fsf@alter.siamese.dyndns.org>
	<7v4nduipvb.fsf@alter.siamese.dyndns.org>
	<7vzjvmh98r.fsf@alter.siamese.dyndns.org>
	<CAMP44s1_=HSgZA=abHJ3sgDbUyfkF78qO+sR1+Aact3o7bAgLA@mail.gmail.com>
	<7vvc6ah81g.fsf@alter.siamese.dyndns.org>
	<CAMP44s37a0_wVVef+QVnLNvc8Uos_XpCZAtpX0RmQyMcuJHUHw@mail.gmail.com>
	<CAMP44s18ps9JtY7+mvXVbuZu3cm7bHnK1vCzMWqBdvawLr+zzA@mail.gmail.com>
	<7v8v35hc11.fsf@alter.siamese.dyndns.org>
	<CAMP44s0X-79Pn4gq_rqBbti-xUobyYDc8Gy-3-g=sq8siZqq8g@mail.gmail.com>
	<7vppwhcqjq.fsf@alter.siamese.dyndns.org>
	<CAMP44s3LcEkTghg-cBRux7sA54L-U93w5Znqa1jz2MnUWj8Rhw@mail.gmail.com>
	<7vhahtco5b.fsf@alter.siamese.dyndns.org>
	<CAMP44s14Gdadmgy2zi6dRnKLYdZ=HO85OiPSVxGZ8Hquv_58=g@mail.gmail.com>
	<7vvc69b6nl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 24 02:23:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uffmd-0007Ci-Qr
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 02:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757982Ab3EXAW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 20:22:56 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:53091 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757915Ab3EXAWz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 20:22:55 -0400
Received: by mail-lb0-f172.google.com with SMTP id p10so4096890lbi.17
        for <git@vger.kernel.org>; Thu, 23 May 2013 17:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=soqufcFAkPKw0Zzz6mmOJNYAmyxl+lqdP0iVm6Phz9M=;
        b=hQE4nd0A0uooG92D9KGEyymXxgnFiaPWb3tbIG89T6+ksIsU1MAt8gpz2hnVxPWPdg
         qX96g/mvDddy0KWqytmsDHieoY1Qc+Xp5hETmaSlzLMf+CBlCIzirrrZIduEnV8DNgro
         BnYXixQ4Yk6ZM8xOyGw0hDiwJViv59aZncJpPkRcb1AUMNcIto8vWqA7PyYzTTs0MWHF
         ty+T3y2TK5+VE2zuJM81D8LmuN8MtA4gUzxutPFVvKg4ap9HHs+55W6n2Y8WbeAixhQB
         g06o1hGaOwnZHk2Z/+11fnsx3lXn4op7FChp4J/0qhi2ictQA0yZ/q0GPeH0f5OeozBA
         SXUA==
X-Received: by 10.112.63.169 with SMTP id h9mr7610459lbs.135.1369354973935;
 Thu, 23 May 2013 17:22:53 -0700 (PDT)
Received: by 10.114.174.170 with HTTP; Thu, 23 May 2013 17:22:53 -0700 (PDT)
In-Reply-To: <7vvc69b6nl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225325>

On Thu, May 23, 2013 at 6:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> If the change in HEAD^ in the above example were to copy the whole A
>>> and C from a different file, then your !found_guilty logic would
>>> kick in and say all lines of A where copied from elsewhere in HEAD^,
>>> but again we would not learn the same information for C.
>>
>> We would, when it's the turn for C, which is not guilty at this point.
>
> In _this_ round of the while(1) loop, pass_blame_to_parent() gets
> the scoreboard and two origins (HEAD^ that we are looking at and
> HEAD^^ that is its parent); it does not even know what blame entry
> this request came from.
>
> It runs a single diff using diff_hunks(), and asks blame_chunk() to
> split all the blame entries in the scoreboard that suspect it is
> looking at may be guilty for.  Blame entry for A and C are both
> processed exactly the same way when HEAD^ is given to pass_blame()
> for the first time, which is when assign_blame() decided to call it
> with HEAD^ because it happened to have seen A before seeing C.  At
> that point, both A and C are processed, and the post-processing loop
> "Take responsibility for the remaining" will clean up remnants from
> both A and C.  After this round ends, the suspect for A and C are
> both set to HEAD^^.
>
> In the next round of the while(1) loop, C already forgot that its
> line movement happened in HEAD^.  Its suspect is now HEAD^^.  When
> "it's the turn for C" [*1*], you can say "These lines originate in
> that different path in HEAD^^", but it is too late to say "But the
> first time they appeared in the original file was HEAD^" (which is
> when they were moved from the different path in HEAD^^), isn't it?

If that's the case then we'll need another list of blame entries where
each discarded blame entry goes. Given the luck of my previous obvious
patches, I'm not interested in implementing this non-obvious one in
the least.

The point is 'git related' should do -C -C -C, if 'git blame' doesn't
throw the right output, that's a bug in 'git blame' not 'git related.

-- 
Felipe Contreras
