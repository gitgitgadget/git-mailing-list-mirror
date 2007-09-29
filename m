From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH] rebase -i: support single-letter abbreviations for the
 actions
Date: Sat, 29 Sep 2007 18:27:55 +0200
Message-ID: <46FE7D0B.4060806@qumranet.com>
References: <Pine.LNX.4.64.0709290231300.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 29 18:28:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbfAt-000689-ES
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 18:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756129AbXI2Q2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 12:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756098AbXI2Q2H
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 12:28:07 -0400
Received: from il.qumranet.com ([82.166.9.18]:49745 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754580AbXI2Q2G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 12:28:06 -0400
Received: from [10.64.7.42] (unknown [10.64.7.42])
	by il.qumranet.com (Postfix) with ESMTP id E400625028F;
	Sat, 29 Sep 2007 18:28:15 +0200 (IST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <Pine.LNX.4.64.0709290231300.28395@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59477>

Johannes Schindelin wrote:
> When you do many rebases, you can get annoyed by having to type out
> the actions "edit" or "squash" in total.
>
> This commit helps that, by allowing you to enter "e" instead of "edit",
> or "s" instead of "squash", and it also plays nice with "merge" or "amend"
> as synonyms to "squash".
>
>   

Can we make "amend" like squash, except that it keeps the first commit's 
authorship instead of the second?  I often merge a commit with some 
minor fix that comes later, and usually want to keep the original author 
record.

-- 
Any sufficiently difficult bug is indistinguishable from a feature.
