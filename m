From: Junio C Hamano <gitster@pobox.com>
Subject: Re: v1.5.4 plans
Date: Mon, 03 Dec 2007 13:23:04 -0800
Message-ID: <7vsl2jh3rb.fsf@gitster.siamese.dyndns.org>
References: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.99999.0712031258460.9605@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Dec 03 22:24:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzIlg-00033P-6Z
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 22:23:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbXLCVXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 16:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752301AbXLCVXL
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 16:23:11 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:33502 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbXLCVXK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 16:23:10 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 4992A2FA;
	Mon,  3 Dec 2007 16:23:31 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id D4FC19C6BF;
	Mon,  3 Dec 2007 16:23:28 -0500 (EST)
In-Reply-To: <alpine.LFD.0.99999.0712031258460.9605@xanadu.home> (Nicolas
	Pitre's message of "Mon, 03 Dec 2007 13:06:49 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66958>

Nicolas Pitre <nico@cam.org> writes:

> Two things I would like to see in the next version (1.5.5) as well, for 
> which we could provide early warnings now:
>
>  - repack.usedeltabaseoffset defaulting to true
>
>  - pack.indexversion defaulting to 2

I think the former would be sensible, the latter I fear might be a bit
too new but I do not recall the exact version dependency.

Could you draft a patch to ReleaseNotes to explain the consequences of
these changes using ordinary user's vocabulary, like:

	Starting v1.5.5, repack.usedeltabaseoffset will default to true,
	which will give denser packfile (i.e. more efficient storage).
	The downside is that git older than version X will not be able
	to use a repository packed using this setting.
