From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 10/11 v2] Fix warnings in nedmalloc when compiling with GCC 4.4.0
Date: Mon, 8 Jun 2009 20:24:00 +0200
Message-ID: <200906082024.00361.j6t@kdbg.org>
References: <1243786525-4493-1-git-send-email-prohaska@zib.de> <alpine.DEB.1.00.0906081645490.4461@intel-tinevez-2-302> <7vzlcizn3w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 20:24:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDjW3-0005es-R0
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 20:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbZFHSYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 14:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbZFHSYD
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 14:24:03 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:41334 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725AbZFHSYD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 14:24:03 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 261DBCDF94;
	Mon,  8 Jun 2009 20:24:01 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D9D153FFB6;
	Mon,  8 Jun 2009 20:24:00 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vzlcizn3w.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121096>

On Montag, 8. Juni 2009, Junio C Hamano wrote:
> Is Visual C++ happy with casting discarded result to (void)?  I'd find it
> broken if it isn't, but it would not hurt to ask just to make sure.

It is OK. Visual C++ is not *that* broken ;)

-- Hannes
