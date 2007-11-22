From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 3/3] Replace setenv(GIT_DIR_ENVIRONMENT, ...) with set_git_dir()
Date: Thu, 22 Nov 2007 08:29:29 +0100
Message-ID: <47452FD9.9000501@viscovery.net>
References: <11956768414090-git-send-email-prohaska@zib.de>	<11956768412804-git-send-email-prohaska@zib.de>	<11956768413887-git-send-email-prohaska@zib.de>	<11956768412755-git-send-email-prohaska@zib.de>	<Pine.LNX.4.64.0711220121560.27959@racer.site> <7v63zv9fel.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 08:29:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv6VT-0007ZZ-Mm
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 08:29:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbXKVH3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 02:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbXKVH3e
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 02:29:34 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:31828 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbXKVH3d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 02:29:33 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Iv6UV-0000yo-HY; Thu, 22 Nov 2007 08:28:51 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 640544E4; Thu, 22 Nov 2007 08:29:29 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7v63zv9fel.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65744>

Junio C Hamano schrieb:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> Hi,
>>
>> On Wed, 21 Nov 2007, Steffen Prohaska wrote:
>>
>>> We have a function set_git_dir().  So let's use it, instead of setting 
>>> the evironment directly.
>> Does this not have a fundamental issue?  When you call other git programs 
>> with run_command(), you _need_ GIT_DIR to be set, no?
> 
> It is much worse.  set_git_dir() does not just setenv() but does
> setup_git_env() as well.

I don't see what's wrong with that. Could you please explain?

-- Hannes
