From: Holger Schurig <hs4233@mail.mn-solutions.de>
Subject: Re: [PATCH] commit: resurrect "gc --auto" at the end
Date: Thu, 15 May 2008 08:44:40 +0200
Message-ID: <200805150844.40451.hs4233@mail.mn-solutions.de>
References: <20080330231408.GR11666@genesis> <alpine.DEB.1.00.0805141607210.30431@racer> <7vlk2coist.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 08:49:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwXHO-0002rV-LL
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 08:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbYEOGsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 02:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752356AbYEOGsP
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 02:48:15 -0400
Received: from s131.mittwaldmedien.de ([62.216.178.31]:22376 "EHLO
	s131.mittwaldmedien.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157AbYEOGsO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 02:48:14 -0400
Received: from lin01.mn-solutions.de (pD95FA579.dip0.t-ipconnect.de [217.95.165.121])
	by s131.mittwaldmedien.de (Postfix) with ESMTP id 7A8E75E401C;
	Thu, 15 May 2008 08:48:12 +0200 (CEST)
Received: by lin01.mn-solutions.de (Postfix, from userid 116)
	id 08ACA1E004D; Thu, 15 May 2008 08:45:20 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	lin01.mn-logistik.de
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.7-deb
Received: from mnz66.mn-solutions.de (mnz66.mn-logistik.de [192.168.233.66])
	by lin01.mn-solutions.de (Postfix) with ESMTP id 4C3641E0004;
	Thu, 15 May 2008 08:45:17 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <7vlk2coist.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82183>

> With this patch, we would again have a command that runs "gc
> --auto" once per every commit, wouldn't we?

Not sure if we have timing information. E.g. look at the 
timestamp of some file that "git gc" touched and only do this if 
it's old enought. Or look at the previous commit and only 
run "gc --auto" if this is far enought away, e.g. a couple of 
hours.
