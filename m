From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] t0060: loosen overly strict expectations
Date: Thu, 14 Jan 2016 23:14:26 +0100
Message-ID: <56981DC2.6070706@kdbg.org>
References: <eccf149d9557fd9afb591d9411ecb0b3460c9eb0.1452754049.git.johannes.schindelin@gmx.de>
 <xmqqziw8jcbr.fsf@gitster.mtv.corp.google.com>
 <5697E550.9020102@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Michael Blume <blume.mike@gmail.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 23:15:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJqAc-0000aU-Pd
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 23:15:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907AbcANWOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 17:14:30 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:54215 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752392AbcANWO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 17:14:29 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3phKgR34Cvz5tlB;
	Thu, 14 Jan 2016 23:14:27 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 87EAB51D6;
	Thu, 14 Jan 2016 23:14:26 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <5697E550.9020102@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284099>

Am 14.01.2016 um 19:13 schrieb Ramsay Jones:
> Correct me if I'm wrong (quite possible), but
> _each_ drive has a current working directory associated with
> it in win32, so it's a bit difficult to use drive designators
> with a relative path (eg. C:usr/lib).

As far as it matters for Git, such a path is still an absolute path, 
because it is not anchored at $(pwd).

-- Hannes
