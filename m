From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: push.default: current vs upstream
Date: Sat, 07 Apr 2012 09:40:26 +0100
Message-ID: <4F7FFD7A.80104@pileofstuff.org>
References: <7vfwcqq2dw.fsf@alter.siamese.dyndns.org> <20120330071358.GB30656@sigill.intra.peff.net> <7vty15ltuo.fsf@alter.siamese.dyndns.org> <vpqty12h995.fsf@bauges.imag.fr> <20120405131301.GB10293@sigill.intra.peff.net> <vpqwr5uceis.fsf@bauges.imag.fr> <20120406071520.GD25301@sigill.intra.peff.net> <vpqr4w12tjj.fsf@bauges.imag.fr> <20120406080004.GA27940@sigill.intra.peff.net> <4F7FF19B.1060407@alum.mit.edu> <20120407075150.GA18168@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 07 10:41:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGRCk-0002kS-Gy
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 10:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314Ab2DGIkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Apr 2012 04:40:31 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:7511 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752202Ab2DGIka (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Apr 2012 04:40:30 -0400
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120407084028.JEHC3740.mtaout01-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Sat, 7 Apr 2012 09:40:28 +0100
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout02-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120407084028.UUAW3795.aamtaout02-winn.ispmail.ntl.com@[192.168.0.2]>;
          Sat, 7 Apr 2012 09:40:28 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <20120407075150.GA18168@sigill.intra.peff.net>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=yXtjXN6ItgYA:10 a=-PimNzO8mcAA:10 a=u4BGzq-dJbcA:10 a=IkcTkHD0fZMA:10 a=W17qGE3NDudZymJtXqQA:9 a=QEXdDO2ut3YA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194943>

On a slight aside, should we add @{downstream} to describe the opposite
of @{upstream}?  Seeing that around the place would give intermediate
users a clue about why pull and push aren't as related as they think,
and would be useful here and there in code (e.g. __git_ps1 could show a
better bash prompt with GIT_PS1_SHOWUPSTREAM).

	- Andrew
