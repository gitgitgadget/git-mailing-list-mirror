From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/3] sequencer: add "--reset-hard" option to "git sequencer--helper"
Date: Tue, 4 Aug 2009 23:17:26 +0200
Message-ID: <200908042317.26408.chriscool@tuxfamily.org>
References: <20090803024023.3794.44226.chriscool@tuxfamily.org> <alpine.LNX.2.00.0908041111550.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Aug 04 23:19:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYRNP-0005rV-34
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 23:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932856AbZHDVQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 17:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbZHDVQr
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 17:16:47 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:47780 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932547AbZHDVQq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 17:16:46 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 80C77818109;
	Tue,  4 Aug 2009 23:16:37 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 8C5818180B8;
	Tue,  4 Aug 2009 23:16:35 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.LNX.2.00.0908041111550.2147@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124816>

On Tuesday 04 August 2009, Daniel Barkalow wrote:
> On Mon, 3 Aug 2009, Christian Couder wrote:
> > This new option uses the "reset_almost_hard()" function to perform
> > a reset.
>
> Shouldn't it make it possible to do an almost-hard reset (that is, keep a
> dirty working tree's changes while changing the index and HEAD to a
> different commit)?

Yeah, I will improve the documentation of this function as Junio requested.

> AFAICT, this series doesn't expose the interesting new 
> functionality it provides.
>
> Also, I thought that we'd found that other built-ins could be simplified
> through the use of functions you're adding here. In particular, checkout
> wants to change the index and working tree while preserving dirty working
> tree changes. So it would probably be better for it to go in a library
> object, where sequencer--helper would just make it available to shell
> code.

Yeah, I agree, but right now I'd rather keep the code quite close to what it 
is on the sequencer repo if possible.

Thanks,
Christian.
