From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] staging: brcm80211: SDIO/MMC cleanups
Date: Fri, 06 May 2011 18:00:06 +0200
Message-ID: <4DC41B06.5040500@drmicha.warpmail.net>
References: <20110504165947.40EED208186@grundler.mtv.corp.google.com> <4DC3B086.90802@broadcom.com> <7viptn3neo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Arend van Spriel <arend@broadcom.com>,
	"Grant@google.com" <Grant@google.com>,
	"\"Grundler <grundler\"@chromium.org <Grundler" 
	<grundler@chromium.org>, Greg Kroah-Hartman <greg@kroah.com>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	Dowan Kim <dowan@broadcom.com>,
	Henry Ptasinski <henryp@broadcom.com>,
	Venkat Rao <vrao@broadcom.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:00:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QINRz-0006TV-D1
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 18:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756567Ab1EFQAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 12:00:11 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:53114 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756198Ab1EFQAK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2011 12:00:10 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id DA5C1209FC;
	Fri,  6 May 2011 12:00:09 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 06 May 2011 12:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=AMBEZNz3kpaBzsWfWxa7t7fj710=; b=NCcjfGzYmswVbHn+DO5boDVaIg+akyUr+trMADrwd33m8I539t48xabqsKLFYB8c7TulpHxPNsNWLDK28HuwKgA02v+Z67UfkqosZX7yNNpL463iuRk9kPvU2CDn9d4TlA/4ylRK8lfZpCbGowHkvOEKmRjST+1eRgQGceDgNjo=
X-Sasl-enc: qn3tYsC+hG8BZixWDfS0hCTfX4/7p9gtK1bc3cAwPgF1 1304697609
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 54AF4405167;
	Fri,  6 May 2011 12:00:08 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
Newsgroups: gmane.linux.drivers.driver-project.devel
In-Reply-To: <7viptn3neo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172983>

Junio C Hamano venit, vidit, dixit 06.05.2011 16:37:
> "Arend van Spriel" <arend@broadcom.com> writes:
> 
>> The git documentation on the git am command is not very elaborate. I
>> investigated the issue and checked following:
>> 1. line 135 in dhd_sdio.c in the patch does match line 135 in my
>> checked out branch.
> 
> Does it exactly match, or does it merely visually match if you ignore tabs
> and spaces munged by somebody between the state of the file submitter
> committed and grunder.eml file you stored?

Junio, he reported the hashes to match! Puzzling. Or a MUA doing things
to the .eml.

Michael
