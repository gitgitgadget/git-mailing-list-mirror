From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH] Prevent an exception if the user tries to push a non-existing ref.
Date: Mon, 9 Mar 2009 22:29:00 +0100
Message-ID: <200903092229.01289.robin.rosenberg.lists@dewire.com>
References: <20090307224831.GS16213@spearce.org> <1236525667-852-1-git-send-email-robin.rosenberg@dewire.com> <20090309155049.GE11989@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Cheng <j16sdiz+freenet@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 09 22:31:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgn3a-0004tA-HQ
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 22:30:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416AbZCIV3M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2009 17:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbZCIV3M
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 17:29:12 -0400
Received: from mail.dewire.com ([83.140.172.130]:9142 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751414AbZCIV3L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Mar 2009 17:29:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 674C715E0E00;
	Mon,  9 Mar 2009 22:29:04 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GiMG3vsn18M0; Mon,  9 Mar 2009 22:29:03 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id A68008006B8;
	Mon,  9 Mar 2009 22:29:03 +0100 (CET)
User-Agent: KMail/1.11.1 (Linux/2.6.27-12-generic; KDE/4.2.1; i686; ; )
In-Reply-To: <20090309155049.GE11989@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112746>

m=E5ndag 09 mars 2009 16:50:49 skrev "Shawn O. Pearce" <spearce@spearce=
=2Eorg>:
> After reading that code again, I'm tempted to apply this instead.
> Its a much larger patch, but I think the result is a lot easier
> to follow.

I wouldn't say "a lot", but a little perhaps.

-- robin
