From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix indentation problem in git-ls-files(1)
Date: Wed, 17 Mar 2010 07:47:10 +0100
Message-ID: <4BA07AEE.2080100@viscovery.net>
References: <m2tyswb1jp.fsf@igel.home>	<7v3a0fr740.fsf@alter.siamese.dyndns.org> <m3r5nzw05p.fsf@hase.home>	<ca433831003070927h4c3e24e1m75c7be88355f9663@mail.gmail.com>	<m23a01yzcc.fsf@igel.home> <4B9F2DB0.30400@viscovery.net> <m2pr34kpzm.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Mar 17 07:47:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nrn2H-0003f3-6r
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 07:47:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219Ab0CQGrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 02:47:16 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:4579 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550Ab0CQGrP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 02:47:15 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Nrn27-0007OV-Hl; Wed, 17 Mar 2010 07:47:11 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 2BBD41660F;
	Wed, 17 Mar 2010 07:47:11 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <m2pr34kpzm.fsf@igel.home>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142368>

Andreas Schwab schrieb:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> Andreas Schwab schrieb:
>>> The nested list in the description of the -t option wasn't properly
>>> indented.  Additionally, make it a horizontal labeled list since the
>>> labels are all short.
>> IMHO, converting a vertical list to a horizontal list is a step in the
>> wrong direction, even if the labels are short. It is far easier to scan a
>> vertical list for a match than a horizontal list.
> 
> The linebreak after the label is useless when all labels are much
> shorter than the indentation.

I use Junio's man pages, and they look like so:

       -t
           Identify the file status with the following tags
           (followed by a space) at the start of each line:

           H   cached
           S   skip-worktree
           M   unmerged
           R   removed/deleted
           C   modified/changed
           K   to be killed
           ?   other

and the HTML version at
http://www.kernel.org/pub/software/scm/git/docs/git-ls-files.html looks OK
as well. I see nothing that needs fixing in either case.

-- Hannes
