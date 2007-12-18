From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-stash: RFC: Adopt the default behavior to other commands
Date: Wed, 19 Dec 2007 12:41:24 +1300
Message-ID: <46a038f90712181541x781c3ebcq6d85b88dbf5cbe23@mail.gmail.com>
References: <20071217110322.GH14889@albany.tokkee.org>
	 <506C6191-655D-46AE-A5C2-1335A9044F44@lrde.epita.fr>
	 <7vk5nd53lp.fsf@gitster.siamese.dyndns.org>
	 <57F403E7-AF5B-40F1-AE9D-8EA036675A67@lrde.epita.fr>
	 <7vfxy04ze7.fsf@gitster.siamese.dyndns.org>
	 <20071218154211.GB12549@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?J=F6rg_Sommer?=" <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Wed Dec 19 00:41:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4m4L-0005YM-6O
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 00:41:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754381AbXLRXl0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Dec 2007 18:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754270AbXLRXl0
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 18:41:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:48557 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753880AbXLRXlZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Dec 2007 18:41:25 -0500
Received: by ug-out-1314.google.com with SMTP id z38so206822ugc.16
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 15:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=XifJC8ydN/hO6gZVZimUFP8esu7Kk6b/zrFC0+FKuRk=;
        b=YCX9Q5MnYQ1RXpucVYmzMyQYNTORvzyr6NMVz7mJJCyqRxrHUzTdGroAYw+qPjzuq8HxhNa6bTjslZ3NaCoTJ8sJNRgrkFWiZK5bcOU5Xq1OCZBi+lqZPDIrGnfFeBqOCQX0gz0h0AenKvAnmeQWPF/3NrOeYd38Ra3/0qa1E9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KRWWp6+QH2ULKQdWnJs5r911DCm5lk9JIbEhhXv7YjBKGjwmjyQONxFPjDngVyAY01ui0zLQwLpMKRi7cc9KQ+5MyDnSUEz+U7z7PPzVZhs/ptvKUwjV92AKmOnj7GaFNkqfeLqt2l8+sqNvi0BCZfjWW4bBtJ7f0AMwLj6v54I=
Received: by 10.67.116.2 with SMTP id t2mr1450721ugm.62.1198021284372;
        Tue, 18 Dec 2007 15:41:24 -0800 (PST)
Received: by 10.66.252.2 with HTTP; Tue, 18 Dec 2007 15:41:24 -0800 (PST)
In-Reply-To: <20071218154211.GB12549@alea.gnuu.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68849>

On Dec 19, 2007 4:42 AM, J=F6rg Sommer <joerg@alea.gnuu.de> wrote:
> I vote for stash print the list, because I dropped in the pitfall.

I've dropped there myself, and work with a large team where we are
both fans of stash, and scarred by it. Any newcomer to git that
"discovers" stash gets hit by it a dozen times, this is completely
unnecesary.

All state-changing commands need parameters or are interactive (as
it's the case with git-commit). That Johannes & early adopters,
including me, have gotten used to the unintuitive (and dangerously
surprising) behaviour of stash is no excuse to inflict it upon actual
end users. It's way too early for git and the stash command to stick
to a misfeature in the name of backwards compat. We'll adapt, as we
have in the past, to an evolving ui.

And if -- in a new repo -- the list is empty, we can just say so:
Nothing has been stashed yet. Which looks completely different from a
successful stash 'save' command.

cheers,


m
