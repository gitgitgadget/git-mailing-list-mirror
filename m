From: Junio C Hamano <gitster@pobox.com>
Subject: GIT 1.6.3-rc2 is out but...
Date: Sat, 25 Apr 2009 09:29:13 -0700
Message-ID: <7vmya4zoh2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 25 18:31:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxkmJ-0003Wl-CD
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 18:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754375AbZDYQ3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 12:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754292AbZDYQ3Y
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 12:29:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36943 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753002AbZDYQ3X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 12:29:23 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BD324ADCA6;
	Sat, 25 Apr 2009 12:29:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F3035ADCA5; Sat,
 25 Apr 2009 12:29:20 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3BF64AA2-31B6-11DE-8AAB-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117560>

As a quick reminder, I tagged 1.6.3-rc2 and pushed it out last night, but
I forgot to apply a handful of patches I already had in my "ready to be
tested and queued" mailbox before doing so, so 1.6.3-rc3 will likely to
follow it before the next week begins.

Currently I have these tentatively queued on top of 1.6.3-rc2:

    Add an option not to use link(src, dest) && unlink(src) when that is unreliable
    connect: replace inet_ntop with getnameinfo
    Documentation: git-clean: make description more readable
    Documentation: git-clean: fix minor grammatical errors
    Remove obsolete bug warning in man git-update-server-info
    t7700-repack: repack -a now works properly, expect success from test
    t9001: use older Getopt::Long boolean prefix '--no' rather than '--no-'
    progress bar: round to the nearest instead of truncating down
