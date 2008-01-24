From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 24 Jan 2008 07:39:42 +0100
Message-ID: <DADD259A-504E-4D98-9C26-5CD9B35B59C1@zib.de>
References: <34103945-2078-4983-B409-2D01EF071A8B@sb.org> <alpine.LFD.1.00.0801230808440.1741@woody.linux-foundation.org> <98F90EB6-1930-4643-8C6C-CA11CB123BAA@sb.org> <76718490801231218i53c19e22lda34f2eec88627f8@mail.gmail.com> <1DC841ED-634F-412C-9560-F37E4172A4CD@sb.org> <76718490801231421l7b6552f8sec13f570360198b@mail.gmail.com> <4F906435-A186-4E98-8865-F185D75F14D4@sb.org> <76718490801231517h6d57e5bfkc19d394d38ad19db@mail.gmail.com> <DE7B2DE6-03B1-4781-92C7-096E591369A1@sb.org> <7vk5lzc3yr.fsf@gitster.siamese.dyndns.org> <46a038f90801232037t76e103edt1585d49b2ed19862@mail.gmail.com> <C3E61435-AAF8-4F30-ACD6-B083165B5441@sb.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Jay Soffian" <jaysoffian@gmail.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Theodore Tso" <tytso@mit.edu>, "Mike Hommey" <mh@glandium.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Jan 24 07:41:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHvlp-0002EB-DZ
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 07:41:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbYAXGk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 01:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbYAXGk2
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 01:40:28 -0500
Received: from mailer.zib.de ([130.73.108.11]:55576 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114AbYAXGk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 01:40:27 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0O6chbs019732;
	Thu, 24 Jan 2008 07:38:44 +0100 (CET)
Received: from [192.168.178.21] (brln-4db9567c.pool.einsundeins.de [77.185.86.124])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0O6cfWX019237
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 24 Jan 2008 07:38:42 +0100 (MET)
In-Reply-To: <C3E61435-AAF8-4F30-ACD6-B083165B5441@sb.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71592>


On Jan 24, 2008, at 6:30 AM, Kevin Ballard wrote:

> On Jan 23, 2008, at 11:37 PM, Martin Langhoff wrote:
>
>> Kevin, other people have already started posting nice nuggets of test
>> cases. Where are *your* test cases? That would be a nice way to "have
>> the last word" on this ;-)
>
>
> I'm planning on devoting time this weekend to learning enough about  
> git to be able to start hacking. I'm just too busy during the week  
> to be able to devote the dedicated time necessary to this stuff.  
> Hopefully I'll actually be able to start producing stuff this weekend.

You do not need to learn much about git to post a test case.
Only a few lines of shell code that demonstrate how git fails to
handle a specific situation is needed.  To do this, knowledge
about the internals of git does not necessary help.  It should be
sufficient to know how to use git.

You may start with a simple shell script and send it to the list.
Though, a real patch would be the preferred way.  For this, you
should have a quick look into the t/ subdirectory.  Just open any
of the tNUMBER*.sh files.  It should be quite obvious how your
sequence of shell commands could be cast into a git test script.

	Steffen
