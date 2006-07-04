From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] Add read_cache_from() and discard_cache()
Date: Tue, 4 Jul 2006 16:18:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607041617290.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060630002756.GD22618@steel.home>
 <Pine.LNX.4.63.0606300235300.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0606301643150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v3bdmk2zj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0607011657460.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v64ihdupr.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0607021043550.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7virmepfhx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 16:19:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxljq-0001nx-Ko
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 16:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWGDOSv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 10:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWGDOSv
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 10:18:51 -0400
Received: from mail.gmx.de ([213.165.64.21]:46738 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932257AbWGDOSv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 10:18:51 -0400
Received: (qmail invoked by alias); 04 Jul 2006 14:18:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 04 Jul 2006 16:18:49 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virmepfhx.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23299>

Hi,

On Mon, 3 Jul 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Okay. After reading the comment, I am quite certain we can just set the 
> > index_file_timestamp to 0.
> 
> Thanks.
> 
> > So, I still think that these two lines should be in the cleanup part of 
> > get_merge_bases().
> 
> I think that is sane -- please make it so.

Ummm. After reading my original mail again: bad tobacco that was. Of 
course, I meant discard_cache(), not get_merge_bases(). Setting 
index_file_timestamp in get_merge_bases() would be wrong.

Sorry for the noise,
Dscho
