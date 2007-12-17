From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] provide advance warning of some future pack default changes
Date: Mon, 17 Dec 2007 18:13:29 -0500 (EST)
Message-ID: <alpine.LFD.0.999999.0712171810310.8467@xanadu.home>
References: <alpine.LFD.0.999999.0712141724260.8467@xanadu.home>
 <20071214223957.GC7300@mail.oracle.com>
 <alpine.LFD.0.999999.0712141744460.8467@xanadu.home>
 <20071215004230.GF7300@mail.oracle.com>
 <alpine.LFD.0.999999.0712142114400.8467@xanadu.home>
 <20071217200920.GB19816@mail.oracle.com>
 <alpine.LFD.0.999999.0712171517320.8467@xanadu.home>
 <20071217211317.GC19816@mail.oracle.com> <20071217213049.GG13515@fieldses.org>
 <alpine.LFD.0.999999.0712171646230.8467@xanadu.home>
 <20071217215709.GH13515@fieldses.org>
 <7vtzmh55lu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Joel Becker <Joel.Becker@oracle.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 00:14:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4P9q-0000Hb-Sw
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 00:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762057AbXLQXNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 18:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760159AbXLQXNd
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 18:13:33 -0500
Received: from relais.videotron.ca ([24.201.245.36]:40037 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761947AbXLQXNc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 18:13:32 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JT7002WEV6FLNB0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 17 Dec 2007 18:13:27 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vtzmh55lu.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 0.999999 (LFD 847 2007-12-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68657>

On Mon, 17 Dec 2007, Junio C Hamano wrote:

> Pack-idx format v2 is by design much safer in the face of bitflip (do we
> have a test case to make sure this is indeed true?).

t5302 provides a good demonstration of that.


Nicolas
