From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: pack bitmap woes on Windows
Date: Wed, 12 Feb 2014 14:05:26 +0100
Message-ID: <52FB7196.7060209@viscovery.net>
References: <52FB2268.7080906@viscovery.net> <87mwhwa3s1.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-15?Q?Vicent_Mart=ED?= <tanoku@gmail.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Feb 12 14:05:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDZVN-0001xb-Va
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 14:05:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606AbaBLNFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 08:05:30 -0500
Received: from so.liwest.at ([212.33.55.18]:44422 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbaBLNF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 08:05:29 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WDZVH-0002tC-IM; Wed, 12 Feb 2014 14:05:27 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id DDD4516613;
	Wed, 12 Feb 2014 14:05:26 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <87mwhwa3s1.fsf@fencepost.gnu.org>
X-Enigmail-Version: 1.6
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241989>

Am 2/12/2014 13:55, schrieb David Kastrup:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> Running test suite of 'next' on Windows fails in t5310-pack-bitmaps with
>> the following symptoms. I haven't followed the topic. Have there been
>> patches floating that addressed the problem in one way or another?
>>
>> (gdb) run
>> Starting program: D:\Src\mingw-git\t\trash directory.t5310-pack-bitmaps/..\..\git.exe rev-list --test-bitmap HEAD
>> [New thread 3528.0x8d4]
>> Bitmap v1 test (20 entries loaded)
>> Found bitmap for 537ea4d3eb79c95f602873b1167c480006d2ac2d. 64 bits / 15873b36 checksum
> 
> Does reverting a201c20b41a2f0725977bcb89a2a66135d776ba2 help?

YES! t5310 passes after reverting this commit.

-- Hannes
