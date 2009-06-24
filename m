From: Miles Bader <miles@gnu.org>
Subject: Re: push.default???
Date: Wed, 24 Jun 2009 14:50:50 +0900
Message-ID: <buoljniyybp.fsf@dhlpc061.dev.necel.com>
References: <h1nks1$vdl$1@ger.gmane.org> <20090623103428.GA4214@pvv.org>
	<4A40D19E.60606@gmail.com> <20090623131131.GA7011@pvv.org>
	<4A40D864.8040208@gmail.com> <20090623144805.GB24974@pvv.org>
	<f865508f0906230932n4a2f2b54s1e76ab1d70d95073@mail.gmail.com>
	<7vprcu96td.fsf@alter.siamese.dyndns.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bonzini@gnu.org, Finn Arne Gangstad <finnag@pvv.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 07:57:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJLUQ-0007GD-Vw
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 07:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbZFXFxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 01:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbZFXFxW
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 01:53:22 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:48041 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbZFXFxV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 01:53:21 -0400
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n5O5oesR015674;
	Wed, 24 Jun 2009 14:50:51 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay21.aps.necel.com with ESMTP; Wed, 24 Jun 2009 14:50:51 +0900
Received: from dhlpc061 ([10.114.112.173] [10.114.112.173]) by relay21.aps.necel.com with ESMTP; Wed, 24 Jun 2009 14:50:51 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 6406152E1E2; Wed, 24 Jun 2009 14:50:51 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <7vprcu96td.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 23 Jun 2009 10:51:58 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122125>

Junio C Hamano <gitster@pobox.com> writes:
> However, when 'feature' is fully cooked, before pushing it back to be
> shared with others in the group, don't you do any testing with the work
> done by others while you were working on 'feature'?  That means you first
> integrate your 'feature' locally into shared 'master' and make sure all
> fits together well.

You seem to be making a lot of assumptions about workflows here.

It seems quite plausible to me that one might want to keep the remote
branch separate, even after pushing.  It's very common to cooperatively
develop feature branches for a very long time before merging to the
"real" master, but it's still extremely useful to keep them as branches
in the same local git directory.

-Miles

-- 
Somebody has to do something, and it's just incredibly pathetic that it
has to be us.  -- Jerry Garcia
