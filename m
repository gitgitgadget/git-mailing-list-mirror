From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH 1/7] Test the origName part of the key vs the ref itself
Date: Thu, 13 Nov 2008 23:13:14 +0100
Message-ID: <200811132313.14590.robin.rosenberg.lists@dewire.com>
References: <1226095664-13759-1-git-send-email-robin.rosenberg@dewire.com> <1226095664-13759-2-git-send-email-robin.rosenberg@dewire.com> <20081111180520.GN2932@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Nov 13 23:14:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0kSS-0007y7-Na
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 23:14:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303AbYKMWNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 17:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbYKMWNT
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 17:13:19 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:43504 "EHLO
	pne-smtpout2-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751697AbYKMWNS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Nov 2008 17:13:18 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout2-sn1.fre.skanova.net (7.3.129)
        id 4843FAEB0277FA83; Thu, 13 Nov 2008 23:13:15 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-7-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <20081111180520.GN2932@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100921>

tisdag 11 november 2008 19:05:20 skrev Shawn O. Pearce:
> Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> > @@ -127,4 +129,12 @@ public void testDeleteEmptyDirs() throws IOException {
> >  	private void assertExists(final boolean expected, final String name) {
> >  		assertEquals(expected, new File(db.getDirectory(), name).exists());
> >  	}
> > +
> > +	public void testRefKeySameAsOrigName() {
> > +		Map<String, Ref> allRefs = db.getAllRefs();
> > +		for (Entry<String, Ref> e : allRefs.entrySet()) {
> > +			assertEquals(e.getKey(), e.getValue().getOrigName());
> > +
> > +		}
> > +	}
> 
> Hmm, doesn't this have to go after "Keep original ref name ..."
> so getOrigName() is actually defined?

Oops, Seems we should try to build each new commit before accepting
a push. Shouldn't be too hard.

-- robin
