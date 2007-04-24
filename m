From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] import-tars: use Archive::Tar instead of unpack()
Date: Tue, 24 Apr 2007 22:55:54 +1200
Message-ID: <462DE23A.8000501@vilain.net>
References: <1171289831.629.6.camel@ibook.zvpunry.de> <127B27FE-1F9A-4328-A87A-77B907FFEBA7@zvpunry.de> <20070424101323.GC23811@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Loeffler <zvpunry@zvpunry.de>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 12:56:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgIgt-0001et-1h
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 12:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932764AbXDXK4H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 Apr 2007 06:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161540AbXDXK4H
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 06:56:07 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:51327 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932764AbXDXK4G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 06:56:06 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id E507B1574B6; Tue, 24 Apr 2007 22:56:02 +1200 (NZST)
Received: from [192.168.1.5] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 542031574B2;
	Tue, 24 Apr 2007 22:55:58 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
In-Reply-To: <20070424101323.GC23811@diana.vm.bytemark.co.uk>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45441>

Karl Hasselstr=F6m wrote:
> Sorry, the same objection as Shawn raised in the original thread
> applies here too: I don't have Archive::Tar installed! :-(
>
> I might try it later, but I don't really have the time to chase after
> that dependency right now. Sorry.
>  =20

How about allowing dependencies, so long as they are included as submod=
ules?

Sam.
