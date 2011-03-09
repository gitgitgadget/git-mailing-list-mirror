From: Robert Wruck <wruck@tweerlei.de>
Subject: Re: [BUG] git cat-file does not terminate
Date: Wed, 09 Mar 2011 20:51:46 +0100
Message-ID: <4D77DA52.7050701@tweerlei.de>
References: <4D70E340.3050309@tweerlei.de> <20110304154014.GE24660@m62s10.vlinux.de> <20110304160047.GA9662@sigill.intra.peff.net> <7vzkpa7qmp.fsf@alter.siamese.dyndns.org> <20110308211423.GB4594@sigill.intra.peff.net> <7vwrk9cjib.fsf@alter.siamese.dyndns.org> <4D779385.3070602@tweerlei.de> <7vzkp49jk3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Peter Baumann <waste.manager@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 20:51:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxPQI-0007Yv-KY
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 20:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946Ab1CITvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 14:51:49 -0500
Received: from mail.tweerlei.de ([88.198.48.46]:37610 "EHLO mail.tweerlei.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751740Ab1CITvs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 14:51:48 -0500
Received: from [10.0.1.3] (e177232106.adsl.alicedsl.de [85.177.232.106])
	by mail.tweerlei.de (Postfix) with ESMTPSA id 5A6FB277EA;
	Wed,  9 Mar 2011 20:51:47 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.1.16) Gecko/20101125 Lightning/1.0b1 Thunderbird/3.0.11
In-Reply-To: <7vzkp49jk3.fsf@alter.siamese.dyndns.org>
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED autolearn=ham
	version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on hydra.tweerlei.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168749>

> Thanks; it is not very critical so don't spend too much effort trying to
> find a way to do so at runtime.  We can always use the approach Jeff's
> Makefile patch took to make it safe (and potentially slow) by default on
> all Cygwin while still allowing people on an unaffected version to turn
> the workaround off while building.

The write() issue will presumably be fixed in the next cygwin release. I 
already have a version that works on WinXP where it used to fail.

-Robert
