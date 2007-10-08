From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make strbuf_cmp inline, constify its arguments and  optimize it a bit
Date: Mon, 8 Oct 2007 20:51:11 +0200
Message-ID: <20071008185111.GC3123@steel.home>
References: <20071007172425.bb691da9.tihirvon@gmail.com> <20071007143912.GB10024@artemis.corp> <87sl4nlyg0.fsf@catnip.gol.com> <857ilylxhm.fsf@lola.goethe.zz> <20071007215432.GC2765@steel.home> <EF81F7DD-73C7-4B6F-92D2-4A143CA05365@wincent.com> <20071007223140.GG2765@steel.home> <87odfapefc.fsf@catnip.gol.com> <20071008072312.GA22552@artemis.corp> <82k5py6l6f.fsf@mid.bfk.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, Miles Bader <miles@gnu.org>,
	Wincent Colaiuta <win@wincent.com>,
	David Kastrup <dak@gnu.org>,
	Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Florian Weimer <fweimer@bfk.de>
X-From: git-owner@vger.kernel.org Mon Oct 08 20:51:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IexhQ-000513-Id
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 20:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754727AbXJHSvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 14:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754742AbXJHSvT
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 14:51:19 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:63618 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636AbXJHSvS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 14:51:18 -0400
Received: from tigra.home (Fc872.f.strato-dslnet.de [195.4.200.114])
	by post.webmailer.de (mrclete mo4) (RZmta 13.4)
	with ESMTP id h00c0aj98IeC5L ; Mon, 8 Oct 2007 20:51:14 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id CFDDF277AE;
	Mon,  8 Oct 2007 20:51:11 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id B0D45C502; Mon,  8 Oct 2007 20:51:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <82k5py6l6f.fsf@mid.bfk.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+ecrQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60332>

Florian Weimer, Mon, Oct 08, 2007 10:54:32 +0200:
> And "int len" in the first line of the function body should be
> "size_t len".

right. Missed that.
