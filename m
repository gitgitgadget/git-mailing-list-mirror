From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix safe_create_leading_directories() for Windows
Date: Tue, 7 Jan 2014 18:56:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1401071854330.20365@s15462909.onlinehome-server.info>
References: <52C5A039.6030408@gmail.com> <alpine.DEB.1.00.1401021826120.1191@s15462909.onlinehome-server.info> <52C5ABDE.1010006@gmail.com> <alpine.DEB.1.00.1401022143310.1191@s15462909.onlinehome-server.info>
 <CABPQNSaBbcgpE98j7mChvu6N7QqCG0CEmUgvJRURXLTdUTyFGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 18:56:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0at4-0005uO-GX
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 18:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbaAGR4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 12:56:19 -0500
Received: from mout.gmx.net ([212.227.17.22]:62725 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753152AbaAGR4R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 12:56:17 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0LyVIk-1VMatq1HqY-015tEQ
 for <git@vger.kernel.org>; Tue, 07 Jan 2014 18:56:16 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CABPQNSaBbcgpE98j7mChvu6N7QqCG0CEmUgvJRURXLTdUTyFGg@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:qOymuw4ZiiqlzbkPQtpI2Ee0lnu16TqcmUzkZGuYuf2gI6DUafB
 rVT9mkMI/Hi4WXTqnzf3/S7GpQrfovZ27RmDH3CmvVR/0sl+pPaEdyfbQ7gpe6VaadB9QCI
 diMdkw6C56LlZGrPR2sJwLL4zEzI7tecfqXg/u30P+/r3GasmC1RXru1kGBX+7w+Wt2bMr9
 3m/12yvzhakMJodU0ndFA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240121>

Hi,

On Tue, 7 Jan 2014, Erik Faye-Lund wrote:

> On Thu, Jan 2, 2014 at 9:46 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > Well, you and I both know how easy GitHub's pull request made things
> > for us as well as for contributors. I really cannot thank Erik enough
> > for bullying me into using and accepting them.
> 
> Huh? I don't think you refer to me, because I really dislike them (and I
> always have IIRC).

Ah yes, I misremembered. You were actually opposed to using them and I
thought we should be pragmatic to encourage contributions.

In any case, I do think that the contributions we got via pull requests
were in general contributions we would not otherwise have gotten.

Sorry for my mistake!
Dscho
