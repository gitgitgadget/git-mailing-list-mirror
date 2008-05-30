From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] perl/Git.pm: add parse_rev method
Date: Fri, 30 May 2008 15:03:09 -0700
Message-ID: <86mym7mov6.fsf@blue.stonehenge.com>
References: <20080530095047.GD18781@machine.or.cz>
	<1212179270-26170-1-git-send-email-LeWiemann@gmail.com>
	<20080530210531.GH18781@machine.or.cz>
	<7vd4n3iivt.fsf@gitster.siamese.dyndns.org>
	<86r6bjmpqc.fsf@blue.stonehenge.com> <484078C7.7020008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 31 00:04:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2Chf-0007Cm-A5
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 00:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbYE3WDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 18:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbYE3WDL
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 18:03:11 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:29234 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbYE3WDK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 18:03:10 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 856991DE262; Fri, 30 May 2008 15:03:09 -0700 (PDT)
x-mayan-date: Long count = 12.19.15.6.14; tzolkin = 2 Ix; haab = 17 Zip
In-Reply-To: <484078C7.7020008@gmail.com> (Lea Wiemann's message of "Fri, 30 May 2008 23:59:35 +0200")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83348>

>>>>> "Lea" == Lea Wiemann <lewiemann@gmail.com> writes:

Lea> Randal L. Schwartz wrote:
>> [Move to eval/die.]  No leak there.

Lea> I'm not an experienced Perl hacker, but I intuitively liked the throw/catch
Lea> method better than the eval/die method.

I *am* an experienced hacker, and every Perl hacker worth their salt
understands that "eval/die" *means* try/catch from other languages.

The extra layer of syntactic sugar is *not* worth it.  It merely obfuscates.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
