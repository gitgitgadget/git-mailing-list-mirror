From: "Tom Clarke" <tom@u2i.com>
Subject: Re: [PATCH] Adding rebase merge strategy
Date: Mon, 1 Oct 2007 23:41:56 +0200
Message-ID: <550f9510710011441t1eb50352ofc8db77f79d794d5@mail.gmail.com>
References: <Pine.LNX.4.64.0709281751390.28395@racer.site>
	 <11912513203420-git-send-email-tom@u2i.com>
	 <7vr6ker1lf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 23:42:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcT1i-0007ad-UA
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 23:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325AbXJAVl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 17:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754129AbXJAVl6
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 17:41:58 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:11433 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754033AbXJAVl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 17:41:57 -0400
Received: by py-out-1112.google.com with SMTP id u77so7341280pyb
        for <git@vger.kernel.org>; Mon, 01 Oct 2007 14:41:56 -0700 (PDT)
Received: by 10.35.121.12 with SMTP id y12mr3000016pym.1191274916280;
        Mon, 01 Oct 2007 14:41:56 -0700 (PDT)
Received: by 10.35.86.2 with HTTP; Mon, 1 Oct 2007 14:41:56 -0700 (PDT)
In-Reply-To: <7vr6ker1lf.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59634>

On 10/1/07, Junio C Hamano <gitster@pobox.com> wrote:
> This would give a handier shortcut iff the rebase goes well, but
> the workflow after stopping would be entirely different from the
> normal "merge".  I am a bit worried about it giving confusion to
> the end users.

Thanks for the ample feedback, you raise a number of interesting
issues. I am wondering now if making rebase a merge strategy is really
a good idea. Rebasing is not merging, a difference that could perhaps
be overlooked in the no-conflict scenario, but as you point out, is
glaringly obvious as soon as you have conflicts.

I'm happy to try to address the issues you raised, but I wonder if we
would do better to look back at my original proposal which was to add
a --rebase option to git-pull. git-pull is the main place there I see
need for using a rebase instead of a merge, as anywhere where you
might use git-merge directly, if what you really want is a rebase, you
can just run git-rebase.

-Tom
