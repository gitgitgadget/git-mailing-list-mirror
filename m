From: John <john@puckerupgames.com>
Subject: Re: serious performance issues with images, audio files, and other
 "non-code" data
Date: Tue, 25 May 2010 12:12:49 -0400
Message-ID: <4BFBF701.6060901@puckerupgames.com>
References: <4BEAF941.6040609@puckerupgames.com> <20100514051049.GF6075@coredump.intra.peff.net> <4BED47EA.9090905@puckerupgames.com> <20100517231642.GB12092@coredump.intra.peff.net> <4BF2E168.2020706@puckerupgames.com> <20100518191933.GB2383@coredump.intra.peff.net> <alpine.LFD.2.00.1005181528550.12758@xanadu.home> <20100518194105.GA4723@coredump.intra.peff.net> <alpine.LFD.2.00.1005181557250.12758@xanadu.home> <4BF9C678.6010108@puckerupgames.com> <7vaarq14me.fsf@alter.siamese.dyndns.org> <4BFB7C24.10609@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue May 25 18:15:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGwmR-0000Ii-Gv
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 18:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493Ab0EYQOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 12:14:19 -0400
Received: from mailbigip.dreamhost.com ([208.97.132.5]:41479 "EHLO
	postalmail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932403Ab0EYQOQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 May 2010 12:14:16 -0400
Received: from [10.3.1.118] (unknown [65.202.32.252])
	by postalmail-a4.g.dreamhost.com (Postfix) with ESMTP id 5E61E11E115;
	Tue, 25 May 2010 09:14:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <4BFB7C24.10609@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147714>

On 05/25/2010 03:28 AM, Michael J Gruber wrote:
> Junio C Hamano venit, vidit, dixit 24.05.2010 03:16:
>> John<john@puckerupgames.com>  writes:
>>
>>> Is there any reason why someone would NOT want the above
>>> ".gitattributes" defined by default?
>>
>> Other than that our originally intended target audience are people who use
>> git as a source code control system, not much.
>>
>
> and other than that many people use clean/smudge filters to make git
> happily and efficiently deltify compressed file formats (such as gz,
> bz2, zip) and still keep compressed checkouts...
>
> and other than that which you (plural) and I are not thinking of right now.
>
> Let the defaults be as they are (fit for source control in the proper
> sense), it's easy enough to change them for other use cases.

That's fine. We all have different ideas what revision control means. So long as it's clear what git 
considers "source" and what it considers out of scope, what the defaults are, and what the 
limitations are, potential users can more fairly evaluate git to see if it fits their needs.

For example, code libraries and shell utilities may not require anything more complicated than 
line-by-line text-based patches in revision control.

On the other hand, projects such as web sites, mobile phone apps, desktop applications, (and games 
:) have lots of "source" that is not code.  Even XML, which is text-based, but not line-based (and 
need not contain any newlines), may present a problem for git in this respect.

Perhaps a section in the manual with a header such as "Handling non-text files", or "Revision 
control for media, XML, and other non line-oriented files" would clear this all up. You could almost 
cull the body of it from this thread and other similar threads.
