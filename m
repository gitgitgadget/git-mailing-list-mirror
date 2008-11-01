From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] connect.c: add a way for git-daemon to pass an error
 back to client
Date: Sat, 01 Nov 2008 15:48:12 -0700
Message-ID: <7vej1v3vwz.fsf@gitster.siamese.dyndns.org>
References: <b97024a40810311859t2e5a6102u31ad4480e7c75c03@mail.gmail.com>
 <7vy7043sy9.fsf@gitster.siamese.dyndns.org>
 <b97024a40810312329o53e37fd5td82aa69634ff1e6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Tom Preston-Werner" <tom@github.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 23:49:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwPHn-00085d-K2
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 23:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbYKAWs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 18:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752248AbYKAWs2
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 18:48:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59245 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbYKAWs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 18:48:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B77A177AC2;
	Sat,  1 Nov 2008 18:48:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 79C1577ABF; Sat,  1 Nov 2008 18:48:21 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 32255762-A867-11DD-88B7-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99784>

"Tom Preston-Werner" <tom@github.com> writes:

> Explicitly testing for "ERR " (including the space) does seem like the
> more correct thing to do. Would you like me to resubmit a modified
> patch that uses prefixcmp()?

No need for resubmission to change something minor like that.  Will queue
with a fixup.

Thanks.
