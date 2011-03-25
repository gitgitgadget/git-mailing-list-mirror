From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 4/4] diff: turn on rename detection progress reporting
Date: Fri, 25 Mar 2011 09:35:38 +0100
Message-ID: <4D8C53DA.1010300@viscovery.net>
References: <20110324174556.GA30661@sigill.intra.peff.net> <20110324175124.GD30685@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 25 09:35:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q32Us-0002hG-7q
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 09:35:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933818Ab1CYIfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 04:35:46 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:46347 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933717Ab1CYIfn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 04:35:43 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Q32Ud-0001iO-2P; Fri, 25 Mar 2011 09:35:40 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id CCE671660F;
	Fri, 25 Mar 2011 09:35:38 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <20110324175124.GD30685@sigill.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169967>

Am 3/24/2011 18:51, schrieb Jeff King:
> Since all of the progress happens before we generate any
> output, this looks OK, even when output goes to a pager.
> We do the usual --progress/--no-progress options and check
> isatty(2) to enable the feature.

Why does it look good? Because the pager is not spawned, yet? Then this is
not so good because on Windows we don't have a facility to wait until
there is output, and for this reason we spawn the pager immediately.

-- Hannes
