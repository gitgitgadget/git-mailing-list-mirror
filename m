From: Olivier Galibert <galibert@pobox.com>
Subject: Re: [PATCH 13/10] tests for various pack index features
Date: Wed, 11 Apr 2007 15:09:32 +0200
Message-ID: <20070411130932.GA17094@dspnet.fr.eu.org>
References: <alpine.LFD.0.98.0704101607390.28181@xanadu.home> <7vr6qrr51r.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0704110850010.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 16:06:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbcZv-0005tn-Om
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 15:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbXDKNJh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 09:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752306AbXDKNJh
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 09:09:37 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:2962 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205AbXDKNJg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 09:09:36 -0400
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id 03B4EA35DF; Wed, 11 Apr 2007 15:09:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0704110850010.28181@xanadu.home>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44237>

On Wed, Apr 11, 2007 at 08:57:09AM -0400, Nicolas Pitre wrote:
> Hmmm what we need is a random data generator that always produces the 
> same thing.  I'll hack something to replace urandom.

Don't hack something, ues the standard reference, the Mersenne Twister.

  http://www.math.sci.hiroshima-u.ac.jp/~m-mat/MT/emt.html

PRNGs are the same as cryptosystems, it's very easy to hack up
something and get it very, very wrong.  And it's unnecessary, since
there are very good ones available.

  OG.
