From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: Re: [PATCHv4 2/2] filter-branch: Add tests for submodules in tree-filter
Date: Fri, 29 Jan 2010 16:20:35 +0100
Message-ID: <201001291620.35269.sojkam1@fel.cvut.cz>
References: <201001281002.03232.sojkam1@fel.cvut.cz> <1264669727-9977-2-git-send-email-sojkam1@fel.cvut.cz> <7vaavxlwoz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, j.sixt@viscovery.net,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 16:20:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaseX-0006Yq-R9
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 16:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755617Ab0A2PUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 10:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755148Ab0A2PUr
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 10:20:47 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:47738 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754525Ab0A2PUq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 10:20:46 -0500
Received: from localhost (unknown [192.168.200.4])
	by max.feld.cvut.cz (Postfix) with ESMTP id D12DC19F33E1;
	Fri, 29 Jan 2010 16:20:45 +0100 (CET)
X-Virus-Scanned: IMAP AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new, port 10044)
	with ESMTP id 90cZ-EbnoYrn; Fri, 29 Jan 2010 16:20:41 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 60A6C19F33BD;
	Fri, 29 Jan 2010 16:20:41 +0100 (CET)
Received: from steelpick.localnet (k335-30.felk.cvut.cz [147.32.86.30])
	(Authenticated sender: sojkam1)
	by imap.feld.cvut.cz (Postfix) with ESMTPSA id 3B3FCFA003;
	Fri, 29 Jan 2010 16:20:36 +0100 (CET)
User-Agent: KMail/1.12.4 (Linux/2.6.31.11-amd64; KDE/4.3.4; x86_64; ; )
In-Reply-To: <7vaavxlwoz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138324>

On Thursday 28 of January 2010 22:57:16 Junio C Hamano wrote:
> Michal Sojka <sojkam1@fel.cvut.cz> writes:
> > +test_expect_success 'setup submodule' '
> > +	rm -rf * .*
> 
> Yikes.  Please don't do this.
> 
> [...]
> 
> but it would be preferable to be even more explicit "rm -fr ?* .git".

Fixed. I did it like you suggested.

> Also make sure you don't break the chain of "&&" unnecessarily.
> 

Fixed.

I've also split each my test into two separate tests. In the first one I 
perform the rewrite and in the second I test that the result is what was 
expected. I did it because the other tests in this file are structured the 
same way.

Cheers,
Michal
