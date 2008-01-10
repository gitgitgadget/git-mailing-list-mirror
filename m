From: Sam Vilain <sam@vilain.net>
Subject: Re: Decompression speed: zip vs lzo
Date: Fri, 11 Jan 2008 11:01:52 +1300
Message-ID: <478695D0.5040404@vilain.net>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com>	 <7v4pdmfw27.fsf@gitster.siamese.dyndns.org>	 <47855765.9090001@vilain.net>	 <alpine.LSU.1.00.0801092328580.31053@racer.site>	 <47856E8D.4010006@vilain.net> <4785A6DB.3080007@vilain.net>	 <20080110091607.GA17944@artemis.madism.org>	 <alpine.LFD.1.00.0801101332150.3054@xanadu.home> <e5bfff550801101351w257975b1q9391d556c7af22a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 23:02:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD5Tp-0003SW-H7
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 23:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276AbYAJWCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 17:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753212AbYAJWCA
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 17:02:00 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:37780 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752154AbYAJWCA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 17:02:00 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id D59BE21D188; Fri, 11 Jan 2008 11:01:56 +1300 (NZDT)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 4549D21D183;
	Fri, 11 Jan 2008 11:01:52 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <e5bfff550801101351w257975b1q9391d556c7af22a0@mail.gmail.com>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70101>

Marco Costalba wrote:
> BTW would be possible to test git with zlib disabled also now? I mean
> there is a quick hack to disable zlib not only in writing but also in
> reading, so that we can see what happens when running a repository
> packed without compression?

See Nicholas Pitre's hack on another branch of this thread - it won't
cut out zlib entirely, but at least it's just configuring it to do plain
pass-through.  You can probably just replace pack_compression_level with 0.

Sam
