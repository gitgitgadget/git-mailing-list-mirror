From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC PATCH v2 2/2] MSVC: Fix an "incompatible pointer types" compiler warning
Date: Sat, 5 Dec 2009 12:57:19 +0100
Message-ID: <200912051257.21386.j6t@kdbg.org>
References: <4B1997A0.9000004@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Marius Storm-Olsen" <mstormo@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"GIT Mailing-list" <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Dec 05 12:57:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGtGs-0005fm-Nf
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 12:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168AbZLEL5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 06:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754160AbZLEL5f
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 06:57:35 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:38761 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754090AbZLEL5e (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 06:57:34 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 510C6A817C;
	Sat,  5 Dec 2009 12:57:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 8EAC919F5CA;
	Sat,  5 Dec 2009 12:57:21 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <4B1997A0.9000004@ramsay1.demon.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134596>

[Removed Junio from Cc because IIUC, he prefers to be left out of the loop in 
Windows related matters until they have settled.]

On Samstag, 5. Dezember 2009, Ramsay Jones wrote:
> The patch is still marked RFC because:
>     - I'm still not sure if the flexibility to support both 32- and 64-bit
>       time_t is required.
>     - should -D_USE_32BIT_TIME_T be added to the Makefile?

If *not* using -D_USE_32BIT_TIME_T  produces a build or code base that is in 
some way superior, why should we require it? For example, its absence could 
help a 64bit build.

-- Hannes
