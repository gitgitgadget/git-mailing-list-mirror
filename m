From: Panagiotis Issaris <takis.issaris@uhasselt.be>
Subject: Re: [RFC PATCH] Add WEBDAV timeout to http-fetch.
Date: Wed, 11 Oct 2006 12:13:04 +0000 (UTC)
Message-ID: <loom.20061011T140959-200@post.gmane.org>
References: <20061006212616.GA5175@lumumba.uhasselt.be> <20061006220542.GA5890@lumumba.uhasselt.be> <BAYC1-PASMTP08A34A8FB0703E4D2ABAF9AE130@CEZ.ICE> <BAYC1-PASMTP11CF83A008B0B3BA5F6B15AE100@CEZ.ICE> <7viriwsa75.fsf@assigned-by-dhcp.cox.net> <eg82tq$2uq$1@sea.gmane.org> <Pine.LNX.4.63.0610071930300.14200@wbgn013.biozentrum.uni-wuerzburg.de> <20061007223023.GI20017@pasky.or.cz> <Pine.LNX.4.63.0610080034490.14200@wbgn013.biozentrum.uni-wuerzburg.de> <7vbqonpfyl.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP053FFB92C509E9427F85B0AE110@CEZ.ICE> <7vfydyinto.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Oct 11 14:22:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXd5T-0003IQ-Tp
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 14:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWJKMVX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 08:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWJKMVX
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 08:21:23 -0400
Received: from main.gmane.org ([80.91.229.2]:27344 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751224AbWJKMVW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 08:21:22 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GXd45-0002rD-UH
	for git@vger.kernel.org; Wed, 11 Oct 2006 14:20:02 +0200
Received: from edm-006.edm.uhasselt.be ([193.190.10.6])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 14:20:01 +0200
Received: from takis.issaris by edm-006.edm.uhasselt.be with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 14:20:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 193.190.10.6 (Mozilla/5.0 (X11; U; Linux i686; nl; rv:1.8.1) Gecko/20061003 Firefox/2.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28711>

Hi,

Junio C Hamano <junkio <at> cox.net> writes:
>[...]
> And even for an isolated group where everybody knows that
> everybody else runs DAV-enabled clients, they need info/refs
> prepared for ls-remote and git-fetch script, which means you
> will run update-server-info to keep objects/info/packs up to
> date.
This patch worked excellent for me. Thanks! :) Any chance this might make it
into your tree? I recommended GIT to the FFmpeg developers and would like to be
able to recommend them to use GIT without any extra patches.

> Nick, do you see holes in my logic?

With friendly regards,
Takis 
