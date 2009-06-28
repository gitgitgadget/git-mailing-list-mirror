From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: What's cooking in git.git (Jun 2009, #03; Sat, 27)
Date: Sun, 28 Jun 2009 15:50:38 +0200
Message-ID: <200906281550.39051.chriscool@tuxfamily.org>
References: <7vy6rcg7hc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 28 15:50:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKum5-0007Rn-Lu
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 15:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbZF1NuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2009 09:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752665AbZF1NuU
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 09:50:20 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:53459 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751509AbZF1NuT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2009 09:50:19 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 3222E818139;
	Sun, 28 Jun 2009 15:50:15 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 48E1B81815F;
	Sun, 28 Jun 2009 15:50:13 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vy6rcg7hc.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122404>

On Sunday 28 June 2009, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with '-'
> are only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
> marked with '.' do not appear in any of the branches, but I am still
> holding onto them.

Is there a reason why the following patches have been removed from pu:

commit 6dcab5fbeb56a8fdd908d54ae7154308bfa5f74b
Author: Christian Couder <chriscool@tuxfamily.org>
Date:   Sun Jun 21 07:08:45 2009 +0200

    rebase -i: use config file format to save author information

    This is better than saving in a shell script, because it will make
    it much easier to port "rebase -i" to C. This also removes some sed
    regexps and some "eval"s.

    Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

commit aac0a09aedae9dc3ca0e2c0bb5ad5f3918a821a5
Author: Christian Couder <chriscool@tuxfamily.org>
Date:   Sun Jun 21 07:08:44 2009 +0200

    rebase -i: remove get_author_ident_from_commit() from "git-sh-setup.sh"

    The "get_author_ident_from_commit" function is only used in
    "git-rebase--interactive.sh" so there is no need for this function
    to be in "git-sh-setup.sh" anymore.

    Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks,
Christian.
