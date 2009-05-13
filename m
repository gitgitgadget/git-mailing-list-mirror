From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Quote LF in urls git fetch saves in FETCH_HEAD
Date: Wed, 13 May 2009 20:11:35 +0200
Message-ID: <20090513181135.GC26288@blimp.localdomain>
References: <200905121557.18542.Hugo.Mildenberger@namir.de> <81b0412b0905120759u15f1ec73k73625a7904515792@mail.gmail.com> <200905121900.00625.Hugo.Mildenberger@namir.de> <81b0412b0905121018lbccda1fvf6c4c19417cdde00@mail.gmail.com> <20090512172452.GA32594@blimp.localdomain> <7vws8l7w0d.fsf@alter.siamese.dyndns.org> <81b0412b0905122306w4ed41bdiab073a05587fab55@mail.gmail.com> <alpine.LNX.2.00.0905131109240.2147@iabervon.org> <81b0412b0905130909x2ad67407p53ad6f79966c1ea3@mail.gmail.com> <alpine.LNX.2.00.0905131212000.2147@iabervon.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Hugo Mildenberger <Hugo.Mildenberger@namir.de>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed May 13 20:12:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4IwG-0002KM-66
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 20:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760878AbZEMSLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 14:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760336AbZEMSLk
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 14:11:40 -0400
Received: from mout5.freenet.de ([195.4.92.95]:35641 "EHLO mout5.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760150AbZEMSLk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 14:11:40 -0400
Received: from [195.4.92.22] (helo=12.mx.freenet.de)
	by mout5.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #89)
	id 1M4IvZ-0004IC-QT; Wed, 13 May 2009 20:11:37 +0200
Received: from x4098.x.pppool.de ([89.59.64.152]:37806 helo=tigra.home)
	by 12.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #79)
	id 1M4IvZ-0001na-A6; Wed, 13 May 2009 20:11:37 +0200
Received: from blimp.localdomain (blimp.home [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id DD604277D8;
	Wed, 13 May 2009 20:11:35 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 9E22B36D28; Wed, 13 May 2009 20:11:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0905131212000.2147@iabervon.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119081>

Daniel Barkalow, Wed, May 13, 2009 19:12:26 +0200:
> Of course, our "url" config can contain some things that aren't URLs, but 
> this particular case was of the form that's supposed to be a standard URL.

This particular case handled the _url_ just fine. The problem was in the
automatically generated name for local directory.
