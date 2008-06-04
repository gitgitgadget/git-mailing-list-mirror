From: Michael Dressel <MichaelTiloDressel@t-online.de>
Subject: Re: [PATCH] describe match pattern for soft tags too
Date: Wed, 4 Jun 2008 21:06:15 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0806042104130.3410@pollux>
References: <alpine.LNX.1.10.0806031957360.3605@pollux> <20080603224839.GO12896@spearce.org> <7vy75lzqew.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Michael Dressel <MichaelTiloDressel@t-online.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 21:08:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3yLa-0004ky-Kk
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 21:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758345AbYFDTHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 15:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758276AbYFDTHl
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 15:07:41 -0400
Received: from mailout04.t-online.de ([194.25.134.18]:57804 "EHLO
	mailout04.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758066AbYFDTHl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 15:07:41 -0400
Received: from fwd32.aul.t-online.de 
	by mailout04.sul.t-online.de with smtp 
	id 1K3yJk-0003qt-00; Wed, 04 Jun 2008 21:06:40 +0200
Received: from [192.168.2.100] (r9Hfb0ZFYh2Pl1XQIVG33ca6xsgPJJpAWCBvTcOkeRUOJFhvs6cAsCB+HWV1hiOwRA@[84.163.197.25]) by fwd32.t-online.de
	with esmtp id 1K3yJN-0evXJg0; Wed, 4 Jun 2008 21:06:17 +0200
X-X-Sender: michael@pollux
In-Reply-To: <7vy75lzqew.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
X-ID: r9Hfb0ZFYh2Pl1XQIVG33ca6xsgPJJpAWCBvTcOkeRUOJFhvs6cAsCB+HWV1hiOwRA
X-TOI-MSGID: 10d155e0-d8dc-424a-ade0-7e1c6e9bc6bc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83811>


On Tue, 3 Jun 2008, Junio C Hamano wrote:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
>
>> Michael Dressel <MichaelTiloDressel@t-online.de> wrote:
>>>
>>> So far git describe --match <pattern> would apply the <pattern> only
>>> to tag objects not to soft tags. This change make describe apply
>>> the <pattern> to soft tags too.
>>
>> Whoops.
>
> Micronit.  They are called "lightweight" tags.  There aren't any hard tags
> either.
>
>> Signed-off-by tag?
>>
>> Assuming you supply Junio an SBO tag,
>>
>> Acked-by: Shawn O. Pearce <spearce@spearce.org>
>
> Thanks for proofreading.

Thanks for the comments.
I will sent in a new patch see:

[PATCH] describe: match pattern for lightweight tags too

Cheers,
Michael
