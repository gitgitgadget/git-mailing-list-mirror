From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] MALLOC_CHECK: Allow checking to be disabled from config.mak
Date: Thu, 11 Oct 2012 21:17:41 +0100
Message-ID: <50772965.7070607@ramsay1.demon.co.uk>
References: <50706B54.8090004@ramsay1.demon.co.uk> <7vbogfquc8.fsf@alter.siamese.dyndns.org> <5075B47C.6030607@ramsay1.demon.co.uk> <7v391mcf3p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Elia Pinto <gitter.spiros@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 22:20:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMPFZ-0003Pb-6a
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 22:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756383Ab2JKUUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 16:20:46 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:57649 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751395Ab2JKUUq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 16:20:46 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 34750400513;
	Thu, 11 Oct 2012 21:20:44 +0100 (BST)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 88FBD400512;	Thu, 11 Oct 2012 21:20:43 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta010.tch.inty.net (Postfix) with ESMTP;	Thu, 11 Oct 2012 21:20:42 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7v391mcf3p.fsf@alter.siamese.dyndns.org>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207510>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> Yes, so I can simply disable the malloc checks in my ~/.bashrc file.
>> However, it would be disappointing to have my config tweeks in two
>> places ... :(
>>
>> I guess I can live with it ...
> 
> You could write "export that-variable" in your config.mak yourself
> ;-)  Let's apply the patch as-is.

*smacks forehead* ;-P ... now why didn't I think of that! *blush* [1]

Thanks!

ATB,
Ramsay Jones

[1] I am more than a little disappointed in myself, because I have done
exactly this, *several* times, on other (much older) projects.
