From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v9 00/19] index-helper/watchman
Date: Tue, 10 May 2016 16:35:19 +0100
Message-ID: <5731FFB7.20006@ramsayjones.plus.com>
References: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
 <xmqqa8jyuczj.fsf@gitster.mtv.corp.google.com>
 <1462832134.24478.49.camel@twopensource.com>
 <xmqqy47iswhj.fsf@gitster.mtv.corp.google.com>
 <1462881130.3018.13.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue May 10 17:35:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b09h8-00083W-No
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 17:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbcEJPf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 11:35:29 -0400
Received: from avasout08.plus.net ([212.159.14.20]:48248 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbcEJPf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 11:35:28 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout08 with smtp
	id sfbK1s0052D2Veb01fbL1E; Tue, 10 May 2016 16:35:21 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=O6PEx0JW c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=LWXO4h5D5RV6_GyL5UQA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <1462881130.3018.13.camel@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294148>



On 10/05/16 12:52, Dennis Kaarsemaker wrote:
> On ma, 2016-05-09 at 15:22 -0700, Junio C Hamano wrote:
>> It passes on one box and fails on another.  They both run the same
>> Ubuntu 14.04 derivative, with same ext3 filesystem.  The failing one
>> is on a VM.
> 
> Same here, except ext4 instead of ext3. Failing on a virtual machine,
> not failing on a physical one.

I can confirm the trend:

    Linux Mint 17.3, ext4 - bare-metal pass, (Virtual Box) VM fail.

ATB,
Ramsay Jones
