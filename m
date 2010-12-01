From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] git-commit.txt: Order options alphabetically
Date: Thu, 02 Dec 2010 00:45:25 +0200
Organization: Private
Message-ID: <87mxopt8my.fsf@picasso.cante.net>
References: <1291215526-11428-1-git-send-email-jari.aalto@cante.net>
	<20101201165043.GF26120@burratino> <87r5e1v2g8.fsf@picasso.cante.net>
	<7vzkspuw8g.fsf@alter.siamese.dyndns.org>
	<295D1E95-1C61-4960-8C9C-BDB0BD4A1A50@sb.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 23:45:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNvQu-0006mS-Nf
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 23:45:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756067Ab0LAWpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 17:45:44 -0500
Received: from lo.gmane.org ([80.91.229.12]:34943 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752207Ab0LAWpn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 17:45:43 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PNvQj-0006ho-1s
	for git@vger.kernel.org; Wed, 01 Dec 2010 23:45:41 +0100
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 23:45:41 +0100
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 23:45:41 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.2 (gnu/linux)
Cancel-Lock: sha1:KILcBnjx+AW7MLfgDPXmQjzHktU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162628>

2010-12-01 23:58 Kevin Ballard <kevin@sb.org>:
> On Dec 1, 2010, at 11:30 AM, Junio C Hamano wrote:
>
>  Trying to make the manpage look "nice" at the expense of removing
> functional grouping is misguided.

Please explain where is the removed functionality in here:

GIT-COMMIT(1)                      Git Manual                     GIT-COMMIT(1)

OPTIONS
       -a, --all
           Tell the command to automatically stage files that have been
           modified and deleted, but new files you have not told git about are
           not affected.

       -C <commit>, --reuse-message=<commit>
           Take an existing commit object, and reuse the log message and the
           authorship information (including the timestamp) when creating the
           commit.

       -c <commit>, --reedit-message=<commit>
           Like -C, but with -c the editor is invoked, so that the user can
           further edit the commit message.

       --reset-author
           When used with -C/-c/--amend options, declare that the authorship of
           the resulting commit now belongs of the committer. This also renews
           the author timestamp.

What is the reason --reset-author is in that position? What
functionality is serves? There are loads of similar ones. I don't see
any group. Neither probably Joe Average.

To me the git-pages do not look that professional when options are
whereever. Take 10 manual pages side by side in terminals and the
options are chaos (try locating some option, say "-v", on every command
and try to figure if it serves same purpose in every command or not).

When the pages list options in alphabetical order, it doesn't take long
to compare commands: similarities and differences in options, or missing
options, or inconsistencies for that matter.

Jari
