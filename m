From: Holger Schurig <hs4233@mail.mn-solutions.de>
Subject: Re: [PATCH] Fix sed syntax in t7502-commit for OSX
Date: Thu, 15 May 2008 10:58:34 +0200
Message-ID: <200805151058.34774.hs4233@mail.mn-solutions.de>
References: <1210817948-72280-1-git-send-email-git-dev@marzelpan.de> <7vwslwgdyi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Marcel Koeppen <git-dev@marzelpan.de>, sbejar@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 11:04:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwZMy-0005XD-Qj
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 11:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754797AbYEOJCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 05:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754570AbYEOJCM
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 05:02:12 -0400
Received: from s131.mittwaldmedien.de ([62.216.178.31]:26645 "EHLO
	s131.mittwaldmedien.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754349AbYEOJCK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 05:02:10 -0400
Received: from lin01.mn-solutions.de (pD95FA579.dip0.t-ipconnect.de [217.95.165.121])
	by s131.mittwaldmedien.de (Postfix) with ESMTP id 4A1535E4014;
	Thu, 15 May 2008 11:02:08 +0200 (CEST)
Received: by lin01.mn-solutions.de (Postfix, from userid 116)
	id 22A9A1E004D; Thu, 15 May 2008 10:59:17 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	lin01.mn-logistik.de
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.7-deb
Received: from mnz66.mn-solutions.de (mnz66.mn-logistik.de [192.168.233.66])
	by lin01.mn-solutions.de (Postfix) with ESMTP id CED8A1E0004;
	Thu, 15 May 2008 10:59:11 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <7vwslwgdyi.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82191>

> > -sed -i '$d' expect
> > +sed -i -e '$d' expect

perl -pi -e 's/foo/bar/' ???

GIT already needs perl, so we can re-use it's features savely.
