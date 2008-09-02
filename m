From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: pack count on repo.or.cz [was "Medium term dreams"]
Date: Tue, 02 Sep 2008 15:49:32 +0200
Message-ID: <48BD446C.6020403@viscovery.net>
References: <7vsksjsbcc.fsf@gitster.siamese.dyndns.org> <20080902000037.GA11869@coredump.intra.peff.net> <20080902010410.GI10360@machine.or.cz> <20080902011433.GA12682@coredump.intra.peff.net> <20080902111531.GL10360@machine.or.cz> <20080902115424.GA11303@coredump.intra.peff.net> <20080902130801.GN10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Sep 02 15:50:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaWHS-0003eO-1n
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 15:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753716AbYIBNtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 09:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753692AbYIBNtk
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 09:49:40 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:16308 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647AbYIBNtj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 09:49:39 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KaWGE-0002Q7-Go; Tue, 02 Sep 2008 15:49:35 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id AF23C6B7; Tue,  2 Sep 2008 15:49:31 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080902130801.GN10360@machine.or.cz>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94671>

Petr Baudis schrieb:
>> As to why the other packs weren't pruned, I don't know. In my example,
>> you can see that the pruning happens as we expect. So either there is a
>> bug in git-prune-packed, or there is something we're not realizing.
> 
> Well, that's my question here. :-)

Does removing all the *.keep files help? ;)

-- Hannes
