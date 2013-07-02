From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: --follow is ignored when used with --reverse
Date: Tue, 02 Jul 2013 13:20:33 +0200
Message-ID: <51D2B781.7000906@viscovery.net>
References: <20130524012324.295dec77@hugo.daonet.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Alois Mahdal <Alois.Mahdal.1-ndmail@zxcvb.cz>
X-From: git-owner@vger.kernel.org Tue Jul 02 13:20:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Utyda-0000K8-ED
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 13:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193Ab3GBLUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 07:20:41 -0400
Received: from so.liwest.at ([212.33.55.13]:58853 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752151Ab3GBLUj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 07:20:39 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UtydO-0007MR-BA; Tue, 02 Jul 2013 13:20:34 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 1648D1660F;
	Tue,  2 Jul 2013 13:20:33 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <20130524012324.295dec77@hugo.daonet.home>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229393>

Am 5/24/2013 1:23, schrieb Alois Mahdal:
> ...query for when the file was really added,
> which I was trying to achieve with
> 
>     $ git -1 --reverse --follow several_times_renamed_file

Assuming you meant 'git log -1 ...' or similar. It won't do what you think
it would do because:

* -1 is a revision traversal options.

* --reverse is an "output" option.

This means: First, revisions are collected, at which point -1 is honored.
Second, the revisions found are listed in --reverse order.

When you have only one revision in the list, the output is the same with
or without --reverse ;-)

-- Hannes
