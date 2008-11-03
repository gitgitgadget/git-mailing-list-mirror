From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATHv3 2/3] gitweb: retrieve snapshot format from PATH_INFO
Date: Sun, 02 Nov 2008 22:17:40 -0800
Message-ID: <7v7i7lwcxn.fsf@gitster.siamese.dyndns.org>
References: <1225617699-30004-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1225617699-30004-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1225617699-30004-3-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 07:19:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwsmZ-0002tA-HC
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 07:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbYKCGSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 01:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbYKCGSI
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 01:18:08 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36161 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbYKCGSG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 01:18:06 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A40017737F;
	Mon,  3 Nov 2008 01:18:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E325577376; Mon,  3 Nov 2008 01:17:46 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2D3F5046-A96F-11DD-B245-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99901>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> +	# It's also useless to try any matching unless $refname has a dot,
> +	# so we check for that too
> +	if ($input_params{'action'} eq 'snapshot' &&

This broke t9500 because $input_params{'action'} can be undef.  What I'll
be pushing out on 'pu' has a fixup on it (I am rewinding and rebuilding
'pu' right now so it will be a while).

Next time, please make sure that your patches pass the tests before sending
them out.

Thanks.
