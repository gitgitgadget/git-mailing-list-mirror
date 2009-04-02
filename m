From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: On git 1.6 (novice's opinion)
Date: Thu, 2 Apr 2009 03:17:08 +0100
Message-ID: <200904020417.09993.jnareb@gmail.com>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de> <m3fxgz2h2n.fsf@localhost.localdomain> <49D32CE5.21780.391D18@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Thu Apr 02 04:19:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpCWg-0002Xi-Do
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 04:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934740AbZDBCRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 22:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934617AbZDBCRV
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 22:17:21 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:44896 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934690AbZDBCRU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 22:17:20 -0400
Received: by fxm2 with SMTP id 2so306888fxm.37
        for <git@vger.kernel.org>; Wed, 01 Apr 2009 19:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=zw/gfHeMUtLTQyw+RxO57+yqVocI9VvFI4sk8LeX7ic=;
        b=cxCDCZP1sITjFRl4LJaam0SkEKNSy5K8gD2bm/jN7hXo+G6ZQB38a6srut+Gdl97OJ
         HO0DRSNDNaShVHLhIdGUcn60l32MdNqYOxRek5Wi5CW4fJkTu+xobKgzGUJSMXtu8QBy
         fOxNnbRkXI+ntrrIZu8Hb3chjIH7iq32+KYI8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=KkYXiVzbcz61wEkkU1vNtXww9By6yWLeMnktUwtAaFxUKhfT31RUhA/p7NB15yUMIU
         v7oDHzTlIrFwr3rtuocwE4Z90IvaeQqRfg9nczIEbbF9Orb6/QNX3VYci/oXgjdSF7Sj
         c7S5u9L5NsaWAwhb9j+ORiJRKtThQkglx1MgU=
Received: by 10.204.100.201 with SMTP id z9mr3006653bkn.168.1238638636719;
        Wed, 01 Apr 2009 19:17:16 -0700 (PDT)
Received: from ?192.168.1.13? (abwy26.neoplus.adsl.tpnet.pl [83.8.248.26])
        by mx.google.com with ESMTPS id e17sm240286fke.8.2009.04.01.19.17.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Apr 2009 19:17:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <49D32CE5.21780.391D18@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115430>

On Wed, 1 April 2009, Ulrich Windl wrote:
> On 27 Mar 2009 at 7:09, Jakub Narebski wrote:
>> "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de> writes:
>>> On 27 Mar 2009 at 13:49, Michael J Gruber wrote: 
>>>> Ulrich Windl venit, vidit, dixit 27.03.2009 08:21:
>>> 
>>> [...]
>>> 
>>>> Keyword substitution and cvs/svn style version numbers are independent
>>>> issues. The sha1 describes a commit uniquely, one could use that as a
>>>> keyword.
>>> 
>>> However version numbers and time stamps have the property of being at least 
>>> partially ordered in respect of "newer/older". That property does not hold for 
>>> SHA-1 checksums. Just imagine suggesting users to upgrade from Microsoft 
>>> Word/004765c2a1e9771e886f0dbe87d4f89643cd6f70 to Microsoft 
>>> Word/00b7e6f51130f234a969c84ee9231a5ff7fc8a82 ;-)
>> 
>> That is why people use output of git-describe and _tag_ their releases,
>> and make embedding version number in released version (tarball / binary)
>> the job of make: see GIT-VERSION-GEN script in git sources, and how it
>> is used in Makefile.
> 
> OK, but imaginge someone sends you some file that originated from some git 
> version, maybe with minor modifications. Is there a way to find out from what git 
> version that file was derived? IMHO that's where "automatically replaced 
> placeholders" (like $id$) make sense.

Is it theoretical exercise or some real problem?


First, if the file with modification was taken from _release_ (from
tarball of sources), they can have placeholders like @@VERSION@@ replaced
by actual version (taken from git-describe / GIT-VERSION-GEN) by make
during "make dist" step, or its equivalent. Usually it would be e.g.
v1.6.2.1, as you make distribution of tagged release.

Second, if the files was taken from _repository_ (from version control),
you can get modification send as git diff of changes (which includes
shortened sha-1 of original file contents, and tools such as git-am --3way
can make use of this information to apply patch), or at least in unified
patch format.


Last, you can use `ident` attribute to make git replace the only
"automatic replaced placeholder" (keyword) that makes sense for
distributed VCS, namely $Id$ keyword which get replaced by 
$Id: <40-character hexadecimal blob object name>$; you can based
on this iformation find commit or commits that introduced this exact
version of a file.

See gitattributes(5).

>>>> Increasing version numbers are meaningless in a true DVCS world. What is
>>>> your 100th commit may not be someone else's, even if both your master's
>>>> heads are the same! This is why hg version numbers are a local thing.
>>>> They are merely a local shortcut for specifying a revision and serve the
>>>> same purpose as git's "backward" counts like HEAD~3 etc. Neither of them
>>>> work permanently, not even in a local repo, if you allow rebasing.
>>> 
>>> Maybe I didn't fully understand, but having a version number that is larger than 
>>> any parent's version numbers when doing a merge/commit doesn't look wrong to me.
>> 
>> I'm sorry to dissapoint you, but without central server assigning
>> numbers to commits it wouldn't simply work in distributed version
>> control world.  Take for example the following situation: somebody
>> clones your repository, and creates new commit on 'master' (trunk) and
>> it gets version number N.  Meanwhile you also independently create new
>> commit on 'master'... and without central authority it would also get
>> version number N.  Then you would merge (pull) his/her changes, and
>> you would have two commits with the same number; not something you want.
> 
> Anyway the result would have number "N+1". Maybe you misunderstood: I'm not 
> proposing to replace git's internal version numbering (SHA-1), but so introduce 
> some more comprehensible, primitive user-level numbering.

Errr... what? You would want to renumber _all_ (possibly large amount
of) fetched commits from other repository? It is very costly, and you
are left with commit numbers which are local to repository...

Or perhaps you would want to number only commits in first line parentage
of a branch, i.e. created in repository or fast-forwarded? This is what
Mercurial and (from what I understand) Bazaar does, and it also results
in commit numbers which are local to repository.

Or you were talking about having merge ("result") to have number "N+1".
But then you would have _two_ commits with number "N", and "N" would not
identify commit uniquely, even local for repository. Which means that
it would be useless.


Numbers local to repository cannot be used to pass in communication
to others (e.g. bug was caused by commit 5436); additionally I don't
see how revision number 7654 is any easier to use than HEAD~3, or
f348eae (copy'n'pasted).
 
>> Not to mention that you can have multiple roots (multiple commits with
>> no parent) in git repository; besides independent branches (like
>> 'man', 'html' or 'todo') it is usually result of absorbing or
>> subtree-merging other projects.  In 'master' branch there are 5 roots
>> or more: joined 'git-tools' (mailinfo / mailsplit), absorbed gitweb,
>> and subtree-merged gitk and git-gui.  And here you would again have
>> multiple commits with the same number...
> 
> Which would not harm, because it would be version N from committer X. Any if 
> committer X merges from anything else, the next number would be> N. I did not 
> claim that my method makes a total ordering of commits and merges possible.
> 
> I truly believe in unique IDs, but they are just not handy in every situation.

You have <branch>~<n>, <branch>@<n>, shortened sha-1, result of git-describe
that can be used in place of full sha-1...

-- 
Jakub Narebski
Poland
