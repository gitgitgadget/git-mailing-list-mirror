From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash: Add long option completion for 'git send-email'
Date: Mon, 14 Jul 2008 21:49:29 -0700
Message-ID: <7vmykjda5i.fsf@gitster.siamese.dyndns.org>
References: <1216023662-9109-1-git-send-email-tlikonen@iki.fi>
 <20080715043839.GE2432@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 06:50:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIcUn-0001PZ-L4
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 06:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480AbYGOEti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 00:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbYGOEti
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 00:49:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42714 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbYGOEth (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 00:49:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3B21E2F692;
	Tue, 15 Jul 2008 00:49:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 985452F68E; Tue, 15 Jul 2008 00:49:32 -0400 (EDT)
In-Reply-To: <20080715043839.GE2432@spearce.org> (Shawn O. Pearce's message
 of "Tue, 15 Jul 2008 04:38:39 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6CBAB262-5229-11DD-9B2F-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88521>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Hmm.  With dash form commands gone in 1.6 we should remove these.
>
> But I suspect this completion patch could be shipped in the next
> 1.5.6 maint release as its really quite trivial.  Junio, any comment
> on that?

Yeah, it is trivial but does it deserve "bugfix -- we need to deliver this
change to the end users, otherwise they will suffer" label?  Probably not.
