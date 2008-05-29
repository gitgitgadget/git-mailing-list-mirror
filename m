From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [RFC/PATCH] git-what: explain what to do next
Date: Thu, 29 May 2008 09:56:05 -0500
Message-ID: <483EC405.6090400@freescale.com>
References: <1211877299-27255-1-git-send-email-sbejar@gmail.com> <200805290639.38134.chriscool@tuxfamily.org> <7vlk1tpug5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	=?ISO-8859-1?Q?Santi_B=E9?= =?ISO-8859-1?Q?jar?= 
	<sbejar@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 29 17:06:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1jZy-0004J7-AW
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 16:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882AbYE2O5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 10:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752583AbYE2O5Q
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 10:57:16 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:33962 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341AbYE2O5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 10:57:16 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id m4TEujLT022844;
	Thu, 29 May 2008 07:56:45 -0700 (MST)
Received: from [10.214.73.8] (mvp-10-214-73-8.am.freescale.net [10.214.73.8])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m4TEuih7029390;
	Thu, 29 May 2008 09:56:44 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vlk1tpug5.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83207>

Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> 
>> It seems not very friendly to just "return 1" when not bisecting.
>> And before my last patch to use BISECT_START to check if we are bisecting, 
>> it would perhaps have been better to use 'test -f "$GIT_DIR/BISECT_NAMES"'.
> 
> The reason for this silence is because Santi wants to call potential
> culprits in turn and stop when one responds "Yeah, I am the guilty one who
> threw a monkey wrench into the user's workflow".  For that to work, "No,
> the user is not in the middle of any interaction with me" response needs
> to be silent.

Hrm.  Do both?  Have the normal interactive user command
be more verbose, but let the pseudo-scripted version supply
an additional --status-only flag as it sequences through
the status checks?

jdl
