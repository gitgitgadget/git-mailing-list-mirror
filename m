From: Abhijit Menon-Sen <ams@toroid.org>
Subject: Re: [PATCH 2/4] git-imap-send: Add support for SSL.
Date: Wed, 9 Jul 2008 07:58:39 +0530
Message-ID: <20080709022839.GA4989@toroid.org>
References: <1215555496-21335-2-git-send-email-robertshearman@gmail.com> <7vbq18q7yk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Shearman <robertshearman@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 04:29:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGPRM-0007kZ-4i
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 04:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbYGIC2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 22:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbYGIC2j
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 22:28:39 -0400
Received: from fugue.toroid.org ([85.10.196.113]:46003 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751269AbYGIC2j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 22:28:39 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id CA3D9558400;
	Wed,  9 Jul 2008 04:28:36 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id 1A409ADC364; Wed,  9 Jul 2008 07:58:39 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <7vbq18q7yk.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87832>

At 2008-07-08 16:20:19 -0700, gitster@pobox.com wrote:
>
> > -    Port = 143
> > +    Port = 993
> > +    sslverify = false
> >  ..........................
> 
> Don't we also want to keep a vanilla configuration in the example, or
> is imaps the norm and unencrypted imap is exception these days?

The norm is IMAP+STARTTLS on port 143, not IMAPS on port 993. The latter
is also widely deployed for compatibility with older clients, but it is
non-standard and its use isn't exactly encouraged.

-- ams
