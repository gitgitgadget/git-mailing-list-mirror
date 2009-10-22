From: skillzero@gmail.com
Subject: Re: What's cooking in git.git (Oct 2009, #04; Wed, 21)
Date: Thu, 22 Oct 2009 08:31:17 -0700
Message-ID: <2729632a0910220831x4b67021eg772abc8b751ef7e5@mail.gmail.com>
References: <7veiovly35.fsf@alter.siamese.dyndns.org>
	 <m3ljj3es02.fsf@localhost.localdomain>
	 <fcaeb9bf0910220415v69c22ed9o4ab85b8858fbf187@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 17:31:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0zdQ-0008RG-Pi
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 17:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756099AbZJVPbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 11:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756051AbZJVPbO
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 11:31:14 -0400
Received: from mail-qy0-f194.google.com ([209.85.221.194]:49430 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755820AbZJVPbN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 11:31:13 -0400
Received: by qyk32 with SMTP id 32so5331406qyk.4
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 08:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=vbG4WmWLhlM9TErPsQfcbsYNkRvWx7cTLAHtYdDFBBs=;
        b=pl1tK7lJ21mGCIEgk/h89chGegX6x+RN03WD+D3lk4PdhiiDZWVTVcchOcF+s+eFEY
         NR7XfEOLWHas5GVfmtMiErJ1DDM4okNAOOCCZ1KilbpmOA4aGQyJDELK0bTnsCBJO/9u
         lynnNzuZmezli3izzelZlhkT657nGrnpFM0XA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=lXD+Fhg6j2NK+l/t47R86+dq/sTjk+uoGjo1AFndH0dHvEfWbK2Uo4g+JPbZqk4yHI
         eKrugiKeI05dBAk3WzB+a1DBfLRPTYt9UK3+j807wj06wyq2shwMEc2EAPw7cqss8eoG
         0SFbVlACFLGBaolTs4Wx4S6JvaDln0QlL/FBQ=
Received: by 10.224.110.146 with SMTP id n18mr4733754qap.278.1256225477963; 
	Thu, 22 Oct 2009 08:31:17 -0700 (PDT)
In-Reply-To: <fcaeb9bf0910220415v69c22ed9o4ab85b8858fbf187@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131026>

On Thu, Oct 22, 2009 at 4:15 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Thu, Oct 22, 2009 at 3:46 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>> * nd/sparse (2009-08-20) 19 commits.
>>>  - sparse checkout: inhibit empty worktree
>>>  - Add tests for sparse checkout
>>>  - read-tree: add --no-sparse-checkout to disable sparse checkout support
>>>  - unpack-trees(): ignore worktree check outside checkout area
>>>  - unpack_trees(): apply $GIT_DIR/info/sparse-checkout to the final index
>>>  - unpack-trees(): "enable" sparse checkout and load $GIT_DIR/info/sparse-checkout
>>>  - unpack-trees.c: generalize verify_* functions
>>>  - unpack-trees(): add CE_WT_REMOVE to remove on worktree alone
>>>  - Introduce "sparse checkout"
>>>  - dir.c: export excluded_1() and add_excludes_from_file_1()
>>>  - excluded_1(): support exclude files in index
>>>  - unpack-trees(): carry skip-worktree bit over in merged_entry()
>>>  - Read .gitignore from index if it is skip-worktree
>>>  - Avoid writing to buffer in add_excludes_from_file_1()
>>>  - Teach Git to respect skip-worktree bit (writing part)
>>>  - Teach Git to respect skip-worktree bit (reading part)
>>>  - Introduce "skip-worktree" bit in index, teach Git to get/set this bit
>>>  - Add test-index-version
>>>  - update-index: refactor mark_valid() in preparation for new options
>>
>> Hmmm... what is happening with that series?
>
> Junio concerned about CE_MATCH_IGNORE_VALID being used by both
> assume-unchanged and skip-worktree bits, which I did not resolve yet.
> I should really get back to the series when I have time.

Just an FYI, but I've been using this series for a while. I'm actually
relying on sparse support in our internal build system (via my private
build with this series) so I hope it doesn't go away :) I haven't
really noticed any problems (I thought the index state got out of sync
once, but I couldn't reproduce the problem later). Here's some
feedback though:

1. I found it confusing to have to append '/' to directories in the
sparse pattern list for directories. I always forget it requires them.
It would be nice to support the same rules as .gitignore in terms of
'/'.

2. It would be nice to have built-in support for a sparse modules file
and switching between them. Maybe .gitmodules could support "module"
or "sparsemodule" sections to list the patterns for that sparse
module. I've written a simple script to do this and it's what I use.
It just parses the INI-style file:

[module "MyProject"]
	App1
	Shared1
	!FolderIDontWant

Then I have a "module" script to read that file for a specified module
and switch to it:

git module switch MyProject

The script just parses `git show HEAD:.gitmodules` (so it works
without a working directory) and switches sparse modules by enabling
sparse, writing info/sparse-checkout, and doing a checkout:

sub cmd_switch
{
	# Enable sparse.
	my $currentCmd = "git config core.sparsecheckout true";
	system( $currentCmd ) == 0 or die( "error: $currentCmd\n" );
	
	# Write sparse patterns.
	my $gitDir = `git rev-parse --git-dir`;
	chop( $gitDir );
	my $sparsePath = $gitDir . "/info/sparse-checkout";
	if( $? != 0 ) { die( "error: read git directory failed $?\n" ); }
	open( FILE, ">", $sparsePath ) or die( "error: can't open '$sparsePath'\n" );
	foreach( @{$gModules->{$gModuleName}} )
	{
		print( FILE "$_\n" );
	}
	close( FILE );
	
	# Checkout using new sparse patterns.
	system( "git checkout" ) == 0 or die( "error: switch module failed\n" );
}

That said, the current level of sparse support provided by this series
is good enough for me because I can build my own scripts like this on
top of it to automate things.
