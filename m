From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Using git to track my PhD thesis, couple of questions
Date: Fri, 28 Aug 2009 10:34:24 +0200
Message-ID: <4A979690.1050601@gnu.org>
References: <20090827203402.GC7168@kisimul> <vpqk50pasek.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: seanh <seanh.nospam@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Aug 28 10:34:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgwv2-00070P-8r
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 10:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbZH1Iei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 04:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752186AbZH1Ieh
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 04:34:37 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:41995 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbZH1Ieg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 04:34:36 -0400
Received: by ewy2 with SMTP id 2so1922196ewy.17
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 01:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=y93wuhWLAEUfVOa2Mzs5COrpVZ3bj8g2bAfu4lt/9xo=;
        b=R8Yo06Zu9q0RlLMdebzpc/o66DqAr3W6YqIM0xf5fMKDLS+FG5WbOGBS3cv3j4PFK2
         m/lBDksvEEQU/BcfoketCqJUKTiUq2ZcgJxg5E3M7cAS4rFSDldxuZmL3FQ8B3fj7IQC
         X4NUPrzvKcRTKG/2poA34lCzGelE2CkAcMqVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=FUI+5wfuReXTWGGNW7e46z1EsmD5nr87D4aBzgKJQeEG5PCHMIMx2uODe2Aq6mTuqz
         j6w0MP8WldtxxA2oi8XTmyknebd4/ONOWU0TMoXiVMhi4Ns6UN08xaUXPTx16XjU8gRt
         TKCwKxiBkBy6izzHaRoYuTBNZf49Ep+qQEUjo=
Received: by 10.210.144.16 with SMTP id r16mr10993676ebd.22.1251448475853;
        Fri, 28 Aug 2009 01:34:35 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq.redhat.com [62.40.79.66])
        by mx.google.com with ESMTPS id 23sm1528296eya.11.2009.08.28.01.34.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Aug 2009 01:34:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1) Gecko/20090814 Fedora/3.0-2.6.b3.fc11 Lightning/1.0pre Thunderbird/3.0b3
In-Reply-To: <vpqk50pasek.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127278>

On 08/27/2009 10:55 PM, Matthieu Moy wrote:
> seanh<seanh.nospam@gmail.com>  writes:
>
>> I'm planning to use git to track my PhD thesis as I work on it and to
>> let my supervisors track it. I've setup a git repository and a gitweb
>> instance showing it. There are a couple of specific requirements.
>>
>> 1. My supervisors don't want to see all the little commits that I make
>> day by day.
>
> I'm not sure I understand why you want that. From what you say, your
> supervisors won't be looking at the LaTeX source, so they won't read
> the diffs for the commits. Instead, they will be looking at regular
> snapshots in PDF. So, how is that disturbing to keep the intermediate
> commits ?
>
>> So I'll commit to a dev branch, then whenever I've made
>> significant progress will merge it into a trunk branch. I want the trunk
>> branch to get all the changes but as one big commit, not inherit all the
>> little commits like a normal merge would do. I think this is a `git
>> merge --squash`.
>
> It is, but this also means _you_ will somehow lose your intermediate
> commits. Well, you may not really lose them, but after a merge
> --squash, you have two options to continue working: work on top of the
> squashed commit (and then your ancestry doesn't contain the small
> ones), or work on top of your previous branches (and then, you don't
> have a proper merge tracking, and you'll get spurious conflicts if you
> try another merge --squash).

You can also merge from the master to your working branch after every 
merge --squash.

    ... work on local ...
    git commit
    ... work on local ...
    git commit

    git checkout master
    git merge --squash local; git commit -m'day 1'
    git checkout local
    git merge master

> I also used a revision control system to write my Ph.D (Git was born
> after I started writting, so it wasn't Git yet), and my reviewing
> system has been all the more simple: when a chapter is done, send an
> email with the PDF attached, and "Hi, chapter $n is done, can you have
> a look?". That just works.

That's the same I did.  I used git, but only locally.  I never published 
the repository for my supervisor, she didn't care.

>> Normally I wouldn't commit the PDF files into the repo because
>> they're compiled files not source files, but it seems that just
>> building a PDF and committing it along with each commit to trunk
>> would be by far the easiest way to achieve this. But will git store
>> the PDFs efficiently, or will the repo start to get really big?
>
> Git will do delta-compression as it can, but I don't think PDFs will
> delta-compress very well, so your repository may grow rather quickly,
> yes. If possible, commit the PDFs on a separate branch so that you can
> easily keep your clean history small in disk space, and discard the
> PDFs if needed.

That's a good advice.  Remember to delete the branch reflog too if you 
want to clean the history.

You can also try \pdfcompresslevel=0, which would probably make 
delta-compression behave better at the expense of distributing bigger 
files to your supervisor.  If you use hyperref, see this:

    http://www.tug.org/pipermail/pdftex/2003-August/004402.html

Best of all would be to have filters doing/undoing the PDF compression, 
but I know of no free program doing this.

Paolo
