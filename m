From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: New Feature wanted: Is it possible to let git clone continue
 last break point?
Date: Fri, 04 Nov 2011 10:35:35 +0100
Message-ID: <4EB3B1E7.7080507@viscovery.net>
References: <CAEZo+gfKVY-YgMjd=bEYzRV4-460kqDik-yVcQ9Xs=DoCZOMDg@mail.gmail.com> <CAEZo+gcj5q2UYnak1+1UG7pPzoeaUr=QLsiCiNXbC_n+JQbKQQ@mail.gmail.com> <20111031090717.GA24978@elie.hsd1.il.comcast.net> <20111102220614.GB14108@sigill.intra.peff.net> <7vwrbigna7.fsf@alter.siamese.dyndns.org> <20111102232735.GA17466@sigill.intra.peff.net> <CAJo=hJtt8vjB5oU+tEabN2AS7c-24bMHNwQSoWtZYtjjrR3d7Q@mail.gmail.com> <20111103024248.GA9492@sigill.intra.peff.net> <CAJo=hJt2kU10r5rq23qgimtW8dmzu-N92vjO_hNBbVVsKSpDmg@mail.gmail.com> <20111104085633.GA13924@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	netroby <hufeng1987@gmail.com>,
	Git Mail List <git@vger.kernel.org>,
	Tomas Carnecky <tom@dbservice.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Nov 04 10:35:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMGBe-0006nN-MH
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 10:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682Ab1KDJfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 05:35:42 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:52428 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751371Ab1KDJfl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 05:35:41 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RMGBT-0007nu-Nz; Fri, 04 Nov 2011 10:35:35 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 68F431660F;
	Fri,  4 Nov 2011 10:35:35 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.23) Gecko/20110920 Thunderbird/3.1.15
In-Reply-To: <20111104085633.GA13924@ecki>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184765>

Am 11/4/2011 9:56, schrieb Clemens Buchacher:
> Cache ... not the pack but the information
>    to re-create it...

It has been discussed. It doesn't work. Because with threaded pack
generation, the resulting pack is not deterministic.

-- Hannes
