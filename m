From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] Re: [PATCH bc/connect-plink] t5601-clone: remove broken
 and pointless check for plink.exe
Date: Wed, 12 Aug 2015 20:31:44 +0200
Message-ID: <55CB9110.4060005@kdbg.org>
References: <55CA6066.5070500@kdbg.org>
 <866a41f50ef9b4807da72576a4bca717@www.dscho.org>
 <CABPQNSZHtAKbe6JwxRoK3LpCabfp6r2_kTmF1qokObt_yKnSDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: kusmabite@gmail.com,
	Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 12 20:31:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPaoa-0008PN-TN
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 20:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbbHLSbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 14:31:48 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:13653 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826AbbHLSbr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 14:31:47 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3ms0413Ywsz5tlF;
	Wed, 12 Aug 2015 20:31:45 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 0881452DE;
	Wed, 12 Aug 2015 20:31:45 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <CABPQNSZHtAKbe6JwxRoK3LpCabfp6r2_kTmF1qokObt_yKnSDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275793>

Am 12.08.2015 um 13:58 schrieb Erik Faye-Lund:
> On Wed, Aug 12, 2015 at 1:07 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>> FWIW Git for Windows has this patch (that I wanted to contribute
>> in  due time, what with being busy with all those tickets) to solve the
>> problem mentioned in your patch in a different way:
>>
>> https://github.com/git-for-windows/git/commit/2fff4b54a0d4e5c5e2e4638c9b0739d3c1ff1e45
>
> Yuck. On Windows, it's the extension of a file that dictates what kind
> of file it is (and if it's executable or not), not the contents. If we
> get a shell script written with the ".exe"-prefix, it's considered as
> an invalid executable by the system. We should consider it the same
> way, otherwise we're on the path to user-experience schizophrenia.
>
> I'm not sure I consider this commit a step in the right direction.

I, too, think that it is a wrong decision to pessimize git for the sake 
of a single test case.

-- Hannes
