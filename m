From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problem compiling git-1.6.4 on OpenServer 6.0
Date: Fri, 07 Aug 2009 13:07:57 -0700
Message-ID: <7v8whvv142.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0908071326250.13290@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 22:08:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZVjb-000654-Dx
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 22:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933564AbZHGUIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 16:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933581AbZHGUIB
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 16:08:01 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47920 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S933528AbZHGUIA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 16:08:00 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D38D21C23;
	Fri,  7 Aug 2009 16:08:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43DC31C20; Fri,  7 Aug
 2009 16:07:59 -0400 (EDT)
In-Reply-To: <alpine.LNX.2.00.0908071326250.13290@suse104.zenez.com> (Boyd
 Lynn Gerber's message of "Fri\, 7 Aug 2009 13\:27\:51 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0284FFBE-838E-11DE-A234-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125216>

Boyd Lynn Gerber <gerberb@zenez.com> writes:

> I just tried to compile the latest git and I get this error.
>
> CC builtin-pack-objects.o
> UX:acomp: ERROR: "builtin-pack-objects.c", line 1602: integral
> constant expression expected

I think we recently acquired another instance of variable sized array on
the stack in addition to this one.
