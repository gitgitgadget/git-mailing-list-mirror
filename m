From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Mon, 17 Oct 2011 00:04:35 +0200
Message-ID: <4E9B54F3.5070203@ira.uka.de>
References: <4E96D819.20905@op5.se> <loom.20111013T152144-60@post.gmane.org> <1318517194.4646.30.camel@centaur.lab.cmartin.tk> <loom.20111013T171530-970@post.gmane.org> <1318525486.4646.53.camel@centaur.lab.cmartin.tk> <loom.20111013T193054-868@post.gmane.org> <7vzkh44ug1.fsf@alter.siamese.dyndns.org> <loom.20111013T203610-130@post.gmane.org> <20111014013830.GA7258@sigill.intra.peff.net> <4E980093.6040704@ira.uka.de> <20111014095447.GC2856@victor.terreactive.ch> <loom.20111016T201930-426@post.gmane.org> <7vy5wkptan.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: arQon <arqon@gmx.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 00:05:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFYpS-0005NL-1s
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 00:05:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367Ab1JPWE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 18:04:58 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:45215 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752157Ab1JPWE5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Oct 2011 18:04:57 -0400
Received: from dslb-088-066-033-093.pools.arcor-ip.net ([88.66.33.93] helo=[192.168.2.231])
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 465 
	id 1RFYp1-0001nv-Nn; Mon, 17 Oct 2011 00:04:52 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.23) Gecko/20110920 SUSE/3.1.15 Thunderbird/3.1.15
In-Reply-To: <7vy5wkptan.fsf@alter.siamese.dyndns.org>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1318802692.145727000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183737>

Am 16.10.2011 22:37, schrieb Junio C Hamano:
> I doubt the full status output is better behaviour. For one thing, you do
> not need full status as by definition branch switching would only have
> local changes as a result (i.e. you will not see "Changes to be committed"
> section).

?? After "git add" on a changed file I see it under "Changes to be 
committed". And branch switching still works (with newest git from 
master branch):

# On branch two
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   test1.txt
#
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working 
directory)
#
#       modified:   test2.txt
#

Small inconsistency: On the other branch instead of "Changes not staged 
for commit:" the text "Changed but not updated:" is printed, everything 
else is unchanged
