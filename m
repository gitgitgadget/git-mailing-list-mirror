From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Documentation: git-clean: description updates
Date: Sat, 25 Apr 2009 17:10:23 -0700
Message-ID: <7vhc0cxok0.fsf@gitster.siamese.dyndns.org>
References: <1240672421-10309-1-git-send-email-wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Sun Apr 26 02:12:38 2009
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lxrz3-0007qf-Iv
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 02:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120AbZDZAKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 20:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752944AbZDZAKa
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 20:10:30 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44367 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454AbZDZAK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 20:10:29 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 03358106C9;
	Sat, 25 Apr 2009 20:10:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 599D8106C8; Sat,
 25 Apr 2009 20:10:25 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A5BCB5B2-31F6-11DE-A1F9-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117577>

"Wesley J. Landaker" <wjl@icecavern.net> writes:

> I stumbled over the git-clean documentation when I was first learning
> git, and ran into this again when a colleage was asking for help. So
> here are two fixes.
>
> The first patch fixes some minor grammatical errors in very
> non-intrusive manner. This should be completely uncontroversial.
>
> The second patch rewrites the first paragraph in the description
> section to make it more readable and friendly. I think this change
> is a very good one, but I split it into a separate patch since it is
> a more intrusive change.

Thanks, will queue for 1.6.3, as I think both are clearly improvements.

One could argue that the second one could be further improved, but I do
not see anything controversial in it.

    This allows cleaning the working tree by removing files that are not
    under version control.

    Normally, only files unknown to git are removed, but if the '-x'
    option is specified, ignored files are also removed. This can, for
    example, be useful to remove all build products.

The only iffy point I can see is that "unknown" is a bit fuzzy phrase in
this context.  I know what you mean, but you are not writing for people
who know what "git clean" does ;-)

In the above, "unknown" refers to a set of files that is a strict subset
of "untracked" files, excluding the "ignored" set.  But that is not
defined anywhere in the glossary.

Sometimes we colloquially say "files _known_ to git" to refer to "tracked"
files (paths that appear in the index).  But your "files _unknown_ to git"
is different from the complement of it.

The saddest part is that "untracked files" is not defined in the glossary
either.

    Normally, the command removes files that are not in the index, but
    ignored (see linkgit:gitignore[5]) files are kept.  With the '-x'
    option, the command removes the ignored files as well.
