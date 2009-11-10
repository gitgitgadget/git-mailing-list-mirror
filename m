From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC, PATCH] git send-email: Make --no-chain-reply-to the default
Date: Tue, 10 Nov 2009 06:22:11 +0100
Message-ID: <20091110052211.GK7897@elte.hu>
References: <1257786206-9208-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
 <1257789555.4108.348.camel@laptop>
 <20091110040847.GC29454@elte.hu>
 <76718490911092112v4d1e7761ue98def756ed0d93b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Zijlstra <peterz@infradead.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 06:22:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7jBX-00037P-3w
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 06:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbZKJFWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 00:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbZKJFWT
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 00:22:19 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:54477 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750864AbZKJFWS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 00:22:18 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1N7jBH-0004GW-DA
	from <mingo@elte.hu>; Tue, 10 Nov 2009 06:22:21 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 0FAD83E22F5; Tue, 10 Nov 2009 06:22:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <76718490911092112v4d1e7761ue98def756ed0d93b@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx2.mail.elte.hu: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=no SpamAssassin version=3.2.5
	_SUMMARY_
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132538>


* Jay Soffian <jaysoffian@gmail.com> wrote:

> On Mon, Nov 9, 2009 at 11:08 PM, Ingo Molnar <mingo@elte.hu> wrote:
> > So ... the question would be ... could git-send-email flip its default
> 
> This is already in next for 1.7.0. See 41fe87f.
> 
> >From Junio's What's Cooking messages:
> 
> * jc/1.7.0-send-email-no-thread-default (2009-08-22) 1 commit
>   (merged to 'next' on 2009-08-22 at 5106de8)

Ah, awesome!

+1 for putting it into a .1.6.x stable branch too. (Unless there's a 
case where the recursive threading is actually useful and is being 
relied on.)

	Ingo
