From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCHv3 3/6] line-log.c: fix a memleak
Date: Tue, 31 Mar 2015 06:42:25 +0200
Message-ID: <551A25B1.80309@web.de>
References: <1427764931-27745-1-git-send-email-sbeller@google.com> <1427764931-27745-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: sunshine@sunshineco.com, tr@thomasrast.ch
To: Stefan Beller <sbeller@google.com>, gitster@pobox.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 06:43:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yco14-00059x-M3
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 06:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbbCaEm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 00:42:56 -0400
Received: from mout.web.de ([212.227.17.11]:59924 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751006AbbCaEmz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 00:42:55 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MWS3S-1Yw7IA3pJi-00XapM; Tue, 31 Mar 2015 06:42:49
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <1427764931-27745-4-git-send-email-sbeller@google.com>
X-Provags-ID: V03:K0:qhQ+zuMVUSSNpay49kNG3t4gS/858nOtqDA2/0J3tfMiBCQAAT6
 jSVv8sF71iXDIzzyfPHQ5S2c8NgK43v5OuppDfCzmNgh/FCJ54nfa5vjr0f+kejY4KQP1JE
 y2qdmkI4OqQycSOdyNM7VFtVEgLRfQ7adJm3qWVBViN2cZi5OEy4lMmD5yyyAiuk7eQ1NjZ
 u/kv0xDhGeMd4aBWQE3EA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266511>

On 03/31/2015 03:22 AM, Stefan Beller wrote:
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>   line-log.c | 3 +++
>   1 file changed, 3 insertions(+)
>
Would it make sense to join 2/6 and 3/6 into a single patch ?

Both fix the memleaks in the same file, and the
header can be "fix memleaks".
