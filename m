From: Jeff King <peff@peff.net>
Subject: Re: Implementing branch attributes in git config
Date: Thu, 11 May 2006 07:39:51 -0400
Message-ID: <20060511113951.GA28031@coredump.intra.peff.net>
References: <BAYC1-PASMTP04D623089E043F1C792A37AEA90@CEZ.ICE> <Pine.LNX.4.64.0605091543100.3718@g5.osdl.org> <BAYC1-PASMTP037EBB0237B35C5F92FB0BAEAE0@CEZ.ICE> <Pine.LNX.4.64.0605091854380.3718@g5.osdl.org> <46a038f90605100019q3b44b87kf49e456668f2e249@mail.gmail.com> <Pine.LNX.4.64.0605100823350.3718@g5.osdl.org> <46a038f90605101617x1aa9bd2du959ead77ebf61795@mail.gmail.com> <Pine.LNX.4.64.0605101629230.3718@g5.osdl.org> <Pine.LNX.4.64.0605101656110.3718@g5.osdl.org> <20060511095158.GA23620@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu May 11 13:39:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fe9WP-0002sM-E0
	for gcvg-git@gmane.org; Thu, 11 May 2006 13:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbWEKLjy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 May 2006 07:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbWEKLjy
	(ORCPT <rfc822;git-outgoing>); Thu, 11 May 2006 07:39:54 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4856 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S1030228AbWEKLjx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 May 2006 07:39:53 -0400
Received: (qmail 24394 invoked from network); 11 May 2006 11:39:51 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 11 May 2006 11:39:51 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 11 May 2006 07:39:51 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060511095158.GA23620@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19905>

On Thu, May 11, 2006 at 05:51:58AM -0400, Jeff King wrote:

> +remote=`get_remote_url "$1"` shift;

Oops, this should be:
  remote=`get_remote_url "$1"`; shift
but it actually works fine under dash (a bug in dash?)

-Peff
