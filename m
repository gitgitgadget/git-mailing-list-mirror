From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 4/5] Define Patch to parse a sequence of patch FileHeaders
Date: Thu, 11 Dec 2008 19:34:12 +0100
Message-ID: <200812111934.13218.robin.rosenberg.lists@dewire.com>
References: <1228971522-28764-1-git-send-email-spearce@spearce.org> <1228971522-28764-4-git-send-email-spearce@spearce.org> <1228971522-28764-5-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Dec 11 19:36:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAqNr-0007lu-4g
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 19:35:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755988AbYLKSeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 13:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755911AbYLKSeR
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 13:34:17 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:34017 "EHLO
	pne-smtpout2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755870AbYLKSeQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Dec 2008 13:34:16 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout2-sn2.hy.skanova.net (7.3.129)
        id 4873CA950266C732; Thu, 11 Dec 2008 19:34:14 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-10-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <1228971522-28764-5-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102811>

torsdag 11 december 2008 05:58:41 skrev Shawn O. Pearce:
> Most patch scripts impact more than one file at a time, so we need
> to support parsing multiple FileHeaders from the same input stream
> and collect them into a larger entity representing the entire script.
...
> +	public void testParse_ConfigCaseInsensitive() throws IOException {
> +		final Patch p = parseTestPatchFile();
> +		assertEquals(2, p.getFiles().size());
> +
> +		final FileHeader fRepositoryConfigTest = p.getFiles().get(0);
> +		final FileHeader fRepositoryConfig = p.getFiles().get(1);
> +
> +		assertEquals(
> +				"org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java",
> +				fRepositoryConfigTest.getNewName());
> +
> +		assertEquals(
> +				"org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java",
> +				fRepositoryConfig.getNewName());
> +
> +		assertEquals(572, fRepositoryConfigTest.startOffset);
> +		assertEquals(1490, fRepositoryConfig.startOffset);
1487 here

-- robin
