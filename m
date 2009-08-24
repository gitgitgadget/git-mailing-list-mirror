From: Thell Fowler <git@tbfowler.name>
Subject: Re: [PATCH-v2/RFC 3/6] xutils: fix ignore-all-space on incomplete
 line
Date: Mon, 24 Aug 2009 09:13:51 -0500 (CDT)
Message-ID: <alpine.DEB.2.00.0908240910120.29625@GWPortableVCS>
References: <1250999285-10683-1-git-send-email-git@tbfowler.name> <1250999357-10827-3-git-send-email-git@tbfowler.name> <7vvdkfx8rl.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.0908231110500.29625@GWPortableVCS> <7vljlauxmk.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.0908231515020.29625@GWPortableVCS> <7vzl9qtev0.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.0908232044060.29625@GWPortableVCS> <7viqgdoikz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thell Fowler <git@tbfowler.name>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 16:14:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfaJW-0003rR-Aj
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 16:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586AbZHXOOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 10:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752447AbZHXOOR
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 10:14:17 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:42097 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbZHXOOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 10:14:16 -0400
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=GWPortableVCS.local)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1MfaJN-0006k1-Bf; Mon, 24 Aug 2009 09:14:17 -0500
X-X-Sender: almostautomated@GWPortableVCS
In-Reply-To: <7viqgdoikz.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vps5.pyrapat.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tbfowler.name
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126928>

Junio C Hamano (gitster@pobox.com) wrote on Aug 24, 2009:

> Thell Fowler <git@tbfowler.name> writes:
> 
> > It passed every test I threw at it, although it seemed to be a tad bit 
> > slower than the previous revision on my sample data so I ran the following 
> > command several times for both the previous and current version:
> >
> 
> Do you mean by "previous version" the one that was broken, or the one I
> sent as a "how about" patch?
> 

A quick test shows the version merged to pu is the one that had the 
fastest times.  I'll be away from a connection most of today, but will 
test the different versions against the tests and some sample data and 
post back.

--
Thell
