From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH 10/11] Add a TreeWalk iterator implementation for IContainer
Date: Wed, 13 Aug 2008 22:41:45 +0200
Message-ID: <200808132241.45402.robin.rosenberg.lists@dewire.com>
References: <1218357986-19671-1-git-send-email-spearce@spearce.org> <1218357986-19671-10-git-send-email-spearce@spearce.org> <1218357986-19671-11-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 13 22:44:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTNCK-0004Bz-Jp
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 22:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575AbYHMUm5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Aug 2008 16:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753438AbYHMUmz
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 16:42:55 -0400
Received: from [83.140.172.130] ([83.140.172.130]:2169 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753316AbYHMUmx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Aug 2008 16:42:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 5778C8027F2;
	Wed, 13 Aug 2008 22:42:52 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rqFZWFR02u9p; Wed, 13 Aug 2008 22:42:51 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id B908080068B;
	Wed, 13 Aug 2008 22:42:51 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1218357986-19671-11-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92270>

s=F6ndagen den 10 augusti 2008 10.46.25 skrev Shawn O. Pearce:
> diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/Containe=
rTreeIterator.java b/org.spearce.egit.core/src/org/spearce/egit/core/Co=
ntainerTreeIterator.java
> new file mode 100644
> index 0000000..17b8414
> --- /dev/null
> +++ b/org.spearce.egit.core/src/org/spearce/egit/core/ContainerTreeIt=
erator.java
=2E..
> +	@Override
> +	protected Entry[] getEntries() throws IOException {
> +		final IResource[] all;
> +		try {
> +			all =3D node.members(IContainer.INCLUDE_HIDDEN);

INCLUDE_HIDDEN is a 3.4 flag.

-- robin
