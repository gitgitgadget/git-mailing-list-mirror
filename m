From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 0/4] Don't warn about missing EOL for symlinks
Date: Fri, 04 Jun 2010 16:15:32 +0200
Message-ID: <4C090A84.20209@kdbg.org>
References: <cover.1275575236.git.git@drmicha.warpmail.net> <vpq1vco41go.fsf@bauges.imag.fr> <4C07C2E8.508@drmicha.warpmail.net> <20100603170724.GB22779@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 04 16:16:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKXgm-0001Hl-8X
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 16:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756301Ab0FDOPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 10:15:44 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:50174 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756247Ab0FDOPn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 10:15:43 -0400
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 218A52C4006;
	Fri,  4 Jun 2010 16:15:36 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <20100603170724.GB22779@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148418>

Am 03.06.2010 19:07, schrieb Jeff King:
> I don't think "but they should be using plumbing to generate patches"
> is the right answer, either. Yes, we expect the diff porcelain to behave
> differently depending on configuration, but with the exception of
> textconv, it always produces an actual applicable patch.

I don't by into that argument: You have to give --binary if you have 
changes in binary files. With Michael's patch, you have to give 
--no-textonv (too). I'm in favor of the patch.

-- Hannes
