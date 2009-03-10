From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git push usability improvements and default change
Date: Mon, 09 Mar 2009 17:12:30 -0700
Message-ID: <7vbpsadymp.fsf@gitster.siamese.dyndns.org>
References: <1236638151-6465-1-git-send-email-finnag@pvv.org>
 <alpine.DEB.1.00.0903100033400.6358@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 10 01:14:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgpbl-0003wl-Jy
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 01:14:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966AbZCJAMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 20:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753912AbZCJAMk
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 20:12:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63186 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753893AbZCJAMk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 20:12:40 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C8BB9A0CE0;
	Mon,  9 Mar 2009 20:12:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 94DB3A0CDA; Mon,
  9 Mar 2009 20:12:32 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0903100033400.6358@intel-tinevez-2-302>
 (Johannes Schindelin's message of "Tue, 10 Mar 2009 00:35:12 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 291756D8-0D08-11DE-8386-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112766>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> git push default change:
>> 
>> git push will by default push "nothing" instead of "matching".
>
> Hasn't this been shot down already?  I do not want that change.  I think 
> it is harmful.
>
> At least without a proper way to prepare existing users for the end of the 
> world.

I haven't actually read the patch, but my reading of the cover lette ris
that the four-patch sequence 4-to-7 is (meant to be, at least) structured
that way.
