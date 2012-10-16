From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Merge option suggestion (dictator, humble)
Date: Wed, 17 Oct 2012 10:17:34 +1100
Message-ID: <CAH5451me=JC5kL-_LZNaSrEX3b1MR6W6sa=A8CUtsxH480wm3g@mail.gmail.com>
References: <CAHtLG6TYEstro0J5jFJc1sZMoLC9gkHWrZdu4Y=hz-+kKkqXTQ@mail.gmail.com>
 <7vpq4is553.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 01:18:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOGOo-0000tE-NR
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 01:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755507Ab2JPXRz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Oct 2012 19:17:55 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:50152 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755013Ab2JPXRy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2012 19:17:54 -0400
Received: by mail-qc0-f174.google.com with SMTP id o22so1588272qcr.19
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 16:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=HK9kfs/wEw8ExT+PZ4VXJNNl/ik/wbmqjSV1VmJHCm0=;
        b=blZ6Yd/1JKp8udD6GuR2m3mhR8UVTeWO5NKJaWQhjAoPSpMkEPrHPHIyR7HUrNo3zo
         IHN/uVvSKfmUrNES/hXXUb74ulc1IaYmZDvtxEt77gSuXQP78NMc8b/OYdAqWckDMeT7
         D0Lpq+hMxUe7XcfK31V0Za1/zBob0OVfxD1QsyZ5Qye9Xc7qb4usE5nqSDp0YJM1g9DU
         BtrsapodlJMcfj+3Z9tP4FvabhfilN1PLS9Oda8r0yzLmUyLNHrtdkWvo9MeIDOqBosm
         pEOwPlAtWo3GbZ6bA10JfTijBjGK0TB7P085rScLU6WLy4eCU+MLV6smKemqR4EIt870
         yq8A==
Received: by 10.49.48.109 with SMTP id k13mr38129531qen.44.1350429474258; Tue,
 16 Oct 2012 16:17:54 -0700 (PDT)
Received: by 10.49.58.225 with HTTP; Tue, 16 Oct 2012 16:17:34 -0700 (PDT)
In-Reply-To: <7vpq4is553.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207884>

On 17 October 2012 04:23, Junio C Hamano <gitster@pobox.com> wrote:
> =E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cooli@gmail.com> writes:
>
>> I would like to suggest 2 merge options
>> --dictator   use all my changes
>> --humble   use all their changes
>>
>> These allows to produce a fast-forward commit, without resolving any=
 conflicts.
>> Sometimes, someone did something completely wrong, so the commit nee=
ds
>> to be ignored.
>
>> I cannot tell everyone in the world to run git fetch followed by git
>> reset --hard.
>
> Then you cannot tell them to use "pull --humble" either, can you?
>
> Not seeing any merit in the proposal (yet).

Would this allow setting up a project-default merge configuration for
contributors that defaulted to --humble? Not sure if that is useful or
not, but it at least seems safer than trying to default to doing reset
--hard after every merge.

Regards,

Andrew Ardill
