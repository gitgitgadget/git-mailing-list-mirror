From: Robert Wruck <wruck@tweerlei.de>
Subject: Re: [BUG] git cat-file does not terminate
Date: Fri, 04 Mar 2011 18:29:45 +0100
Message-ID: <4D712189.7090105@tweerlei.de>
References: <4D70E340.3050309@tweerlei.de> <20110304154014.GE24660@m62s10.vlinux.de> <20110304160047.GA9662@sigill.intra.peff.net> <7vzkpa7qmp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Peter Baumann <waste.manager@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 18:29:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvYp7-00082Y-62
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 18:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759951Ab1CDR3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 12:29:48 -0500
Received: from mail.tweerlei.de ([88.198.48.46]:56936 "EHLO mail.tweerlei.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759665Ab1CDR3r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2011 12:29:47 -0500
Received: from [10.0.1.3] (e177251182.adsl.alicedsl.de [85.177.251.182])
	by mail.tweerlei.de (Postfix) with ESMTPSA id 58869277B5;
	Fri,  4 Mar 2011 18:29:46 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <7vzkpa7qmp.fsf@alter.siamese.dyndns.org>
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED autolearn=ham
	version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on hydra.tweerlei.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168451>

> By the way, does the same version of Cygwin have similar issue on the read
> side?

Actually I've written a small test program on the problematic cygwin 
machine that seems to show that the EAGAIN is somehow related to pipes 
(e.g. stdout & stuff) and does not occur when fd refers to a file.
I will test this for read() as well but I don't know enough cygwin 
internals to tell what other versions may be affected.
It might even be related to 32/64 bit or different Windows versions 
since I didn't test more constellations.

-Robert
