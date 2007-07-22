From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sun, 22 Jul 2007 22:26:30 +0200
Message-ID: <200707222226.30788.jnareb@gmail.com>
References: <85lkdezi08.fsf@lola.goethe.zz> <200707221406.25541.jnareb@gmail.com> <857iosmto0.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jul 23 00:13:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICjg5-0001Bz-Ee
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 00:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758257AbXGVWNP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 18:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755975AbXGVWNO
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 18:13:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:49345 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755431AbXGVWNN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 18:13:13 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1034702ugf
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 15:13:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Imq1AkbRN37kqeXmUjlD2JwqFXCR79BTttu7xeHCS3VKY+z0yvYSzyPx9Odi4fioT8qyWCJHr1caZeHqcPAUUqqLkPm4m2jwdamAlMXZsORbySu2nQaEltx/mMbzbpG6Su0Jd1ZnbuYySpp+kGrgaUoMoiz5tgi86Ixi09aRB+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Ka1sJhiJpm/FsjCLrEq4ejsAVSl14WYhoHDnjld8VCw1iEv2MRZ9z1U1tQCp/jHLJ/WOdtPrHo3gBMDMFRgZieHgO01xHOqqBSl5mDWjbAEinrhsHNkDtJ3aeDAu1jcSoSKsFCpx1PxPDpqHA1p2J/5Zaiq9BoppWIm56uF6QQA=
Received: by 10.86.50.8 with SMTP id x8mr2012954fgx.1185142391233;
        Sun, 22 Jul 2007 15:13:11 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id k29sm12532549fkk.2007.07.22.15.13.08
        (version=SSLv3 cipher=OTHER);
        Sun, 22 Jul 2007 15:13:08 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <857iosmto0.fsf@lola.goethe.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53345>

David Kastrup wrote:
 
> "I can follow you, but I disagree with your conclusion" is perfectly
> fine for now since I am going to propose something else, anyway.
> 
> Thanks for the feedback.  It gave me some good ideas.

You are welcome.
 
> Jakub Narebski <jnareb@gmail.com> writes: 
>> On Sun, 22 July 2007, David Kastrup wrote:
>>> Jakub Narebski <jnareb@gmail.com> writes:
>>>> David Kastrup wrote:
>>>>
>>>>> I must be really bad at explaining things, or I am losing a fight
>>>>> against preconceptions fixed beyond my imagination.
>>
>> Or you are wrong...
> 
> Well, there is little reason for you to take my word on it, but I
> happen to have a history of designing and implementing systems where I
> have been responsible for every single byte, bootloader, firmware,
> applications, target compiler, assembler, whatever.  I have been
> exposed to Unix and working with it several years before Linux even
> existed.  I also have a track record of being not exactly stupid.
> 
> So I pretty much can rule out that I am wrong on the factual side.

Big words.

First, there is little matter of something like area of competence.
You might be systems master, but your idea about snapshot based 
distributed revision control systems can be wrong because DSCM are 
outside the area you know most about.

Second, even if you are a master at given topic, you can still be wrong.

Mind you, I was not saying you are wrong. I was saying you could be.


[...] 
>> The only advantage to the "." idea is that it can use gitignore
>> mechanism (both in-tree .gitignore, tracked or not, and info/exclude
>> file). But I also think that the fact that gitignore mechanism is
>> recursive is more of disadvantage than advantage.
[...]
> The recursiveness of the gitignore mechanism has the advantage that
> when maintaining a large repository with actual or logical
> subprojects, one does not need to pick a single policy for all
> subprojects.  I think that is quite important.  It could possibly be
> achieved with some other method of having per-subproject
> configuration, but I see little wrong in using what is there and
> documented already.

I think it would be best implemented by repository config, e.g. 
core.dirManagement or something like that, which could be set to
 1. "autoremove" or something like that, which gives old behavior
    of untracking directory if it doesn't have any tracked files
    in it, and removing directory if it doesn't have any files
    in it.
 2. "noremove" or something like that, which changes the behaviour
    to _never_ untrack directory automatically. This can be done
    without any changes to 'tree' object nor index. It could be useful
    for git-svn repositories.
 3. "marked" or something like that, for which you have to explicitely
    mark directories which are not to be removed when empty.
 4. "recursive" or something like that, which would automatically mark
    as "sticky" all subdirectories added in a "sticky" repository.
    OR directory is not removed when empty if it is marked as such,
    or one of its parents is marked as such.
 
>> Second, the "easy implementation" is anything but easy. "git add ."
>> as a way to mark directory as "sticky" is not backward compatibile:
>> currently it mean to add _all contents_ of current directory.
>> Implementation is tricky: as we have seen trying to unlink '.' or
>> create '.' can unfortunately succeed on [some Sun OS, and UFS
>> filesystem] (which follows POSIX stupidly to the letter) f**king up
>> the filesystem.
> 
> I was not suggesting actually leaving any such calls in place: after
> all, they would presumably lead to error messages.  But I agree that
> this could lead to nasty surprises when somebody with a legacy version
> of git worked with a repository containing "." as explicit entries of
> some file type.

The "magic mode" solution _should_ work also with older git, I think.
 

>> Fourth, is very artificial. What would you put for filemode for '.'?
>> 040000 (i.e. directory)?
[...]
>> What would you put for sha1?  Sha1 of an empty directory?
> 
> Some fixed value.  Everywhere the same.  Not really relevant.

Relevant because it has to work with legacy git on strange operating 
systems. Because git has to fsck it (and adding special casing this 
"some fixed value" to git-fsck is bad, bad idea).

Note that sha1 cannot be sha1 of the tree. In working area '.' is self 
link. You cannot create self link in git repository object.

[...]
>>> And the repository is a versioned and hierarchically hashed version
>>> of the index, but its trees contain _no_ information that is not
>>> already inherently represented by the files alone. [...]
[...]
>> Trees do contain information which is not inherently present by the 
>> blobs.
> 
> Could you give examples for such information?  As long as we are not
> talking about _history_, I am at a loss at what else you mean.  File
> names and permissions?

File names and permissions. And they bind blobs and trees together.
Trees do not contain any info about history.

-- 
Jakub Narebski
Poland
