From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] gc: make --prune useful again by accepting an optional
 parameter
Date: Mon, 15 Dec 2008 15:17:30 -0600
Message-ID: <4SmUUF2C_ZbcUqUDScx1sSKXIHaQNjKdBXG6Q2GBMY4@cipher.nrlssc.navy.mil>
References: <alpine.DEB.1.00.0812152121260.30769@pacific.mpi-cbg.de> <j2kXTHA5qGwfTMznJutKnr1RHH7prDrQbr4BYlw-pt2V9gVgqTSERQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 15 22:19:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCKqF-0003fV-4P
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 22:19:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755814AbYLOVRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 16:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755849AbYLOVRp
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 16:17:45 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:46512 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755131AbYLOVRo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 16:17:44 -0500
Received: by mail.nrlssc.navy.mil id mBFLHVnZ005569; Mon, 15 Dec 2008 15:17:31 -0600
In-Reply-To: <j2kXTHA5qGwfTMznJutKnr1RHH7prDrQbr4BYlw-pt2V9gVgqTSERQ@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 15 Dec 2008 21:17:31.0343 (UTC) FILETIME=[8A643DF0:01C95EFA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103209>

Brandon Casey wrote:

> When --no-prune is used, not only will packed loose objects not be pruned,
> but the cleanup of temporary files that git-prune performs will not be done.

I forgot that the temporary file cleanup also honors --expire, so there will
still be no cleanup of temporary files if prune_expire = "never". I think the
rest of my remarks are still valid.

-brandon
