From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Tue, 27 Jan 2009 18:02:20 -0800
Message-ID: <20090128020220.GE1321@spearce.org>
References: <bab6a2ab0901271504j73dce7afjf8436c3c7c83b770@mail.gmail.com> <bab6a2ab0901271510y1e3e6912t82ff16e0f912d4b6@mail.gmail.com> <alpine.DEB.1.00.0901280034310.3586@pacific.mpi-cbg.de> <20090127233939.GD1321@spearce.org> <7v1vuo1f6d.fsf@gitster.siamese.dyndns.org> <bab6a2ab0901271634x7201130bx4a565bd8bea6967b@mail.gmail.com> <7vvds0z1c1.fsf@gitster.siamese.dyndns.org> <7vk58gz04l.fsf@gitster.siamese.dyndns.org> <7vfxj4yzjj.fsf@gitster.siamese.dyndns.org> <bab6a2ab0901271757i4602774ahef1d881b7ed58097@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: PJ Hyett <pjhyett@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 03:03:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRzmM-0000vF-EK
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 03:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbZA1CCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 21:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752084AbZA1CCV
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 21:02:21 -0500
Received: from george.spearce.org ([209.20.77.23]:58878 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbZA1CCV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 21:02:21 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9955438210; Wed, 28 Jan 2009 02:02:20 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <bab6a2ab0901271757i4602774ahef1d881b7ed58097@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107451>

PJ Hyett <pjhyett@gmail.com> wrote:
> 
> Is there any possibility to have the server code in an upcoming
> release account for clients running 1.6.1?

I can't think off-hand of a way for the server to know what version
the client is.  There's nothing really different in the protocol
between a 1.6.1 client and a v1.5.5-rc0~44^2 (introduction of
include-tag) or later client.

So there's no easy way for the server to work around this possible
glitch in the client.

-- 
Shawn.
