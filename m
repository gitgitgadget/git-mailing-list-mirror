From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 00/94] libify apply and use lib in am
Date: Thu, 12 May 2016 19:06:13 +0200
Message-ID: <5734B805.8020504@kdbg.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 19:06:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0u46-0007gP-Kl
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 19:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbcELRGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 13:06:18 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:2637 "EHLO bsmtp2.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752465AbcELRGS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 13:06:18 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 3r5KBt4bKCz5tlQ;
	Thu, 12 May 2016 19:06:14 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id E0E695264;
	Thu, 12 May 2016 19:06:13 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294420>

Am 11.05.2016 um 15:16 schrieb Christian Couder:
> This is a patch series about libifying `git apply` functionality, and
> using this libified functionality in `git am`, so that no 'git apply'
> process is spawn anymore. This makes `git am` significantly faster, so
> `git rebase`, when it uses the am backend, is also significantly
> faster.

I'm including this in my build on Windows. It passes the test suite.

I'll also use it in production for a while, although I am not a git-am 
consumer nor do I use git-rebase without -i, hence, my tests will 
probably only show that there is no bad fall-out.

-- Hannes
