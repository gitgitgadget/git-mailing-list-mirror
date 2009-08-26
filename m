From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] upload-pack: add a trigger for post-upload-pack hook
Date: Wed, 26 Aug 2009 10:44:35 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908261043140.4713@intel-tinevez-2-302>
References: <1250579093-40706-1-git-send-email-tom@mojombo.com> <12c267e40908251043g4f3e36aya05d9c705f5afee2@mail.gmail.com> <20090825184525.GC23731@coredump.intra.peff.net> <7vprajmp16.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Tom Werner <mojombo@gmail.com>,
	Tom Preston-Werner <tom@mojombo.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 10:44:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgE7h-00041Z-Lp
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 10:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755493AbZHZIoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 04:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755365AbZHZIoh
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 04:44:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:45587 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755347AbZHZIog (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 04:44:36 -0400
Received: (qmail invoked by alias); 26 Aug 2009 08:44:36 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp026) with SMTP; 26 Aug 2009 10:44:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ZR10xYz0Z33ch33yeqRguZj7cDqGuiFsmt0ntvj
	gGjmYgHrYBaO2z
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vprajmp16.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127070>

Hi,

On Tue, 25 Aug 2009, Junio C Hamano wrote:

> If we are allowed to talk about asking for the moon,

How about

 	run_hook(NULL, "post-upload-pack",
         	 create_full_pack ? "clone" : "fetch,
		 "the moon",
                 NULL);

then?

> and if one of the primary reason for this new hook is statistics, it 
> would be useful to see the number of bytes given, where the fetch-pack 
> came from, and if we are using git-daemon virtual hosting which of our 
> domain served the request.

Certainly those are possible add-on patches, but would you require them to 
be in the same commit?

Ciao,
Dscho
