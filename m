From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status&commit: Teach them to show commits of modified submodules.
Date: Mon, 05 Nov 2007 18:22:33 -0800
Message-ID: <7vwsswjeom.fsf@gitster.siamese.dyndns.org>
References: <1194004427-26934-1-git-send-email-pkufranky@gmail.com>
	<7vd4us1jds.fsf@gitster.siamese.dyndns.org>
	<46dff0320711021650q4e56d025q63a961176c682a14@mail.gmail.com>
	<7vfxzoyz7f.fsf@gitster.siamese.dyndns.org>
	<46dff0320711040125v111c75davb49e9822537f4b19@mail.gmail.com>
	<46dff0320711040145k1edb1fcaq1daa5469c1158e81@mail.gmail.com>
	<7vmytus0ff.fsf@gitster.siamese.dyndns.org>
	<46dff0320711040517r6da5d7aaid849ff06df1b5bb6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Yin Ping" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 03:23:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpE5o-0003UJ-AQ
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 03:23:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867AbXKFCWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 21:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754535AbXKFCWs
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 21:22:48 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:55405 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754008AbXKFCWr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 21:22:47 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 7A6E22EF;
	Mon,  5 Nov 2007 21:23:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 099BA92B07;
	Mon,  5 Nov 2007 21:23:03 -0500 (EST)
In-Reply-To: <46dff0320711040517r6da5d7aaid849ff06df1b5bb6@mail.gmail.com>
	(Yin Ping's message of "Sun, 4 Nov 2007 21:17:58 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63614>

"Yin Ping" <pkufranky@gmail.com> writes:

> However, in some cases these messages are helpful. And a third kind of
> cases is that people care about only part of all submodules.
>
> So, maybe some an switch can be used to turn this on or off (default
> off)?

I personally think that is overengineering.  Isn't having/not
having the submodule directory cloned a good enough indicator
of which submodules are interested in by the user?
