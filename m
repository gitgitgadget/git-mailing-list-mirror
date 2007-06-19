From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Errors building git-1.5.2.2 on 64-bit Centos 5
Date: Tue, 19 Jun 2007 22:09:39 +0200
Message-ID: <20070619200939.GA4180@steel.home>
References: <18039.52754.563688.907038@lisa.zopyra.com> <Pine.LNX.4.64.0706191359160.4059@racer.site> <20070619132456.GA15023@fiberbit.xs4all.nl> <18039.57099.57602.28299@lisa.zopyra.com> <20070619143000.GA15352@fiberbit.xs4all.nl> <18039.60598.264803.940960@lisa.zopyra.com> <86k5u0q8q9.fsf@lola.quinscape.zz> <18040.346.208040.842060@lisa.zopyra.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 22:09:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0k1W-0007NS-T8
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 22:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764828AbXFSUJr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 16:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764854AbXFSUJq
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 16:09:46 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:23710 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764828AbXFSUJp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 16:09:45 -0400
Received: from tigra.home (Faad5.f.strato-dslnet.de [195.4.170.213])
	by post.webmailer.de (mrclete mo17) (RZmta 7.4)
	with ESMTP id w05475j5JJmhZk ; Tue, 19 Jun 2007 22:09:40 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 511A4277BD;
	Tue, 19 Jun 2007 22:09:40 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 0A7E8C164; Tue, 19 Jun 2007 22:09:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <18040.346.208040.842060@lisa.zopyra.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtopJuBo=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50505>

Bill Lear, Tue, Jun 19, 2007 18:16:26 +0200:
> % cat foo
> set -x
> type tar
> type cd
> (cd blt && tar cf - .) | (cd /opt/git-1.5.2.2/share/git-core/templates && tar xf -)

what would you see if your script contained:

    set -x
    (cd blt && tar cf - .) |less

?
Does the output look like a tar archive to you?
Can you share it with us if you're not sure?
