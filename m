From: Charles Bailey <charles@hashpling.org>
Subject: Re: What's cooking in git.git (Jan 2009, #07; Wed, 28)
Date: Fri, 30 Jan 2009 16:32:41 +0000
Message-ID: <20090130163241.GC26321@hashpling.org>
References: <7vwscej26i.fsf@gitster.siamese.dyndns.org> <20090129081438.GA10490@hashpling.org> <7vbptqh60w.fsf@gitster.siamese.dyndns.org> <20090129091611.GB10490@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 17:34:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSwJm-000626-EU
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 17:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438AbZA3Qcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 11:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752384AbZA3Qco
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 11:32:44 -0500
Received: from relay.ptn-ipout02.plus.net ([212.159.7.36]:27821 "EHLO
	relay.ptn-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752069AbZA3Qcn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jan 2009 11:32:43 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEANe5gknUnw6T/2dsb2JhbADLJYQQBg
Received: from ptb-relay03.plus.net ([212.159.14.147])
  by relay.ptn-ipout02.plus.net with ESMTP; 30 Jan 2009 16:32:42 +0000
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay03.plus.net with esmtp (Exim) id 1LSwIL-00064j-NA; Fri, 30 Jan 2009 16:32:41 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n0UGWfnY014489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 30 Jan 2009 16:32:41 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n0UGWfwt014488;
	Fri, 30 Jan 2009 16:32:41 GMT
Content-Disposition: inline
In-Reply-To: <20090129091611.GB10490@hashpling.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: a8462c5189d2c42e63f072e79f98d822
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107845>

On Thu, Jan 29, 2009 at 09:16:11AM +0000, Charles Bailey wrote:
> On Thu, Jan 29, 2009 at 12:26:39AM -0800, Junio C Hamano wrote:
> > Charles Bailey <charles@hashpling.org> writes:
> > 
> > > On Wed, Jan 28, 2009 at 06:06:45PM -0800, Junio C Hamano wrote:
> > >> * cb/mergetool (Wed Jan 21 22:57:48 2009 +0000) 1 commit
> > >>  + mergetool: respect autocrlf by using checkout-index
> > >> 
> > >
> > > Can you hold off on merging this one? I now think that there's a
> > > cleaner way of doing this and I would like the opportunity for a
> > > rethink.
> > 
> > Sure, it is not in 'master' yet.
> > 
> > But it's in 'next', so incremental updates from now on, please.
> > 
> 
> OK, I've thought again and I still think that this patch is good.

Except that I was completely wrong. Please continue to hold off
merging into master until you've rolled in the future patch that fixes
mergetool in subdirectories which I'll clean-up and send later today.

Sorry about this.

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
