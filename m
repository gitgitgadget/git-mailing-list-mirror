From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] filter-branch.sh: support nearly proper tag name
 filtering
Date: Mon, 24 Mar 2008 17:46:27 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803241745240.4353@racer.site>
References: <1206031893-29599-1-git-send-email-casey@nrlssc.navy.mil> <47E298A5.6050508@nrlssc.navy.mil> <alpine.LSU.1.00.0803201812560.4124@racer.site> <7vr6e01xja.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803241152050.4353@racer.site>
 <7viqzc18j9.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803241609540.4353@racer.site> <47E7D818.7090501@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Mar 24 17:47:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdppH-0004iN-Iw
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 17:47:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755255AbYCXQqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 12:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755245AbYCXQqZ
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 12:46:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:36804 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755223AbYCXQqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 12:46:25 -0400
Received: (qmail invoked by alias); 24 Mar 2008 16:46:22 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp008) with SMTP; 24 Mar 2008 17:46:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18SacAB1e4SofskPQGUAd4hRyoH2qxxvO3pQKjZQo
	dDqtofUSu9E0at
X-X-Sender: gene099@racer.site
In-Reply-To: <47E7D818.7090501@nrlssc.navy.mil>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78059>

Hi,

On Mon, 24 Mar 2008, Brandon Casey wrote:

> So right now, tags matching the refspec are rewritten. They are currently
> rewritten with a lightweight tag.

That is unintended.  My understanding of a tag was always that it is 
something immutable.  I mean, _really_ immutable.  If you released a 
certain version, then that is tagged.  You must not rewrite the tag.  
Ever.

Ciao,
Dscho
