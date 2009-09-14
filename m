From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] remove NORETURN from function pointers
Date: Mon, 14 Sep 2009 15:37:40 +0200
Message-ID: <4AAE4724.1090705@viscovery.net>
References: <1252923370-5768-1-git-send-email-kusmabite@gmail.com>	 <1252923370-5768-2-git-send-email-kusmabite@gmail.com>	 <20090914105750.GB9216@sigill.intra.peff.net>	 <40aa078e0909140440x2e189957uf66f36ff29bef302@mail.gmail.com>	 <20090914120311.GA17172@sigill.intra.peff.net>	 <40aa078e0909140532q693a7f9qc3d9b1d354cac356@mail.gmail.com>	 <4AAE4087.5030607@viscovery.net>	 <40aa078e0909140612w71ad3bdeyfa94838cb57cec19@mail.gmail.com>	 <4AAE42F2.30304@viscovery.net> <40aa078e0909140626k63b9de2fu8c9411baf8200da6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 15:37:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnBka-0004NI-6H
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 15:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbZINNhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 09:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbZINNhj
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 09:37:39 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:36642 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbZINNhi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 09:37:38 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MnBkT-0006RZ-B4; Mon, 14 Sep 2009 15:37:41 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1F8F59F88; Mon, 14 Sep 2009 15:37:41 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <40aa078e0909140626k63b9de2fu8c9411baf8200da6@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128479>

Erik Faye-Lund schrieb:
> On Mon, Sep 14, 2009 at 3:19 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> "The" warning? Not "the two" warnings? Then I suggest to stop here; MSVC
>> is only half-competent with regards to noreturn.
> 
> There was only one warning in this regard on MSVC - the one about
> unreachable code. And yes, MSVC is only half-competent, but it seems
> it's competence is in the half that matters in our case.
> 
> Do you suggest to stop the patch-series, or to stop the testing?

My suggestion was about stopping the patch series.

But thinking a bit more about it, I can imagine that there are calls to
die() that, if it is not marked noreturn, could trigger other warnings
with MSVC. That would be annoying, and it's better to mark it noreturn.

So I withdraw my suggestion to stop :-)

-- Hannes
