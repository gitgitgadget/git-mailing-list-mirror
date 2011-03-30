From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Portability: returning void
Date: Wed, 30 Mar 2011 08:54:32 +0200
Message-ID: <4D92D3A8.3090301@viscovery.net>
References: <71372d7d-dd08-4945-a8bc-c7b981c09fb2-mfwitten@gmail.com> <20110329200230.GA377@elie> <20110329221652.GB23510@sigill.intra.peff.net> <20110329234955.GB14578@elie> <20110330001653.GA1161@sigill.intra.peff.net> <20110330002921.GC14578@elie> <20110330033017.GA18157@sigill.intra.peff.net> <20110330035733.GA2793@elie> <20110330041339.GA26281@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Barr <david.barr@cordelta.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 08:54:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4pIu-0007bn-4G
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 08:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533Ab1C3Gyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 02:54:40 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:19274 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751134Ab1C3Gyj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 02:54:39 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Q4pIW-0005pO-Gn; Wed, 30 Mar 2011 08:54:32 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 3EA591660F;
	Wed, 30 Mar 2011 08:54:32 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <20110330041339.GA26281@sigill.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170359>

Am 3/30/2011 6:13, schrieb Jeff King:
> On Tue, Mar 29, 2011 at 10:57:33PM -0500, Jonathan Nieder wrote:
>> I was in the process of writing a commit message for the same "exec"
>> trick, but I'm glad you got to it first. ;-)
> 
> I don't know why I didn't think of it sooner. :)

Note that tests that depend on ( exec ... ) & kill $! must be marked with
the EXECKEEPSPID prerequisite.

-- Hannes
