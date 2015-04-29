From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Bug report : bad filter-branch (OSX only)
Date: Wed, 29 Apr 2015 20:17:30 +0200
Message-ID: <5541203A.6040102@kdbg.org>
References: <CAM=W1NkZr6o-DCxXskeWC8xjRMiT2P9qXeeUe91qLBqOxzqNtg@mail.gmail.com>	<20150428055506.GJ24580@peff.net>	<CAM=W1NnR2-T7vpMSM-3-VypnR-T235tMudyjJowtj5utNmoKNQ@mail.gmail.com>	<20150429043947.GA10702@peff.net> <20150429045600.GA10781@peff.net>	<xmqqy4lbtrvj.fsf@gitster.dls.corp.google.com>	<20150429154857.GA13518@peff.net> <xmqqioce6gon.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Olivier ROLAND <cyrus-dev@edla.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 29 20:17:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnWYG-0004Bi-LX
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 20:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933289AbbD2SRf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 14:17:35 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:64914 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933266AbbD2SRd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 14:17:33 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3lcSk305CYz5tlD;
	Wed, 29 Apr 2015 20:17:30 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 300723146;
	Wed, 29 Apr 2015 20:17:30 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <xmqqioce6gon.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267989>

Am 29.04.2015 um 18:30 schrieb Junio C Hamano:
> As to s/()/{}/, please tell me what I am doing wrong.  I am getting
> the same process IDs from all of the $$s and the only difference
> seems to be variable clobbering.

The clobbered variable should be irrelevant for our use-case because it 
occurs only in the upstream of a pipeline, which is required to run in a 
sub-shell.

-- Hannes
