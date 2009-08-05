From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/2] Implement git-vcs-p4
Date: Wed, 5 Aug 2009 20:14:14 +0200
Message-ID: <20090805181414.GA13166@blimp.localdomain>
References: <alpine.LNX.2.00.0908050056580.2147@iabervon.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>, Pete Wyckoff <pw@padd.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 20:14:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYl0U-0008B0-HP
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 20:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbZHESO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 14:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbZHESO1
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 14:14:27 -0400
Received: from mout4.freenet.de ([195.4.92.94]:53602 "EHLO mout4.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339AbZHESO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 14:14:26 -0400
Received: from [195.4.92.17] (helo=7.mx.freenet.de)
	by mout4.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #92)
	id 1MYl0F-0003bP-EM; Wed, 05 Aug 2009 20:14:19 +0200
Received: from x76cc.x.pppool.de ([89.59.118.204]:46060 helo=tigra.home)
	by 7.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #93)
	id 1MYl0F-0003rO-6w; Wed, 05 Aug 2009 20:14:19 +0200
Received: from blimp.localdomain (blimp.home [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 93CD5277D8;
	Wed,  5 Aug 2009 20:14:15 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 1A85C36D28; Wed,  5 Aug 2009 20:14:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0908050056580.2147@iabervon.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-purgate-ID: 149285::1249496059-000046EB-163AD050/0-0/0-0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124938>

Daniel Barkalow, Wed, Aug 05, 2009 07:02:31 +0200:
>  vcs-p4/p4client-api.cc       |  455 +++++++++++++++
>  vcs-p4/p4client.c            |  158 ++++++
>  vcs-p4/p4client.h            |   74 +++
>  vcs-p4/vcs-p4.c              | 1250 ++++++++++++++++++++++++++++++++++++++++++
>  vcs-p4/vcs-p4.h              |  135 +++++

Maybe put these in contrib/ ?
