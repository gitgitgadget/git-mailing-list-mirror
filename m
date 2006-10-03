From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: make leftmost column of blame less cluttered.
Date: Tue, 3 Oct 2006 12:01:47 -0700 (PDT)
Message-ID: <20061003190148.56650.qmail@web31805.mail.mud.yahoo.com>
References: <7vpsdat4ia.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 21:02:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUpWc-0005en-4Q
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 21:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030471AbWJCTBu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 15:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030472AbWJCTBu
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 15:01:50 -0400
Received: from web31805.mail.mud.yahoo.com ([68.142.207.68]:45143 "HELO
	web31805.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030471AbWJCTBt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 15:01:49 -0400
Received: (qmail 56655 invoked by uid 60001); 3 Oct 2006 19:01:48 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ZDypg1sDCjC2r8H6ezLl7G1s2YnSNqjcyX73AiDh9JHfH5OPXoOlPX0hsGo1CJlKuq9vK86TmWTJh1ue9QDi7gDI0tdHGBlS81PA83yTx5V1vsLwGTAhiOdhaE0fLGAoBK0MnYkIJ10ZXzr1dW4Vvx3XzbB7T2r/W9fSyzgqYmU=  ;
Received: from [64.215.88.90] by web31805.mail.mud.yahoo.com via HTTP; Tue, 03 Oct 2006 12:01:47 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsdat4ia.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28288>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> > ACK.  Please commit.
> 
> Won't, at least as its current shape.  Somebody privately
> mentioned that the code risks slurping the entire file in the
> @chunk if it is untouched since the initial import, which is not
> what we want.

Indeed that's true.

> The memory consumption worries aside, that would make the
> clickable commit object name to appear only very at the
> beginning of the page and would make it inconvenient to actually
> visit the commit after scrolling down to see later lines.
> 
> It might become usable if it is given a cap to limit the number
> of lines to put in a chunk.  I dunno.

I cannot imagine this to be a problem, since an initial commit
is "very well known" (hopefully that makes sense to people using
SCMs religously).

I'll give it try.
   Luben
