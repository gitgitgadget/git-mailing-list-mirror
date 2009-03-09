From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] git-clone: Add option --branch to override initial 
	branch
Date: Mon, 9 Mar 2009 18:01:54 +0200
Message-ID: <94a0d4530903090901o6e8c2a40k676387f90ee461b3@mail.gmail.com>
References: <alpine.DEB.1.00.0903030047130.10279@pacific.mpi-cbg.de>
	 <1236040414-19089-1-git-send-email-torarnv@gmail.com>
	 <7vbpsh93q5.fsf@gitster.siamese.dyndns.org>
	 <loom.20090309T143413-334@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 17:03:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lghwu-0003Rd-0y
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 17:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbZCIQB6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2009 12:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbZCIQB6
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 12:01:58 -0400
Received: from mail-fx0-f176.google.com ([209.85.220.176]:38385 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbZCIQB5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Mar 2009 12:01:57 -0400
Received: by fxm24 with SMTP id 24so1299855fxm.37
        for <git@vger.kernel.org>; Mon, 09 Mar 2009 09:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=akc9B1TqaTP+HVQPl6o6HPfO6wsF49EQ8A5+GQi/QsU=;
        b=d25gtvz5jGEGE0UnOJa5ZAiTdIiLbNj0FhIPFYPwLyoWxyNC1R/JyFbRYW5LEnAJK0
         GaQQgRwKKl/Z4dFfUv7cOoFqgv9l7TVHvmOa4bew5hVnIcLGSDGpYLs9Qrk+tehNWVj5
         JayrzgCGF3jZhKcatlPH6ZRKevmNoiH1reV5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nn4b/2LJInyT9NDMhRzPYBr4jyLF3UsagVx5Wa2Ujc3hJfL6TCz2B+6KIsrOqaWbA2
         /zmWQuINMyIioCrdMjwbqEaXta4zvG8nPQhgGuyNl0innjqlbKU6nGDKtir+lUJu1SMc
         1YUZZJ85o5rPks6TSAiOVgRDRKTsw9Jvl8Afk=
Received: by 10.86.100.19 with SMTP id x19mr837966fgb.49.1236614514740; Mon, 
	09 Mar 2009 09:01:54 -0700 (PDT)
In-Reply-To: <loom.20090309T143413-334@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112710>

On Mon, Mar 9, 2009 at 4:39 PM, Paolo Ciarrocchi
<paolo.ciarrocchi@gmail.com> wrote:
> Junio C Hamano <gitster <at> pobox.com> writes:
>
>>
>> Tor Arne Vestb=C3=B8 <torarnv <at> gmail.com> writes:
>>
>> > The options --branch and -b allow the user to override the initial
>> > branch created and checked out by git-clone (normally this is the
>> > active branch of the remote repository).
>> >
>> > If the selected branch is not found the operation aborts.
>> >
>> > Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv <at> gmail.com>
>>
>> The semantics and desirability of the new feature have been already
>> discussed, and I am not convinced that it is necessary, in the sense=
 that
>> I do not think I likely ever use this myself, but I am just one of g=
it
>> users so that is not a strong basis for rejection.
>
> I wrote a comment about the --branch approach a couple of days ago, d=
unno why
> but this thread never reached my inbox (replying via gmame web interf=
ace).
>
> http://thread.gmane.org/gmane.comp.version-control.git/112527
>
> As I wrote in my post a friend of mine, new to git, was looking for t=
he
> possibility of cloning a repo and automatically checkout a specific b=
ranch.

Yeah, I also would like this option... one-liner for people that don't
know git at all.

me: you want my code? just run this command.

--=20
=46elipe Contreras
