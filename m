From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 2/2] Correct Javadoc comment for TransportLocal about forking
Date: Sun, 3 May 2009 09:52:45 +0200
Message-ID: <200905030952.46075.robin.rosenberg.lists@dewire.com>
References: <1241296230-19342-1-git-send-email-spearce@spearce.org> <1241296230-19342-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun May 03 09:53:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0WVa-00060p-50
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 09:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754646AbZECHwv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 May 2009 03:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754632AbZECHwv
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 03:52:51 -0400
Received: from mail.dewire.com ([83.140.172.130]:3684 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752656AbZECHwu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 May 2009 03:52:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C623C10233DD;
	Sun,  3 May 2009 09:52:47 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oGRvB1VnJ0G7; Sun,  3 May 2009 09:52:47 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id 03AD1800277;
	Sun,  3 May 2009 09:52:46 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1241296230-19342-2-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118166>

l=F6rdag 02 maj 2009 22:30:30 skrev "Shawn O. Pearce" <spearce@spearce.=
org>:
> + * However, during {@link #openFetch()}, if the Transport has config=
ured
> + * {@link Transport#getOptionUploadPack()} to be anything other than
> + * <code>"git-upload-pack"</code> or <code>"git upload-pack"</code>,=
 this
> + * implementation will fork and execute the external process, using =
an operating
> + * system pipe to transfer data.
> + * <p>
> + * However, during {@link #openPush()}, if the Transport has configu=
red
> + * {@link Transport#getOptionReceivePack()} to be anything other tha=
n
> + * <code>"git-receive-pack"</code> or <code>"git receive-pack"</code=
>, this
> + * implementation will fork and execute the external process, using =
an operating
> + * system pipe to transfer data.
>=20

I'll change the second However to Similarly. I think it reads better, e=
ven though I'm not a native English speaker.

-- robin
