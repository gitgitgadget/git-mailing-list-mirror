From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 1/2] test-lib: add a function to compare an expection
 with stdout from a command
Date: Sun, 17 Apr 2016 17:19:21 +0200
Message-ID: <5713A979.6030404@kdbg.org>
References: <1460823230-45692-1-git-send-email-rappazzo@gmail.com>
 <1460823230-45692-2-git-send-email-rappazzo@gmail.com>
 <CAPig+cSOuFygsScGn_Nu0_d8mvRik1hQJuanrb-Nvw3ozyt7JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael Rappazzo <rappazzo@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= =?UTF-8?Q?_Duy?= 
	<pclouds@gmail.com>,
	=?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 17:19:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aroU2-0007IM-U5
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 17:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbcDQPT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 11:19:26 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:44990 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750778AbcDQPT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 11:19:26 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3qnw166BVnz5tlL;
	Sun, 17 Apr 2016 17:19:22 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 794975245;
	Sun, 17 Apr 2016 17:19:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <CAPig+cSOuFygsScGn_Nu0_d8mvRik1hQJuanrb-Nvw3ozyt7JQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291762>

Am 17.04.2016 um 05:07 schrieb Eric Sunshine:
> Hmm, considering that $(...) collapses each whitespace run (including
> newlines) down to a single space, I don't see how you could get a
> multi-line result.

No, it doesn't. It only removes trailing newlines:

~:1004> frotz=$(echo 1; echo; echo 2; echo; echo; echo); echo "$frotz"
1

2
~:1005>

-- Hannes
