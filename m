From: Charles Bailey <cbailey32@bloomberg.net>
Subject: Re: [PATCH] Detect endianness on more platforms that don't use
 BYTE_ORDER
Date: Fri, 2 May 2014 17:58:30 +0100
Message-ID: <20140502165830.GA29339@hashpling.org>
References: <20140502074917.GA25198@hashpling.org>
 <1399017329-25645-1-git-send-email-cbailey32@bloomberg.net>
 <xmqqwqe4azyd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 02 18:58:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgGnE-0002nQ-2D
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 18:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbaEBQ6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 12:58:32 -0400
Received: from avasout06.plus.net ([212.159.14.18]:41873 "EHLO
	avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbaEBQ6b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 12:58:31 -0400
Received: from turing.int.hashpling.org ([212.159.69.125])
	by avasout06 with smtp
	id x4yU1n00A2iA9hg014yV96; Fri, 02 May 2014 17:58:30 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=TcUYtHgh c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=Ew9TdX-QAAAA:8
 a=0Bzu9jTXAAAA:8 a=J0QyKEt1u0cA:10 a=8phGgmHQHDQA:10 a=N2sEI2mohSIA:10
 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10 a=BNFp--SqAAAA:8 a=9vfCiL69lqDeJfjtxnMA:9
 a=CjuIK1q_8ugA:10 a=92rhvNbd_XgA:10
Received: from charles by turing.int.hashpling.org with local (Exim 4.82)
	(envelope-from <charles@hashpling.org>)
	id 1WgGn8-0007g6-FA; Fri, 02 May 2014 17:58:30 +0100
Content-Disposition: inline
In-Reply-To: <xmqqwqe4azyd.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247944>

On Fri, May 02, 2014 at 09:48:58AM -0700, Junio C Hamano wrote:
> Charles Bailey <cbailey32@bloomberg.net> writes:
> 
> > ---
> 
> Please sign-off your patches ;-)

Oops! Please consider this patch...

Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>

> This swaps the precedence of BYTE_ORDER and __BYTE_ORDER from the
> original, which we may not want to.  It is easy for me to swap the
> order of if/elif to restore it, so it is not a big deal, though.

I think I swapped the precedence (semi-deliberately) because I found a
proposal to standardize the BYTE_ORDER variant. I claim that any
platform which provides both but with differing senses is somewhat
broken so I cannot see the precedence mattering much. I don't mind
either way.

Charles.
