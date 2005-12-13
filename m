From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: as promised, docs: git for the confused
Date: 13 Dec 2005 05:58:41 -0800
Message-ID: <861x0hxfn2.fsf@blue.stonehenge.com>
References: <20051209215414.14072.qmail@science.horizon.com>
	<7vmzj9zwfu.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512120827440.15597@g5.osdl.org>
	<20051212195319.11d41269.tihirvon@gmail.com>
	<Pine.LNX.4.64.0512121010550.15597@g5.osdl.org>
	<86y82qyrqs.fsf@blue.stonehenge.com>
	<20051213035842.GF10371@always.joy.eth.net>
	<86d5k1y7dp.fsf@blue.stonehenge.com>
	<7vzmn5bmlk.fsf@assigned-by-dhcp.cox.net>
	<7vd5k1bf40.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 14:58:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmAg8-00018h-EQ
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 14:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbVLMN6s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 08:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbVLMN6s
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 08:58:48 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:29041 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932261AbVLMN6r
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2005 08:58:47 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id B17698F850;
	Tue, 13 Dec 2005 05:58:42 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 14850-01-52; Tue, 13 Dec 2005 05:58:42 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 2AE648F93E; Tue, 13 Dec 2005 05:58:42 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.12.15.15; tzolkin = 13 Men; haab = 13 Mac
In-Reply-To: <7vd5k1bf40.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13578>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> Junio C Hamano <junkio@cox.net> writes:
>> The only Plumbing support is that ls-files takes --exclude-from=
>> and --exclude-per-directory= options.  It is up to the Porcelain
>> layer what names to use.
>> 
>> We agreed upon a convention to use .gitignore as per-directory
>> and .git/info/exclude (I think this came from existing practice
>> by Cogito back then) as the tree-wide fallback, when these two
>> flags were introduced to ls-files, for interoperability across
>> Porcelains.

Junio> ... and as Linus pointed out already, the barebone Porcelain-ish
Junio> that ship with git follows that convention as well.

I see now that grepping "gitignore" shows git-add.sh and
git-status.sh.  gitignore is indeed doc'ed in git-add.txt, but not in
git-status.txt.  Must've snuck in recently.  I'm trying to watch
"git-whatchanged -p Documentation/*", but I miss things sometimes.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
