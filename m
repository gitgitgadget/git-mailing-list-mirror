From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Replace instances of export VAR=VAL with VAR=VAL; export VAR
Date: Wed, 28 Nov 2007 14:46:33 -0800
Message-ID: <7vzlwy2dkm.fsf@gitster.siamese.dyndns.org>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com>
	<C3971B37-F75A-40EE-B30A-E88E5DAFAD55@lrde.epita.fr>
	<D21294CA-6FD0-40F5-B0D6-5155865DA69A@wincent.com>
	<CDF48716-F198-4B33-A5F5-8A2DE1F177EB@wincent.com>
	<474AC136.8060906@viscovery.net>
	<451492C9-F3EA-4C37-A1AD-59FC72E0A0A2@wincent.com>
	<Pine.LNX.4.64.0711261340470.27959@racer.site>
	<97F6E8DE-4022-4458-B6A9-C644A6EDC1E3@wincent.com>
	<7vir3m94ku.fsf@gitster.siamese.dyndns.org>
	<50645A3B-C5F0-4A99-A2B8-AD9251024244@wincent.com>
	<7v1waa7lcv.fsf@gitster.siamese.dyndns.org>
	<1570EAD5-9F47-4105-B3DA-49CA6FA57369@wincent.com>
	<Pine.LNX.4.64.0711281355460.27959@racer.site>
	<474D7956.8050401@viscovery.net>
	<Pine.LNX.4.64.0711281428180.27959@racer.site>
	<474D7D92.2000106@viscovery.net>
	<Pine.LNX.4.64.0711281552440.27959@racer.site>
	<85ve7m8iix.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Wincent Colaiuta <win@wincent.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 23:47:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxVgY-0006I3-2V
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 23:47:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757674AbXK1Wqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 17:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756360AbXK1Wqq
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 17:46:46 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:59337 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756050AbXK1Wqp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 17:46:45 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id B11DC2F2;
	Wed, 28 Nov 2007 17:47:04 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id BA72C9ACB1;
	Wed, 28 Nov 2007 17:46:57 -0500 (EST)
In-Reply-To: <85ve7m8iix.fsf@lola.goethe.zz> (David Kastrup's message of "Wed,
	28 Nov 2007 17:03:02 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66447>

David Kastrup <dak@gnu.org> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> It might be POSIX, but there are shells that do not like the
>> expression 'export VAR=VAL'.
>
> As long as we have no positive report about any such shell that
> _otherwise_ would be usable for git, why bother?

I thought somebody already mention that ash mishandles "export VAR=VAL"
but otherwise Ok.
