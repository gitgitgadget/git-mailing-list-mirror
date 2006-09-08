From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] Move color option parsing out of diff.c and into color.[ch]
Date: Thu, 7 Sep 2006 20:11:32 -0400
Message-ID: <20060908001132.GA18649@coredump.intra.peff.net>
References: <2ec783f6a8e8a901f7c30947e8c0eb50f71bc185.1157610743.git.peff@peff.net> <20060907063559.GB17083@coredump.intra.peff.net> <7vfyf3s01w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 02:11:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLTy6-0005nU-Gu
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 02:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbWIHALf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 20:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbWIHALf
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 20:11:35 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:14261 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751921AbWIHALe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Sep 2006 20:11:34 -0400
Received: (qmail 17267 invoked from network); 7 Sep 2006 20:10:58 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 7 Sep 2006 20:10:58 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu,  7 Sep 2006 20:11:32 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfyf3s01w.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26666>

On Thu, Sep 07, 2006 at 04:56:43PM -0700, Junio C Hamano wrote:

> Some school of programming teach us to start the function name
> at the beginning of the line, separate from its type.  They say
> that would make "grep '^parse_color'" to work better.

Hmm. I don't like that style either, I was just using it because I
thought that was the git style (which must have been caused by seeing
some other function(s) with the same style -- but grepping through, it
looks like there are very few functions using it). I'll fix the patches,
but will wait to resend until I hear other comments.

-Peff
