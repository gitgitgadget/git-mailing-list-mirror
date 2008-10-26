From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: Sun, 26 Oct 2008 17:57:21 +0200
Message-ID: <94a0d4530810260857u7c0cb122g8147b9484108f539@mail.gmail.com>
References: <ge0rla$mce$1@ger.gmane.org> <m3r663h276.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mercurial@selenic.com
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 16:58:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ku80h-0003gr-IA
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 16:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913AbYJZP5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 11:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754190AbYJZP5W
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 11:57:22 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:52959 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913AbYJZP5V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 11:57:21 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1718026rvb.1
        for <git@vger.kernel.org>; Sun, 26 Oct 2008 08:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=eyT24nlBSoZFUdFoJCpp6Pj0bcXS/oAXyO5OEq51U20=;
        b=bU/lF6b/VCNyyz09WIfFnh/4m3RjHdrVANKOLtquPcxN6jhZKeVn5pOvOMrC5k5SEo
         F7dk2gBvqXO8vrdh68MgYSuXUJWy4jgc4Qj465LDFS60u9XSqA6wT4a+B6/8KjHGxMod
         FnoI2gUeHRZhGjeuIr7FdsESAl0VMYxE31CI4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=aESVKe3TJia7nlmM4oimH1P/nKBK2uSRmBsEbTvGuqk8kpLFJaCUyLRdTxu5FcJiXN
         GNTqmrKvIy+H5nSskgiwyiv9p2j1x2z0Gzwpl9FaRlKUOa3s/YgI/WKvoHAM6LTdZK6J
         k1o1Tc5aMnHq8huNc2SQMn0gtpnp235H0n9vw=
Received: by 10.141.43.5 with SMTP id v5mr2626399rvj.216.1225036641108;
        Sun, 26 Oct 2008 08:57:21 -0700 (PDT)
Received: by 10.140.171.5 with HTTP; Sun, 26 Oct 2008 08:57:21 -0700 (PDT)
In-Reply-To: <m3r663h276.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99168>

On Sun, Oct 26, 2008 at 4:15 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> [Cc: gmane.comp.version-control.git,
>     gmane.comp.version-control.mercurial.general]
>
> walt <w41ter@gmail.com> writes:
>
>> No, no, I'm not the one calling for a vote.  You old-timers here
>> will know the name Matt Dillon, who is leading the dragonflybsd
>> project (www.dragonflybsd.org).
>>
>> Matt is the one who is calling for the vote in his thread "Vote
>> for your source control system" in the dragonfly.kernel group,
>> accessible via nntp://nntp.dragonflybsd.org.
>>
>> I've already cast my vote for git, which I confess is not very
>> honest because I've never even tried mercurial.  I would truly
>> be grateful to anyone here who knows both git and mercurial who
>> could contribute verifiable facts to that debate.

<snip/>

> 3. Repository design and performance.
>
>   Git is designed around idea of content adressed object database;
>   objects are adressed by their content (by SHA-1 of their type and
>   content).  Commits for example have information about author and
>   comitter, pointer to zero or more parent commits, and pointer to
>   tree object (representing top directory in project).  Branches
>   and tags are just pointers to DAG (Direct Acyclic Graph) of
>   commits; current branch is denoted by HEAD pointer to branch.
>   There is explicit staging area called 'index', used for conflict
>   resolution dureing merges, and which can be used to make commit in
>   stages, allow uncomitted changes in tree (in working directory).
>   Git design supports very well multiple branches in single
>   repository, and tracking changes in multiple remote repositories
>   each with multiple branches.
>
>   Mercurial, from what I have read of its documentation, and from the
>   few discussion on #revctrl IRC channel, and from what I understand
>   is based on changes stored per file, with information about files
>   and their versions stored in manifest (flat) file, and with changes
>   described in changelog-like file (changerev).  One of limitations
>   of "record" database (as opposed to Git's object database) is that
>   commits can have zero (root commit), one or two (merge commits)
>   parents only.  There is apparent in design that Mercurial was
>   developed with single branch per repository paradigm in mind.
>   Local branches from what I understand are marked in CVS-like
>   fashion using tags.  Tags are implemented as either local to
>   repository and untransferable, or as .hgtags versioned file with
>   special case treatment.  (But I'm obviously biased here).
>
>   Git and Mercurial have similar performance, although it is thought
>   that due to design Mercurla has faster patch applying and is
>   optimized for cold cache case, while Git has faster merging and is
>   optimized for warm cache case.
>
>   Mercurial may have (or had) problems with larger binary files, from
>   what I have heard.

The fact that hg is changeset based means that certain operations are
slower, like checkout a specific commit. In hg my bet is you would
need to gather a bunch of changesets while in git the operation is
done in a single step.

It also means that bare clones are not possible in hg, or at least
very complicated.

Note: I'm not sure if what I'm claiming is correct.

-- 
Felipe Contreras
