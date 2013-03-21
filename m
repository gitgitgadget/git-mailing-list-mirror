From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] do not use GIT_TRACE_PACKET=3 in tests
Date: Thu, 21 Mar 2013 07:36:13 +0100
Message-ID: <514AAA5D.4000803@viscovery.net>
References: <20130320172640.GC10752@sigill.intra.peff.net> <20130320174347.GA28548@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 21 07:36:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIZ7K-0007Xo-KF
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 07:36:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756449Ab3CUGgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 02:36:22 -0400
Received: from so.liwest.at ([212.33.55.24]:19072 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757389Ab3CUGgV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 02:36:21 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UIZ6k-0007pe-EN; Thu, 21 Mar 2013 07:36:15 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 09FD01660F;
	Thu, 21 Mar 2013 07:36:13 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <20130320174347.GA28548@sigill.intra.peff.net>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218696>

Am 3/20/2013 18:43, schrieb Jeff King:
> Now that we are using the GIT_TRACE mechanism, we can
> improve both scripts by asking git to write directly to a
> file rather than a descriptor. That fixes the hang in t5700,
> and should allow t5503 to successfully run on Windows.

Well spotted, and, right, both tests pass with this patch.

Tested-by: Johannes Sixt <j6t@kdbg.org>

Thanks,
-- Hannes
