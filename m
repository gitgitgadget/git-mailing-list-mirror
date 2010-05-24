From: John <john@puckerupgames.com>
Subject: Re: serious performance issues with images, audio files, and other
 "non-code" data
Date: Mon, 24 May 2010 03:01:37 -0400
Message-ID: <4BFA2451.6090507@puckerupgames.com>
References: <4BEAF941.6040609@puckerupgames.com> <20100514051049.GF6075@coredump.intra.peff.net> <4BED47EA.9090905@puckerupgames.com> <20100517231642.GB12092@coredump.intra.peff.net> <4BF2E168.2020706@puckerupgames.com> <20100518191933.GB2383@coredump.intra.peff.net> <alpine.LFD.2.00.1005181528550.12758@xanadu.home> <20100518194105.GA4723@coredump.intra.peff.net> <alpine.LFD.2.00.1005181557250.12758@xanadu.home> <4BF9C678.6010108@puckerupgames.com> <7vaarq14me.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 24 09:01:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGRfV-0005pG-Tr
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 09:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756186Ab0EXHBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 03:01:41 -0400
Received: from caiajhbdcagg.dreamhost.com ([208.97.132.66]:44048 "EHLO
	postalmail-a8.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756162Ab0EXHBk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 May 2010 03:01:40 -0400
Received: from dev.newmarket (c-71-225-50-119.hsd1.pa.comcast.net [71.225.50.119])
	by postalmail-a8.g.dreamhost.com (Postfix) with ESMTP id 82325AAC00;
	Mon, 24 May 2010 00:01:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <7vaarq14me.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147605>

Ok, fair enough. It's your project, and you are defining "source control" as 
that which git supports: non-binary, line-by-line text only, C, bash .. no 
images, documents, etc.

I only wish that definition of "source" had been more clear from the get-go.

Perhaps a front and center blurb on the git home page or mission statement might 
clarify things for those of us who have different definitions of "source"?  That 
way, you wouldn't have to be bothered by folks trying to version all their 
project assets with git. For example, you could specify that non-text is out of 
scope for git, (or however you wish to define "source").


On 05/23/2010 09:16 PM, Junio C Hamano wrote:
> John<john@puckerupgames.com>  writes:
>
>> Is there any reason why someone would NOT want the above
>> ".gitattributes" defined by default?
>
> Other than that our originally intended target audience are people who use
> git as a source code control system, not much.
>
