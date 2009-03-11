From: Miles Bader <miles@gnu.org>
Subject: Re: setting up tracking on push
Date: Wed, 11 Mar 2009 14:03:14 +0900
Message-ID: <buobps81wj1.fsf@dhlpc061.dev.necel.com>
References: <buofxhr2vta.fsf@dhlpc061.dev.necel.com>
	<buoy6vi297q.fsf@dhlpc061.dev.necel.com>
	<49b12ff7.nCWIz4ABJcgwW3BZ%obrien654j@gmail.com>
	<76718490903060743m425c2d55n6e8737c893c936e8@mail.gmail.com>
	<87d4cuobrc.fsf@catnip.gol.com> <49B6CCDB.8010305@xiplink.com>
	<20090310230939.GB14083@sigio.peff.net>
	<76718490903101852y2c90e0abi8e0e4f71e6f0bc52@mail.gmail.com>
	<20090311020409.GA31365@coredump.intra.peff.net>
	<7vwsaw7jzy.fsf@gitster.siamese.dyndns.org>
	<fc339e4a0903102156q4b61b712j6c7b4daaef6f163@mail.gmail.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 06:06:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhGdc-0005jf-Le
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 06:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbZCKFDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 01:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbZCKFDg
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 01:03:36 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:57288 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbZCKFDf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 01:03:35 -0400
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n2B53FgG008103;
	Wed, 11 Mar 2009 14:03:15 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.16] [10.29.19.16]) by relay31.aps.necel.com with ESMTP; Wed, 11 Mar 2009 14:03:15 +0900
Received: from dhlpc061 ([10.114.112.181] [10.114.112.181]) by relay31.aps.necel.com with ESMTP; Wed, 11 Mar 2009 14:03:14 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id E2E5852E277; Wed, 11 Mar 2009 14:03:14 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <fc339e4a0903102156q4b61b712j6c7b4daaef6f163@mail.gmail.com>
	(Miles Bader's message of "Wed, 11 Mar 2009 13:56:52 +0900")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112883>

Miles Bader <miles@gnu.org> writes:
> I agree, and that's the use-case that prompted my original query.  I
> very often create a new branch locally, and later push it to origin
> with an intent to subsequently keep it synced with the new remote
> branch.

Oh, and I also always use the syntax:

   git push origin BRANCH_NAME

As the (apparent) objection adding "git push --track" was the question
of what the behavior would be in the general case (where lots of
branches can be pushed), maybe restricting "--track" to only specific
cases would be a possible solution?

-Miles

-- 
97% of everything is grunge
