From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-config: aliases with parameter expansion ($1 and such)
Date: Sun, 23 Mar 2008 19:47:35 -0700
Message-ID: <7vzlso3kjc.fsf@gitster.siamese.dyndns.org>
References: <47E65AF5.4060708@dirk.my1.cc>
 <76718490803230645k13471472sc99932563b0239da@mail.gmail.com>
 <47E66382.5030800@dirk.my1.cc>
 <20080323193842.GA23227@coredump.intra.peff.net>
 <20080323194514.GA23492@coredump.intra.peff.net>
 <76718490803231854u6ee76437h5acf37b0b602f3b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeff King" <peff@peff.net>,
	=?utf-8?Q?Dirk_S=C3=BCsserott?= <newsletter@dirk.my1.cc>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jay Soffian" <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 03:48:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdcjg-0005pH-Jg
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 03:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbYCXCrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 22:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752443AbYCXCrv
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 22:47:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40387 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbYCXCru (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 22:47:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9D66B1ADD;
	Sun, 23 Mar 2008 22:47:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 16FEC1ADC; Sun, 23 Mar 2008 22:47:43 -0400 (EDT)
In-Reply-To: <76718490803231854u6ee76437h5acf37b0b602f3b1@mail.gmail.com>
 (Jay Soffian's message of "Sun, 23 Mar 2008 21:54:49 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77995>

"Jay Soffian" <jaysoffian@gmail.com> writes:

> All my shell aliases therefor look like:
>
> h          = "!sh -c 'git alias \"$1\" || git help \"$1\"' -"
>
> (Notice the trailing '-'.)

Just for my curiosity, why aren't they

> h          = "!sh -c 'git alias \"$0\" || git help \"$0\"'"

without trailing '-'?
