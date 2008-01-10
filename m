From: Sam Vilain <sam@vilain.net>
Subject: Re: Decompression speed: zip vs lzo
Date: Thu, 10 Jan 2008 18:02:19 +1300
Message-ID: <4785A6DB.3080007@vilain.net>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com> <7v4pdmfw27.fsf@gitster.siamese.dyndns.org> <47855765.9090001@vilain.net> <alpine.LSU.1.00.0801092328580.31053@racer.site> <47856E8D.4010006@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 10 06:03:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCpZF-0000Y2-9r
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 06:03:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbYAJFC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 00:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbYAJFC1
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 00:02:27 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:54201 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbYAJFC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 00:02:26 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id 934D821D186; Thu, 10 Jan 2008 18:02:24 +1300 (NZDT)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 36B8221D184;
	Thu, 10 Jan 2008 18:02:20 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <47856E8D.4010006@vilain.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70043>

Sam Vilain wrote:
> I do really like LZOP as far as compression algorithms go.  It seems a
> lot faster for not a huge loss in ratio.

Coincidentally, I read this today on an algorithm (LZMA - same as 7zip)
which is very slow to compress, high ratio but quick decompression:

  http://use.perl.org/~acme/journal/35330

Which sounds excellent for squeezing those "archive packs" into even
more ridiculously tiny spaces.

Samn.
