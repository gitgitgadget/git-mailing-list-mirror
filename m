From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: Index format v5
Date: Mon, 07 May 2012 20:57:08 +0200
Message-ID: <4FA81B04.9060402@dewire.com>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com> <7vd36lf634.fsf@alter.siamese.dyndns.org> <CALgYhfMQMdtcNN2a_BwPMkb_aHGr9ivBpWOSEjkqjGiaVzgS_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	trast@student.ethz.ch, mhagger@alum.mit.edu, peff@peff.net,
	spearce@spearce.org, davidbarr@google.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 20:57:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRT7V-0003As-00
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 20:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757557Ab2EGS5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 14:57:12 -0400
Received: from mail.dewire.com ([83.140.172.130]:20414 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757346Ab2EGS5M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 14:57:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id AA7AE8FC73;
	Mon,  7 May 2012 20:57:10 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id krwm7vkpr49P; Mon,  7 May 2012 20:57:10 +0200 (CEST)
Received: from Robin-Rosenbergs-MacBook-Pro.local (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id 35F088FC72;
	Mon,  7 May 2012 20:57:10 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:13.0) Gecko/20120425 Thunderbird/13.0
In-Reply-To: <CALgYhfMQMdtcNN2a_BwPMkb_aHGr9ivBpWOSEjkqjGiaVzgS_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197296>

Thomas Gummerer skrev 2012-05-03 23.38:
> On Thu, May 3, 2012 at 8:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Thomas Gummerer <t.gummerer@gmail.com> writes:
>>>    1 nul byte to terminate the filename.
>>>
>>>    A 16-bit 'flags' field split into (high to low bits)
>>>
>>>      1-bit assume-valid flag
>>
>> Is this "assume unchanged"?
>

> I have taken this from the old index format documentation, which
> describes it as assume-valid flag, but I guess it's assume unchanged then.

The bit for "assume unchanged" is called CE_VALID in the code.

-- robin
