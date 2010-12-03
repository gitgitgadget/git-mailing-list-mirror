From: Eugene Sajine <euguess@gmail.com>
Subject: Re: cannot find hash in the log output
Date: Fri, 3 Dec 2010 12:41:52 -0500
Message-ID: <AANLkTinAUfFge-AcfQevG2_9Gi3oOPy+-SrEZrfp4byn@mail.gmail.com>
References: <AANLkTi=5b26aPLm_Byqg=c9=sPpg5jEPDDpf1J9WgOdY@mail.gmail.com>
	<7v8w07rje3.fsf@alter.siamese.dyndns.org>
	<AANLkTimExbMn4-E-zuAGmi+p1wNAHoetpeyr2SK6vGxk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 18:42:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POZdw-00067N-SL
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 18:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753665Ab0LCRly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 12:41:54 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65490 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753489Ab0LCRlx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 12:41:53 -0500
Received: by bwz15 with SMTP id 15so8561001bwz.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 09:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=eiMH8chmpMaUg3gN/gvxZSCxHhAgZMsbIrK5QmMW2h8=;
        b=E76KX/tEA1xVEQ3IT7LkaK7WSeW5lwqIQv/piGcmrv/X1SDSq/9L2ZGJ8sSrYu1Ki5
         3UvMpRgAiEqd+D9sbcwfSRBPwvk7mqPOovPNh6jA0QzqK/RuJnrVhyNx04sF5z4JVvk/
         2eXEOf7LoKPAPmZTzWOmmWSDQZY/0sv2ni+OY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=NAOOTCzNWx8BDstS1VRzUbmB6UCdSO92THN9k1WqeUMzVD4YL5QD/jFkV4oK8D6cPc
         7q707N5MHkxs8j2Yevmbw/f2xn3rts+KmF+5MJp4p1PQ75Eg3KU7D2FRZ8KI1/5xGQq3
         5XrLyDYVhj4nbYSaB4oQmc/YtxJY/nzcaGbgg=
Received: by 10.204.49.84 with SMTP id u20mr2529693bkf.104.1291398112060; Fri,
 03 Dec 2010 09:41:52 -0800 (PST)
Received: by 10.204.80.131 with HTTP; Fri, 3 Dec 2010 09:41:52 -0800 (PST)
In-Reply-To: <AANLkTimExbMn4-E-zuAGmi+p1wNAHoetpeyr2SK6vGxk@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162817>

On Thu, Dec 2, 2010 at 4:07 PM, Eugene Sajine <euguess@gmail.com> wrote:
> On Thu, Dec 2, 2010 at 3:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Eugene Sajine <euguess@gmail.com> writes:
>>
>>> I have a strange issue (git v 1.7.3.2). I'm cloning the repository,
>>> navigating to the folder containing some scripts and performing
>>> git hash-object <one_of_my_scripts>
>>>
>>> Then I'm trying to run:
>>>
>>> git log --raw --no-abbrev | grep <resulting SHA1 from previous command>
>>>
>>> And i don't see anything.
>>
>> Do you see it in the output from "git ls-tree -r HEAD"?
>>
>
>
> yes. I do see it with your command.
>
> git ls-tree -r HEAD | grep <resulting SHA1 from git hash-object>
>
> Thanks,
> Eugene
>

While I'm able to see that object using the command Junio has provided
the question remains the same:
How could the file get into the state where its hash (git has-object
file-name) cannot be found in any commit (git log --raw --no-abbrev |
grep SHA1), if there was no local changes made to the file???

Thanks,
Eugene
