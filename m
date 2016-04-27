From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/3] mmap(win32): avoid copy-on-write when it is
 unnecessary
Date: Wed, 27 Apr 2016 20:51:36 +0200
Message-ID: <57210A38.4080203@kdbg.org>
References: <cover.1461335463.git.johannes.schindelin@gmx.de>
 <3e2a45e60e2905f52f962604cf19a0e5e39b9b1b.1461335463.git.johannes.schindelin@gmx.de>
 <571FB923.9040808@kdbg.org> <alpine.DEB.2.20.1604270834440.2896@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sven Strickroth <email@cs-ware.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 27 20:51:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avUYw-0006Nh-Fs
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 20:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbcD0Svr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 14:51:47 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:43162 "EHLO bsmtp1.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751866AbcD0Svq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 14:51:46 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 3qw8FP72x1z5tlK;
	Wed, 27 Apr 2016 20:51:37 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id E9BDB5230;
	Wed, 27 Apr 2016 20:51:36 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <alpine.DEB.2.20.1604270834440.2896@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292786>

Am 27.04.2016 um 08:43 schrieb Johannes Schindelin:
> On Tue, 26 Apr 2016, Johannes Sixt wrote:
>> Should we insert a check for MAP_PRIVATE to catch
>> unexpected use-cases (think of the index-helper daemon effort)?
>
> I agree, we should have such a check. The line above the `die("Invalid
> usage ...")` that you can read as first line in above-quoted hunk reads:
>
> 	if (!(flags & MAP_PRIVATE))
>
> So I think we're fine :-)

Oh, well... I thought I had checked the code before I wrote my question, 
but it seems I was blind... ;)

Thanks,
-- Hannes
