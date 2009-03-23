From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merge format documented?
Date: Sun, 22 Mar 2009 20:50:24 -0700
Message-ID: <7vtz5k99tr.fsf@gitster.siamese.dyndns.org>
References: <200903230419.50000.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Mon Mar 23 04:52:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlbCn-0001fB-ND
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 04:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755142AbZCWDug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 23:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755088AbZCWDug
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 23:50:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51424 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754223AbZCWDuf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 23:50:35 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BEECCA49D7;
	Sun, 22 Mar 2009 23:50:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D6D52A49D5; Sun,
 22 Mar 2009 23:50:26 -0400 (EDT)
In-Reply-To: <200903230419.50000.agruen@suse.de> (Andreas Gruenbacher's
 message of "Mon, 23 Mar 2009 04:19:49 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C08D7CB8-175D-11DE-A62A-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114241>

Andreas Gruenbacher <agruen@suse.de> writes:

> is the format that git normally uses for indicating merge conflicts in files 
> (the <<< === >>> markers) documented somewhere?  How exactly does it differ 
> from the diff3 format (<<< ||| === >>>)?  Diff3's -m mode seems to come close 
> to what git does, except that git doesn't produce the ||| section:

It is an imitation of output from "merge" program of RCS suite Paul you
know maintains ;-)  Recent versions of git supports merge.conflictstyle
configuration variable and --conflict option in 'git-checkout' to write
the conflicts out in a format that is an imitation of "diff3 -m" output.

As far as I know, neither "git" format is documented anywhere, but I
didn't find an official format specification of the "upstream" formats,
and that is why I keep saying "imitation" in the above paragraph ;-)
