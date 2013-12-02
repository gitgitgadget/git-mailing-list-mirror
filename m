From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] gitk: chmod +x po2msg
Date: Mon, 02 Dec 2013 11:12:43 -0800
Message-ID: <xmqqsiubqd78.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Dec 02 22:21:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnavv-0005vl-Ja
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 22:21:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759605Ab3LBVTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 16:19:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56615 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753585Ab3LBTMr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 14:12:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48A0E558B6;
	Mon,  2 Dec 2013 14:12:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=2
	/Yiu7ooQ8ARD94BSjN7YLJkHFA=; b=jjcYe9R6rIo45Go/zvAnql75yXMJ0V2XU
	Pk2QVn+9UwQ3Xebo3MKlkNmvVL1LRrWkGLEID8XIJvF9hD7FXsWk5IkTJMQYxwzx
	GuZ2ew01N0lBALMKN18bYgGm+ODUwB7aOrRNbZ/8cw05U/XU9XpeYkgXu63FMbzj
	jnlbqQZ6j4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=OtXc9dWWpbi8ppqyZNi+v4LgLDgmBnIrNl4mqH/Jm1PgPA1l84UNUbvT
	OfyQuR4/ummYNqbD/iWs0xN5yTbAPMgqOffQWMsx51hqlBITP8THxDikJ6kh0ANa
	UwZW3XTGRdfKYPd9bjTlMPNrQ4QN/Jh1Pe+0EGV2GCT2cAy5hCY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 376B0558B3;
	Mon,  2 Dec 2013 14:12:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7ACE4558B2;
	Mon,  2 Dec 2013 14:12:45 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B9ACC036-5B85-11E3-8FD2-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238655>

From: Jonathan Nieder <jrnieder@gmail.com>
Date: Mon, 25 Nov 2013 13:00:10 -0800

The Makefile only runs it using tclsh, but because the fallback po2msg
script has the usual tcl preamble starting with #!/bin/sh it can also
be run directly.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Paul, I forgot to forward this to you.  Could you apply it to
   your tree?  I see you have updates up to ce2c58cd (gitk:
   Recognize -L option, 2013-11-16), which I'll be pulling into my
   tree shortly.

   Thanks.

 po/po2msg.sh | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 po/po2msg.sh

diff --git a/po/po2msg.sh b/po/po2msg.sh
old mode 100644
new mode 100755
-- 
1.8.5-386-gb78cb96
