From: Andreas Ericsson <ae@op5.se>
Subject: git integration with monodevelop
Date: Wed, 12 Nov 2008 11:22:37 +0100
Message-ID: <491AAE6D.8030304@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>,
	monodevelop-list@lists.ximian.com,
	Michael Hutchinson <m.j.hutchinson@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 11:24:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0Ctu-0003Ye-6r
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 11:24:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbYKLKX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 05:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbYKLKX0
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 05:23:26 -0500
Received: from mail.op5.se ([193.201.96.20]:45563 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544AbYKLKXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 05:23:25 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A9BA21B80046;
	Wed, 12 Nov 2008 11:17:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ShRR3c1cHYfb; Wed, 12 Nov 2008 11:16:54 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 152DB1B80086;
	Wed, 12 Nov 2008 11:16:52 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100736>

Recently, I've started learning C#. More for fun than anything else,
but one of the mono core devs sniffed me out and said they've been
thinking of porting jgit to C# to get a working IDE integration in
monodevelop. Currently, the only option available (with IDE
integration anyways) to the poor C# devs is either Microsoft's
crappy VSS, or the less crappy but still far from fantastic
Subversion.

So in an effort to learn C#, I've decided to play along with this
(hopefully with some help from the MonoDevelop team), but it seems
to me that the best place to start is the fledgling libgit2 and link
that with git-sharp. The primary reason for this is ofcourse that I
think it'd be a terrible waste to have yet another from-scratch
implementation of git in a new language (ruby, java, C#, C...). The
secondary reason is that it would be neat to have more OSS projects
use my favourite scm.

Besides, getting something to rely on libgit2 early on is probably
the best way to get more people interested in making development of
it proceed rapidly.

Thoughts anyone?

Please reply-to-all as this goes cross-list
(currently, Cc ae@op5.se, spearce@spearce.org, git@vger.kernel.org,
m.j.hutchinson@gmail.com, in case monodevelop-list uses reply-to
header).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
