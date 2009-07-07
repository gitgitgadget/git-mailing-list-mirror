From: Andreas Ericsson <ae@op5.se>
Subject: Re: request for documentation about branch surgery
Date: Tue, 07 Jul 2009 13:03:58 +0200
Message-ID: <4A532B9E.7020606@op5.se>
References: <200907070105.12821.bruno@clisp.org> <7vab3hb40x.fsf@alter.siamese.dyndns.org> <200907071213.25418.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bruno Haible <bruno@clisp.org>
X-From: git-owner@vger.kernel.org Tue Jul 07 13:04:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MO8T5-0004uq-Ed
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 13:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755056AbZGGLEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 07:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754861AbZGGLEA
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 07:04:00 -0400
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:46695 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754641AbZGGLD7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jul 2009 07:03:59 -0400
Received: from source ([209.85.219.209]) by na3sys009aob106.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSlMronX22Lwg2ZP61p4lqmt6kYNUHVTY@postini.com; Tue, 07 Jul 2009 04:04:03 PDT
Received: by ewy5 with SMTP id 5so5876255ewy.30
        for <git@vger.kernel.org>; Tue, 07 Jul 2009 04:04:01 -0700 (PDT)
Received: by 10.210.43.11 with SMTP id q11mr6985599ebq.81.1246964641561;
        Tue, 07 Jul 2009 04:04:01 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 5sm3537552eyh.10.2009.07.07.04.04.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Jul 2009 04:04:01 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <200907071213.25418.bruno@clisp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122836>

Bruno Haible wrote:
> Hi Junio,
> 
>> You learn new things every day, and today is such a day ;-)
>>
>>>   If you want to add a commit in the middle of a branch:
>>>
>>>             A---C---...---Z    master
>>>
>>>   =>
>>>
>>>             A---B---C---...---Z    master
>>>
>>>   it is achieved by
>>         $ git checkout master~25 ;# detach HEAD at A
>>         $ edit edit edit
>>         $ git commit ;# creates B
>>
>> which makes
>>
>>                B              HEAD (detached)
>>               /
>>              A---C---...---Z    master
>>
>> and then
>>
>>         $ git rebase HEAD master
>>
>> which reshapes the history into
>>
>>
>>                B---C'--...---Z' master
>>               /
>>              A---C---...---Z    master@{1}
>>
>> and you are done.
> 
> Cool! I wouldn't have guessed that. Now you wrote it into the mailing list
> archives. It would be even better if it were mentioned in the user's manual,
> chapter "Rewriting history and maintaining patch series"
> 

Anyone can submit patches. I find your persistent urging that someone else
do this for you slightly annoying. Now that you've been helped along the
way to understanding, it's your turn to do your bit and write up the info
you've received as a proper patch. This will help ensure that:
a) Other people can find the relevant information quickly
b) We won't have to answer the same questions again
c) You gain an even deeper understanding about how the various features
   actually work as your patches are submitted for review and improvements
   are suggested for them by the list members
d) We answer your questions again next time you have any

You can ofcourse refrain from submitting patches and just hope that d)
happens anyway. It probably will, but not indefinitely.

Thanks.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
