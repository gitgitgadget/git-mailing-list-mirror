From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 18 Nov 2007 00:42:40 +0100
Message-ID: <20071117234240.GB7664@steel.home>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org> <7vmytycykt.fsf@gitster.siamese.dyndns.org> <7vr6j6ve90.fsf@gitster.siamese.dyndns.org> <7vir4d40sw.fsf@gitster.siamese.dyndns.org> <7vwsso3poo.fsf@gitster.siamese.dyndns.org> <7vfxz89x9q.fsf@gitster.siamese.dyndns.org> <7vabpctx3b.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 00:43:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItXJW-0003Bg-H2
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 00:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766AbXKQXmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 18:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752811AbXKQXmn
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 18:42:43 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:60401 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278AbXKQXmm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 18:42:42 -0500
Received: from tigra.home (Fc945.f.strato-dslnet.de [195.4.201.69])
	by post.webmailer.de (klopstock mo40) (RZmta 14.0)
	with ESMTP id L0476ejAHIOMLI ; Sun, 18 Nov 2007 00:42:40 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id A4F3E277AE;
	Sun, 18 Nov 2007 00:42:40 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 823F356D22; Sun, 18 Nov 2007 00:42:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vabpctx3b.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAPrzg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65321>

Junio C Hamano, Sat, Nov 17, 2007 21:51:04 +0100:
> * mh/rebase-skip-hard (Thu Nov 8 08:03:06 2007 +0100) 1 commit
>  - Do git reset --hard HEAD when using git rebase --skip
> 
> Some people on the list may find this debatable.  Opinions?

I like it (and didn't like the previous behaviour). Anyway, it is not
obvious what to do when --skip refuses to continue rebase because of
dirty index.
