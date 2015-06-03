From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: Stash Feature
Date: Wed, 3 Jun 2015 18:53:58 +0300
Message-ID: <20150603185358.a30d606cc0c475cb17a048c7@domain007.com>
References: <CAGmnFohE3ihA8T8srk1BpXg5z80tnjyUhdjFieXGYm=T0gkMUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Fabrizio Mancin <fabman08@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 17:54:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0B06-0002zc-Nr
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 17:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755814AbbFCPyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 11:54:35 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:60268 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755568AbbFCPyF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 11:54:05 -0400
Received: from tigra.domain007.com ([192.168.2.102])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id t53Frwof014823;
	Wed, 3 Jun 2015 18:53:59 +0300
In-Reply-To: <CAGmnFohE3ihA8T8srk1BpXg5z80tnjyUhdjFieXGYm=T0gkMUA@mail.gmail.com>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270691>

On Wed, 3 Jun 2015 17:22:57 +0200
Fabrizio Mancin <fabman08@gmail.com> wrote:

> I've a little request for you.
> What about saving date-time on git stash save command and show it on
> git stash show stash@{xxx}?
> I think it is a useful poperty to save.
> 
> What do you think about it?

This information is already there as a stash entry is internally
represented as a commit (with one or more parents), and being a commit,
it possess all the standard attributes of a commit, including the
creation timestamp.

To get "normal" view of this commit just run

  git show stash@{0}
