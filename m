From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] run-command: Redirect stderr to a pipe before
 redirecting stdout to stderr
Date: Thu, 6 Mar 2008 06:44:15 +0100
Message-ID: <20080306064415.c5ca762a.chriscool@tuxfamily.org>
References: <20080305083516.e1a2a139.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 06 06:39:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX8pD-0000R6-VP
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 06:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755031AbYCFFic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 00:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753213AbYCFFic
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 00:38:32 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:46993 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751883AbYCFFib (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 00:38:31 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 31D581AB2C5;
	Thu,  6 Mar 2008 06:38:30 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 63A361AB2B6;
	Thu,  6 Mar 2008 06:38:29 +0100 (CET)
In-Reply-To: <20080305083516.e1a2a139.chriscool@tuxfamily.org>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76336>

Hi Junio and Shawn,

On Wed, 5 Mar 2008, I wrote:
> With this patch, in the 'start_command' function after forking
> we now take care of stderr in the child process before stdout.
> ...

I am afraid I forgot the 

From: "Shawn O. Pearce" <spearce@spearce.org>

at the top of the patch in my last resend, so the patch was attributed to me instead of Shawn.

Is it possible to do something about it ? (I fear not since it is now in 'next' but maybe I am wrong.)

Thanks in advance,
Christian.
