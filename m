From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH] add --porcelain option to git-push
Date: Thu, 25 Jun 2009 15:30:17 -0400
Message-ID: <4A43D049.3030903@elder-gods.org>
References: <20090622214032.GC19364@coredump.intra.peff.net>	<20090623011001.GA15352@cthulhu> <7vtz249lpf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 21:21:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJuW1-00011Y-5F
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 21:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbZFYTV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 15:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbZFYTV1
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 15:21:27 -0400
Received: from cthulhu.elder-gods.org ([140.239.99.253]:58776 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbZFYTV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 15:21:27 -0400
Received: from [192.168.1.214] (smtp.drti.com [65.127.223.98])
	by cthulhu.elder-gods.org (Postfix) with ESMTPSA id 572F282207F;
	Thu, 25 Jun 2009 15:21:27 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
In-Reply-To: <7vtz249lpf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122238>

Junio C Hamano wrote:
> Larry D'Anna <larry@elder-gods.org> writes:
>
>   
>> If --porcelain is used git-push will produce machine-readable output.  The
>> output status line for each ref will be tab-separated and sent to stdout instead
>> of stderr.  The full symbolic names of the refs will be given.  For example
>>
>> $ git push --dry-run --porcelain master :foobar 2>/dev/null \
>>   | perl -pe 's/\t/ TAB /g'
>>
>> = TAB refs/heads/master:refs/heads/master TAB [up to date]
>> - TAB :refs/heads/foobar TAB [deleted]
>> ---
>>     
>
> Thanks.  Sign-off?
>
>   
Oops.  Yes, I sign-off on this patch.

    --larry
