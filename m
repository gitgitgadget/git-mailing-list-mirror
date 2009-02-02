From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] Add find_insert_index, insert_at_index and
 clear_func functions to string_list
Date: Sun, 01 Feb 2009 19:03:39 -0800
Message-ID: <7viqnto7zo.fsf@gitster.siamese.dyndns.org>
References: <cover.1233520945.git.marius@trolltech.com>
 <ce94ea88e3182e97997c23f71e184e0db64fa708.1233520945.git.marius@trolltech.com> <75a7d437c1b32600c509bdef5010e6ac30b6cb08.1233520945.git.marius@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 04:05:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTp7Y-0007Eh-VC
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 04:05:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753917AbZBBDDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 22:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753867AbZBBDDr
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 22:03:47 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61887 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753758AbZBBDDr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 22:03:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A8C9F940AD;
	Sun,  1 Feb 2009 22:03:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A3CE3940AC; Sun,
  1 Feb 2009 22:03:41 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1A54A8EC-F0D6-11DD-8908-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108037>

Marius Storm-Olsen <marius@trolltech.com> writes:

> string_list_find_insert_index() and string_list_insert_at_index() enables you to see if an item is in the string_list, and to insert at the appropriate index in the list, if not there.
> This is usefull if you need to manipulate an existing item, if present, and insert a new item if not.
>
> Future mailmap code will use this construct to enable complex (old_name, old_email) -> (new_name, new_email) lookups.
>
> The string_list_clear_func() allows to call a custom cleanup function on each item in a string_list, which is useful is the util member points to a complex structure.

What's with these overlong lines?  You do not have them in your other
patches.
