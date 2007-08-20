From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [StGit PATCH 1/6] Split git.merge into two functions
Date: Mon, 20 Aug 2007 10:55:28 +0200
Message-ID: <87odh2d1q7.fsf@morpheus.local>
References: <11875975232619-git-send-email-davidk@lysator.liu.se>
	<1187597523433-git-send-email-davidk@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 20 10:55:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN32r-0006lN-OJ
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 10:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbXHTIzb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 20 Aug 2007 04:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbXHTIzb
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 04:55:31 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:52471 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbXHTIza convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Aug 2007 04:55:30 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 6CB42200A215
	for <git@vger.kernel.org>; Mon, 20 Aug 2007 10:55:29 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 24397-01-27; Mon, 20 Aug 2007 10:55:28 +0200 (CEST)
Received: from morpheus (c83-253-22-183.bredband.comhem.se [83.253.22.183])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id C46EA200A1FC;
	Mon, 20 Aug 2007 10:55:28 +0200 (CEST)
Received: by morpheus (Postfix, from userid 1000)
	id 3909BBFC8A; Mon, 20 Aug 2007 10:55:28 +0200 (CEST)
In-Reply-To: <1187597523433-git-send-email-davidk@lysator.liu.se> (David
 =?utf-8?Q?K=C3=A5gedal's?= message of "Mon, 20 Aug 2007 10:11:58 +0200")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56200>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> From: David K=C3=83=C2=A5gedal <davidk@lysator.liu.se>

It seems that git-send-email didn't like me for some reason.  Double
UTF-8 encoding is not very pretty.

I also got a number of these when running it:

W: unable to extract a valid address from: David K=C3=83=C2=A5gedal <da=
vidk@lysator.liu.se>
W: unable to extract a valid address from: David K=C3=83=C2=A5gedal <da=
vidk@lysator.liu.se>

(the above was written in my latin1 xterm, so it wasn't double-encoded
there)

Is there a way to make send-email not add a "From:" header to the body
of the message?  The header already had the correct "From:" line.

--=20
David K=C3=A5gedal
