From: Olaf Hering <olaf@aepfle.de>
Subject: Re: let git grep consider sub projects
Date: Wed, 8 Oct 2014 09:31:40 +0200
Message-ID: <20141008073140.GA28807@aepfle.de>
References: <20141007082914.GA2729@aepfle.de>
 <xmqq8ukrg2j2.fsf@gitster.dls.corp.google.com>
 <CAHYJk3Qrj3QfBK-MkcCS2AmyTz=AgCcruq7Df-YZKW24LMWTHg@mail.gmail.com>
 <5434DE29.2010200@web.de>
 <20141008065947.GA22318@aepfle.de>
 <5434E6B5.3030605@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mikael Magnusson <mikachu@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 08 09:31:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xbliu-00081K-Bm
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 09:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754434AbaJHHbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 03:31:44 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:8766 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036AbaJHHbn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 03:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1412753501; l=644;
	s=domk; d=aepfle.de;
	h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Subject:Cc:To:From:Date;
	bh=tZ6uypSmdmngUAdv5kwvulgSgN4=;
	b=rhIuJ5gTeyEgvhlhEfUPVmHjtX8eMtJ56WR48G3oWZrocBjMkZqAdZLZbv/G/sSZ0QU
	OjKYJIPilbxMN0qwRQjNrgLQKhr5GVEJZQ7TlSyxoT0fSHk515v26Ld5MImqh2imzEnbR
	wD1Te8GPagjfrBg4sKRCq7vZmxjl3+WMgbQ=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWi/zfN1cLnBYfstVolSR8Cl8fNabDQrlSrQo8jPq2gOVbkBPuE3yQ==
X-RZG-CLASS-ID: mo00
Received: from probook.fritz.box ([2001:a60:11b7:1201:1ec1:deff:feb9:bb48])
	by smtp.strato.de (RZmta 35.10 AUTH)
	with ESMTPSA id 3074a1q987VfBg4
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate);
	Wed, 8 Oct 2014 09:31:41 +0200 (CEST)
Received: by probook.fritz.box (Postfix, from userid 1000)
	id 255C55016D; Wed,  8 Oct 2014 09:31:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5434E6B5.3030605@web.de>
User-Agent: Mutt/1.5.22.rev6346 (2013-10-29)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 08, Jens Lehmann wrote:

> Okay, I just checked that xen doesn't use submodules but uses simple
> embedded repos ignored by the .gitignore file. From a quick glance
> it looks like handling the sub projects is scripted in the Makefiles.
> This is perfectly fine, but then you can't really expect git commands
> to know about these sub projects. Or am I missing something?

I just did not know about the submodule command. And I did not realize
that they are in .gitignore, which should have been obvious.

I will check if using submodule instead of plain clone can be done,
without breaking anyones workflow.


Olaf
