From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unquote_c_style: fix off-by-one.
Date: Thu, 06 Mar 2008 14:10:41 -0800
Message-ID: <7vbq5ra4gu.fsf@gitster.siamese.dyndns.org>
References: <20080306212819.GA10873@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Mar 06 23:11:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXOJE-0005Hf-SP
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 23:11:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755700AbYCFWKu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2008 17:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756675AbYCFWKu
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 17:10:50 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57371 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755700AbYCFWKt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2008 17:10:49 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3FA2C13CB;
	Thu,  6 Mar 2008 17:10:48 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B086213CA; Thu,  6 Mar 2008 17:10:45 -0500 (EST)
In-Reply-To: <20080306212819.GA10873@artemis.madism.org> (Pierre Habouzit's
 message of "Thu, 06 Mar 2008 22:28:19 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76427>

Pierre Habouzit <madcoder@debian.org> writes:

> Thanks to Adeodato Sim=C3=B2 for having caught this.
>
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>

Thanks.  I would have appreciated a comment that said something about w=
hat
external breakages this one caused, so that we can have an entry in "bu=
gs
fixed" list.

A quick audit of the existing callers suggests that it is fast-import.
