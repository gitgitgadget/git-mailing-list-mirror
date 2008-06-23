From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Bugfix for AIX tmpfile creation
Date: Mon, 23 Jun 2008 16:14:39 -0700
Message-ID: <7vej6ng2w0.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.10.0806231552510.2926@woody.linux-foundation.org>
 <911589C97062424796D53B625CEC0025E46183@USCOBRMFA-SE-70.northamerica.cexp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <torvalds@linux-foundation.org>, <gitster@pobox.com>,
	<git@vger.kernel.org>
To: <Patrick.Higgins@cexp.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 01:15:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAvGI-0001bR-0B
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 01:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748AbYFWXOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 19:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbYFWXOz
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 19:14:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45848 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748AbYFWXOx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 19:14:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 02DAE10AF5;
	Mon, 23 Jun 2008 19:14:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5657110AF1; Mon, 23 Jun 2008 19:14:42 -0400 (EDT)
In-Reply-To: <911589C97062424796D53B625CEC0025E46183@USCOBRMFA-SE-70.northamerica.cexp.com> (Patrick Higgins's message of "Mon, 23 Jun 2008 17:07:30 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2D21D474-417A-11DD-8E6D-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85952>

<Patrick.Higgins@cexp.com> writes:

> The irony is of course that I wanted 1.5.6 for the improved AIX support
> and the final release is completely broken on AIX!

Yeah, queued to 'maint' for 1.5.6.1.  Thanks
