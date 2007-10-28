From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 4/8] rev-parse: teach "git rev-parse --symbolic" to print the full ref name
Date: Sun, 28 Oct 2007 04:06:55 -0400
Message-ID: <20071028080654.GS14735@spearce.org>
References: <119350380778-git-send-email-prohaska@zib.de> <11935038081211-git-send-email-prohaska@zib.de> <11935038081650-git-send-email-prohaska@zib.de> <1193503808519-git-send-email-prohaska@zib.de> <11935038083369-git-send-email-prohaska@zib.de> <7v3avvy9yc.fsf@gitster.siamese.dyndns.org> <79CE31EE-0975-48EB-8B3E-FC9D6A8EB3E4@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Oct 28 09:07:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im3B9-000664-LH
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 09:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbXJ1IHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 04:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbXJ1IHN
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 04:07:13 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53694 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbXJ1IHI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 04:07:08 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Im3Ad-0004lx-Kf; Sun, 28 Oct 2007 04:06:57 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 379D920FBAE; Sun, 28 Oct 2007 04:06:55 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <79CE31EE-0975-48EB-8B3E-FC9D6A8EB3E4@zib.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62537>

Steffen Prohaska <prohaska@zib.de> wrote:
> On Oct 28, 2007, at 8:28 AM, Junio C Hamano wrote:
> >Steffen Prohaska <prohaska@zib.de> writes:
> >>@@ -213,6 +215,7 @@ int cmd_rev_parse(int argc, const char **argv,  
> >>const char *prefix)
> >> {
> >> 	int i, as_is = 0, verify = 0;
> >> 	unsigned char sha1[20];
> >>+	char* real_name = 0;
> >
> >Pointer sign '*' in git sources go next to the name not the
> >type, as:
> >
> >	char *real_name = NULL;
> 
> I know and I tried hard to follow this convention, although
> I think its the wrong choice ;)

Oh, hmm...

  char* a, b;

What's the type of b?  If you said "char*" you're wrong.

Git's style of putting the * next to the name makes it far easier to
spot these sort of typing problems.  At least that's my take on it.

-- 
Shawn.
