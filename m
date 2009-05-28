From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Strangely hosed git install
Date: Thu, 28 May 2009 00:18:59 -0700
Message-ID: <7vprdthezg.fsf@alter.siamese.dyndns.org>
References: <46a038f90905280008h5510d03aj5f6e5728ca075027@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 28 09:19:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9ZtU-0003rd-M1
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 09:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbZE1HS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 03:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbZE1HS7
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 03:18:59 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:53232 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbZE1HS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 03:18:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090528071900.ROMN20430.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 28 May 2009 03:19:00 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id wvJz1b0064aMwMQ03vJzYW; Thu, 28 May 2009 03:18:59 -0400
X-Authority-Analysis: v=1.0 c=1 a=pGLkceISAAAA:8 a=q1zwPN8vigqRsMbIVg8A:9
 a=LdJz4GX4YmXiyPO7Ae4tGX1RBFMA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <46a038f90905280008h5510d03aj5f6e5728ca075027@mail.gmail.com> (Martin Langhoff's message of "Thu\, 28 May 2009 09\:08\:58 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120162>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> My main laptop (and part-time dev box) has a partially hosed git
> installation. This is an ubuntu intrepid machine where I have been
> building git from src for a while. Perhaps there's a way to diagnose
> this before I take more drastic measures :-)
>
> So far gc, repack and stash show errors. No dataloss AFAICS (though
> the git stash errors scared me initially).
>
> gc and repack error out thus:
>
> $ git gc
> usage: git-pack-objects [{ -q | --progress | --all-progress }]
>         [--max-pack-size=N] [--local] [--incremental]
>         [--window=N] [--window-memory=N] [--depth=N]
>         [--no-reuse-delta] [--no-reuse-object] [--delta-base-offset]
>         [--threads=N] [--non-empty] [--revs [--unpacked | --all]*] [--reflog]
>         [--stdout | base-name] [--keep-unreachable] [<ref-list | <object-list]
> error: failed to run repack
> $ echo $?
> 255

"type --all git"?
"git --exec-path"?
"ls $(git --exec-path)"?
