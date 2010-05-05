From: Lin Mac <mkl0301@gmail.com>
Subject: Re: newbie: need concrete examples for how the linux-kernel project 
	uses git
Date: Wed, 5 May 2010 11:36:50 +0800
Message-ID: <g2u10d816431005042036hcc7a134ai7ded5b4ef3274bf7@mail.gmail.com>
References: <m2i408104421005041431l6c8b5845ld57720c2127fbb00@mail.gmail.com>
	 <20100505011045.GA16345@progeny.tock>
	 <k2l408104421005041911t32652fb7ie9618a301d998983@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Robert Buck <buck.robert.j@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 05 05:37:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9VQm-0006km-81
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 05:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934009Ab0EEDgy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 May 2010 23:36:54 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:57972 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933746Ab0EEDgy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 May 2010 23:36:54 -0400
Received: by pva18 with SMTP id 18so254233pva.19
        for <git@vger.kernel.org>; Tue, 04 May 2010 20:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BZrwEFJkmCJDbaD9lMxEwQNP9PA0I08uVfN5qVdmo+g=;
        b=cGKH6vUD48tvHsiWNEW31cUfdT5QzdgmqMAfWJd3kuVAkIY4S3YtqFEzMGjF1PH1L8
         NrMs/2/0NIkivNGylAw0sJNzPVY6j/qa1qVFwu36y7uCBWUdN7gBD/3dQpbbGZnyjLI+
         dDZO9mMBLCvKO0K6oPUtCNswiouRaNaUn/rpI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FAZwLK6rbdkDqh3wAs3VZCNSkWqvijZd8DjPf6lAVxW2HgugPsRZKq93KsGz+29068
         uraYbZLTPxvsIh+0UUOq/P3eRm6ElqYLZtFT/CZJGDiW7aHJOV6aRKrYgwSUxFyf0sia
         5cn26a7Zta0tWjO7CDBYlgJEF8nS/bsgJnCh4=
Received: by 10.141.214.38 with SMTP id r38mr5265242rvq.258.1273030610589; 
	Tue, 04 May 2010 20:36:50 -0700 (PDT)
Received: by 10.140.134.6 with HTTP; Tue, 4 May 2010 20:36:50 -0700 (PDT)
In-Reply-To: <k2l408104421005041911t32652fb7ie9618a301d998983@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146368>

Haven't read through all the stuff, sorry if it is already coverd or
not related.
But as a newbie, I found following, found on this list, quiet helpful.

A successful Git branching model
http://nvie.com/git-model

Best Regards,
Mac Lin

2010/5/5 Robert Buck <buck.robert.j@gmail.com>:
> Wow, this is really great folks. Let me look at these links again.
>
> Great stuff. Thank you,
>
> -Bob
>
> On Tue, May 4, 2010 at 9:10 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
>> Hi Robert,
>>
>> Robert Buck wrote:
>>
>>> We have multiple teams, lots of developers, and would like to use a
>>> variant of the dictator-lieutenant scheme discussed in published
>>> subject matter.
>>>
>>> However, I find it rather challenging finding any subject matter th=
at
>>> provides reasonable detail.
>>
>> Probably you have run into these already. =A0But for reference...
>>
>> To be a maintainer:
>>
>> =A0- the gitworkflows(7) page[1]
>>
>> The kernel does not follow all of these practices, but maybe similar
>> projects could benefit from some. :)
>>
>> To be a =93leaf=94 contributor (does not require git):
>>
>> =A0- the Linux wireless git guide[2]
>> =A0- submitting patches to linux-wireless.git[3]
>> =A0- guide to tip.git (Linux=92s x86 architecture support subsystem)=
 [4]
>>
>> To build a throw-away integration branch:
>>
>> =A0- Stephen Rothwell=92s linux-next tree[5]
>>
>> To be, well, anyone:
>>
>> =A0- =93everyday git in 20 commands or so=94 [6]
>>
>> Patch flow:
>>
>> =A0- for Linux wireless [7]
>> =A0- for git [8]
>>
>> Separate =93internal use=94 and =93public=94 trees:
>>
>> =A0- nouveau/linux-2.6 [9]
>>
>>> What I'd like to find are concrete
>>> examples, step-by-step, of specifically how to:
>>
>> If you find these, information for each about
>>
>> =A0- where you expected to find it
>> =A0- where you actually found it
>> =A0- how helpful that information was
>>
>> would be very useful. =A0It would be nice to be able to update =93ev=
eryday git=94,
>> the user manual, the reference manual pages, and other documents to =
make
>> this sort of question easier to answer.
>>
>> Hope that helps,
>> Jonathan
>>
>> [1] http://www.kernel.org/pub/software/scm/git/docs/gitworkflows.htm=
l
>> [2] http://wireless.kernel.org/en/developers/Documentation/git-guide
>> [3] http://wireless.kernel.org/en/developers/Documentation/Submittin=
gPatches
>> [4] http://people.redhat.com/mingo/tip.git/readme.txt
>> [5] http://git.kernel.org/?p=3Dlinux/kernel/git/next/linux-next.git;=
a=3Dtree;f=3DNext
>> [6] http://www.kernel.org/pub/software/scm/git/docs/everyday.html
>> [7] http://wireless.kernel.org/en/developers/process
>> [8] https://git.wiki.kernel.org/index.php/MaintNotes
>> [9] http://lists.freedesktop.org/archives/nouveau/2009-March/002765.=
html
>> http://cgit.freedesktop.org/nouveau/linux-2.6/
>> =91git rebase=92 is the main tool here.
>>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
