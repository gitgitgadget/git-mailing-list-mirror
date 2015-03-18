From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/5] t5312: test object deletion code paths in a corrupted
 repository
Date: Wed, 18 Mar 2015 21:42:33 +0100
Message-ID: <5509E339.2030900@kdbg.org>
References: <20150317072750.GA22155@peff.net> <20150317072844.GA25191@peff.net> <5508739A.5030608@kdbg.org> <20150317185550.GA14550@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 18 21:42:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYKna-0002xv-PH
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 21:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192AbbCRUmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 16:42:38 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:62792 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755197AbbCRUmh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 16:42:37 -0400
X-Greylist: delayed 94112 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Mar 2015 16:42:37 EDT
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3l6jwp1bgJz5tlC;
	Wed, 18 Mar 2015 21:42:34 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 5726D51FC;
	Wed, 18 Mar 2015 21:42:33 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <20150317185550.GA14550@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265754>

Am 17.03.2015 um 19:55 schrieb Jeff King:
> +	echo $bogus >.git/refs/heads/bogus..name &&
>...
> I assumed the final "." in your example wasn't significant (it is not to
> git), but let me know if I've run afoul of another weird restriction. :)

It was actually deliberate (with intents too complicated to explain), 
but it turns out not to be required. Your updated test case is good.

-- Hannes
