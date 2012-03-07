From: Joern Huxhorn <jhuxhorn@googlemail.com>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of Pull Requests
Date: Wed, 7 Mar 2012 14:04:10 +0100
Message-ID: <66B417CA-5F2C-4F6C-BF69-9383CB171C15@googlemail.com>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com> <7vhay9tqs6.fsf@alter.siamese.dyndns.org> <20120229225304.GA9099@burratino> <CAH5451miv_Mo_9tZV+mfDEHuEX0491duqAYh66aOzLsMLTNkaA@mail.gmail.com> <8762eoimp0.fsf@thomas.inf.ethz.ch> <7vmx80nt68.fsf@alter.siamese.dyndns.org> <4F504699.3070406@gmail.com> <20120302041924.GG5248@burratino> <4F505F8C.70802@gmail.com> <7vsjhrfprz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	opticyclic <opticyclic@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 14:04:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5GXr-00068D-VE
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 14:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757243Ab2CGNES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 08:04:18 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:61235 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757177Ab2CGNEQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 08:04:16 -0500
Received: by wejx9 with SMTP id x9so3762357wej.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 05:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=YoypH5V3a/F+eZNRxTsLKZ78QTB2BXe/eF2dsQGo08w=;
        b=h73H4sp4TZTyWbw+B0o4OJRFnPEgBv/GCBgdZLZMKVpxTB5BZjRvMifJMqeToh5YCH
         Ghviql78r80AvLnhukLPtthT6voyqKWhpHndgZ1vNmF7y8qt5yd+UM2yzUC5OE3s/NTF
         fG9zAHfROVD9SlCKzj2Dio0o39FF9CLPxWMDt3b9xWFkRyBon6KlM01+FAQuEdiD9MZa
         aCcDDG+BA/uDdW7jKQ/nLgAskcD7KCNDHjemqfwqqiC87ZgcR+LI2DKfxOwqEpPLW8ql
         bvlnkPpjOhZiXt2KmOrHyhLBc/eLAYkEeROQJP4bLzXIPqjh6GipXka45h3tb7JhY2k4
         SquA==
Received: by 10.216.132.8 with SMTP id n8mr896575wei.36.1331125455293;
        Wed, 07 Mar 2012 05:04:15 -0800 (PST)
Received: from [192.168.2.113] (p4FF0DC9F.dip.t-dialin.net. [79.240.220.159])
        by mx.google.com with ESMTPS id hn8sm94874498wib.11.2012.03.07.05.04.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Mar 2012 05:04:13 -0800 (PST)
In-Reply-To: <7vsjhrfprz.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192448>


On 02.03.2012, at 08:03, Junio C Hamano wrote:

> Neal Kreitzinger <nkreitzinger@gmail.com> writes:
> 
>> I realize this is not an exact match of the git-workflow, but you get
>> the idea.  I'm also new to mailinglists so I'm not sure if you can
>> change part of the subject line.  If not, a header in the body could
>> possibly be used.
> 
> The most important information is missing from your discussion: who are
> you trying to help, and what problem are you trying to solve?
> 
> When somebody posts a bug report to the list, with the current workflow,
> one of these things happens:
> 
> 1. It is an already solved issue. People who are familiar with the
>    existing fix may immediately answer, after running "git log", with "It
>    is fixed in v1.7.6". Or somebody not so familiar with the fix may
>    start "Does not reproduce for me who use the 'master' version. Git
>    from what era are you using?" conversation. I do not think a bug
>    tracker will help much in this case [*1*].
> 
> 2. It is an already answered non-issue. People who are familiar with the
>    previous discussion may point at the list archive, or somebody may dig
>    up the answer in the gmane archive. I do not know if a bug tracker
>    will help much in this case. Having a place to point people at is
>    better than having to write everything from scratch every time, but
>    (1) looking for the previous discussion is the more time consuming
>    part, and (2) once the previous discussion is found in the list
>    archive, we already have the necessary pointer.
> 
> 3. People who are familiar with the area of the problem may start "Need
>    more info" conversation. This may result in either finding the report
>    a non-issue (#1 or #2), or it may turn out to be a real issue, and
>    after further analysis, design and coding, may result in a fix.  Once
>    this flow starts rolling, the current workflow works very well.
> 
> 4. It falls through cracks, because nobody even categorizes it into the
>    above three.
> 
> I think the primary thing people want out of a bug tracker is to reduce
> the frequency of #4.  The real solution for it is to free up time from
> people who can do the later part of #3 so that they can spend more time to
> turn #4 into #3.
> 
> A way to do so is for members of the community who are capable of doing #1
> and #2 but not familiar enough with the code to do the later part of #3 to
> help with earlier part of #3 (i.e. triaging).
> 
> As I already said. the mailing-list based workflow serves us reasonably
> well once the ball is rolling in #3, and that was the reason why I
> suggested some heuristics to catch #4 in my previous message.  There are
> cases where the original reporter disappears during the "need more info"
> exchange, and in such a case a tracking system _may_ be able to help us
> remember that the issue is unresolved because of reporter inaction, but
> the tracker won't respond to "need more info" itself, and people tend to
> ignore automated nag mails, so there is still a need for warm body human
> bug secretary who interfaces with the reporter in such a case.
> 
> In any case, any solution that demands more things to be done by people
> near the core developers than they currently are already doing will make
> things worse by exacerbating the problem that comes from a bottleneck in
> the process.  I do not think your "The maintainer triages and assigns
> issues to other developers" or "The assigned developer marks the issue as
> 'done' after fixing it" will fly very well, regardless of the use of any
> bug tracker.
> 
> 
> [Footnote]
> 
> *1* If the symptom is so straightforward that a simple search in a bug
>     tracker can produce hits for an already solved issue, grepping in
>     Release Notes should equally work well.
> 
> *2* I do not know if this happens too often to be a real problem, though.

Sorry for the full quote.

I think the main problems with all issue trackers I know about are
- they are centralized, i.e. like SVN
- they all have a more or less clumsy web interface. All of them different, most of them configurable.

To get accepted in this community, an issue tracker would need to be decentralized (obviously including the ability to merge issue state and so on, likely git-based, probably simply included in the normal git repository of a project or in a separate issues-branch) and require a proper command line interface so it is properly scriptable (to feed it with threads from this mailing list, for example).

I'd love such a system.

I disagree with your assumption in 1. and *1*. A proper issue tracker has the ability to attach additional info (like stack traces or even a workaround) and files. Those would be searched, too, and would most likely not show up in the 'git log'.
An issue tracker could therefore remove noise from the mailing list which would automatically reduce workload on the core developers.

Your points 1. 2. and 3. all include "People who are familiar", i.e. it always involves some action from more or less cory developers. In case of an issue tracker, even duplicates and already solved issues (1. and 2.) serve a purpose since they'd indicate that either the previous solution hasn't been communicated good enough or that the duplicated issue has a high enough impact to creep up again.
Somebody needs to keep in mind all issues, in some way. I really wonder how you are able to cope with this task.

I'm not trying to lecture you that you are "doing it wrong". Your mailing-list based workflow seems to work incredibly well for you. But it doesn't really help to entice people into the community, either.

I'm (mostly) a silent observer of this list and just a (super-happy) user of git - but I really have a hard time getting a grip on the changes introduced in the different versions. You could obviously argue that I'm not trying hard enough since I'm not reading the 'git log' and all the diffs but I suspect that I'm already trying harder than most users.

For example, what happened to the git generation numbers discussed (in part) over here: http://comments.gmane.org/gmane.comp.version-control.git/177146
Are they already included in a released git version? If so, how would I find them? If not, why not? An issue tracker would be able to answer me, as a little-above-casual user, this question without resorting to asking you.

So I guess it all boils down to waiting until somebody is sufficiently annoyed by the current state of issue trackers and thus tries to implement a properly decentralized one that is likely based on plain text files (for easy merges) and features a proper way to query issues.

Just like Linus was sufficiently annoyed by the state of VCS.

Cheers,
Joern.