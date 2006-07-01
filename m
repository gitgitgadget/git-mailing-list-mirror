From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Enable tree (directory) history display
Date: Fri, 30 Jun 2006 20:10:04 -0700 (PDT)
Message-ID: <20060701031004.29384.qmail@web31801.mail.mud.yahoo.com>
References: <7v3bdmf2p6.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Jul 01 05:10:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwVsN-00040p-OY
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 05:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbWGADKI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 23:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbWGADKI
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 23:10:08 -0400
Received: from web31801.mail.mud.yahoo.com ([68.142.207.64]:44930 "HELO
	web31801.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751704AbWGADKF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 23:10:05 -0400
Received: (qmail 29386 invoked by uid 60001); 1 Jul 2006 03:10:04 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=fiSLdJFh08Y9JeAc8odkxr4qpF0n6NDt2ud04xtkbxLMzQImkOX8L1glpDdwDWrmmJQGIhThxFS1FX97QvhCqrO41e5GJ/7QuGWPfWcvl6Xq7WEECsWxgT9dsHlUIa6xY6AZ+ef/juMpfl3xJzo+6bFrJ6a0lhKLjgle3db0XQc=  ;
Received: from [68.186.62.135] by web31801.mail.mud.yahoo.com via HTTP; Fri, 30 Jun 2006 20:10:04 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bdmf2p6.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23036>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > I took a comparative look with and without "--full-history",
> > and FWIW, enabling full history just clobbers the output with a lot
> > of unnecessary information.  I.e. it shows merges which do not have
> > direct consequence or change to the files in the path spec specified
> > after the "--".
> >...
> > FWIW, I think that the original intention (had there been a choice)
> > would've been to show only most relevant history, i.e. changes
> > directly related to paths and files after the "--".
> 
> Sounds sane.  Maybe we should clearly explain this behaviour
> change in the commit log and claim it as an improvement.  We
> might even want to do --no-merges if we go that route.

I agree.  Indeed, this would definitely be an improvement.

   Luben
