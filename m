From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Extra metadata in the commit?
Date: Fri, 24 Apr 2009 16:06:52 -0700
Message-ID: <7vws998xdf.fsf@gitster.siamese.dyndns.org>
References: <d411cc4a0904241547p64c0af2bycae20cd4b26e43f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 01:08:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxUVW-0005EP-Lr
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 01:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754398AbZDXXHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 19:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbZDXXG7
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 19:06:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65452 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528AbZDXXG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 19:06:59 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 46A5EAD8DB;
	Fri, 24 Apr 2009 19:06:57 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 48243AD8DA; Fri,
 24 Apr 2009 19:06:53 -0400 (EDT)
In-Reply-To: <d411cc4a0904241547p64c0af2bycae20cd4b26e43f6@mail.gmail.com>
 (Scott Chacon's message of "Fri, 24 Apr 2009 15:47:55 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9BF2EE20-3124-11DE-A038-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117510>

Scott Chacon <schacon@gmail.com> writes:

> I'm working on a hg<->git bidirectional tool using Git as the
> communication protocol, so there is a bunch of Hg metadata that I need
> to keep in Git to ensure I can convert commits created in Hg back into
> the exact same objects after they upload to the Git db and then come
> back down.  This means storing explicit rename info, branch names, etc
> somewhere without messing up Git clients that want to work on the same
> repo.  So, I can keep this data in the commit message, but I thought
> it would be cleaner to keep it as extra fields in the commit object
> before the "\n\n" separator.  Before I go too far down this road, is
> there anything horrible that might happen in any of the core Git tools
> if extra data is there?

Not that I know of but it is highly unlikely that such a patch will be
accepted, given the history of discussion around that area.
