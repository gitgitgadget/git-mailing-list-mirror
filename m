From: david@lang.hm
Subject: Re: [RFC] Zit: the git-based single file content tracker
Date: Fri, 24 Oct 2008 12:53:21 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0810241251490.27333@asgard.lang.hm>
References: <gdok16$vh2$1@ger.gmane.org> <4901077A.7050904@gmx.ch> <cb7bb73a0810232355u6de0479cyc260c80227f44e59@mail.gmail.com> <m38wsei8ne.fsf@localhost.localdomain> <7vabct3l1e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Jean-Luc Herren <jlh@gmx.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 21:54:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtSjo-0008Uw-TP
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 21:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188AbYJXTxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 15:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbYJXTxK
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 15:53:10 -0400
Received: from mail.lang.hm ([64.81.33.126]:40466 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936AbYJXTxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 15:53:09 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m9OJqdUS020664;
	Fri, 24 Oct 2008 12:52:43 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <7vabct3l1e.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99057>

On Fri, 24 Oct 2008, Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
>
>> "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com> writes:
>>> On Fri, Oct 24, 2008 at 1:23 AM, Jean-Luc Herren <jlh@gmx.ch> wrote:
>>
>>>> If you decide against a shared repository, maybe you want to
>>>> consider to not use ".zit.file/", but ".zit/file/" as the
>>>> repository?  This would reduce the clutter to a single directory,
>>>> just like with ".git".  And moving files around wouldn't be that
>>>> much complicated.
>>>
>>> Right. I'll give that a shot.
>>
>> By the way RCS which I use for version control of single files use
>> both approaches: it can store 'file,v' alongside 'file' (just like
>> your '.zit.file/' or '.file.git/'), but it can also store files on
>> per-directory basis in 'RCS/' subdirectory (proposed '.zit/file/' or
>> '.zit/file.git/' solution)
>
> I am not opposed to the wish to track a single file (but I have to say I
> am not personally in need for such a feature), but I have to wonder from
> the technical point of view if one-repo-per-file is the right approach.

I just had what's probably a silly thought.

how close is a zit setup to a subproject setup?

David Lang
