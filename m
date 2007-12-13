From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] git-svn: unlink internal index files after operations
Date: Thu, 13 Dec 2007 21:27:57 +0100
Message-ID: <20071213202757.GA2387@diana.vm.bytemark.co.uk>
References: <20071213162734.GA18433@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Dec 13 21:29:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2uge-0006RB-Pb
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 21:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762031AbXLMU3P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Dec 2007 15:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761383AbXLMU3O
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 15:29:14 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3692 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760870AbXLMU3N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 15:29:13 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1J2uf0-0000is-00; Thu, 13 Dec 2007 20:27:58 +0000
Content-Disposition: inline
In-Reply-To: <20071213162734.GA18433@soma>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68188>

On 2007-12-13 08:27:34 -0800, Eric Wong wrote:

> Being git, we can generate these very quickly on the fly as needed,
> so there's no point in wasting space for these things for large
> projects.

Excellent!

=46or existing repos, I assume the correct thing to do is to just blast
all the existing index files manually?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
