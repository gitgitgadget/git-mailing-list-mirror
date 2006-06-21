From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Wed, 21 Jun 2006 09:45:12 -0700
Message-ID: <20060621164503.GA1285@h4x0r5.com>
References: <e79921$u0e$1@sea.gmane.org> <46a038f90606201233p6283febbn9a46e36c3a666903@mail.gmail.com> <20060621130535.G2b34d382@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 21 18:46:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ft5pp-0003cy-Fh
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 18:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWFUQpg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 12:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWFUQpg
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 12:45:36 -0400
Received: from h4x0r5.com ([70.85.31.202]:40197 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S932254AbWFUQpf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jun 2006 12:45:35 -0400
Received: from ryan by h4x0r5.com with local (Exim 4.50)
	id 1Ft5pJ-0000aI-GC; Wed, 21 Jun 2006 09:45:14 -0700
To: Dennis Stosberg <dennis@stosberg.net>
Content-Disposition: inline
In-Reply-To: <20060621130535.G2b34d382@leonov.stosberg.net>
User-Agent: Mutt/1.5.9i
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@h4x0r5.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22281>

On Wed, Jun 21, 2006 at 03:05:35PM +0200, Dennis Stosberg wrote:
> (2) Setting %ENV has no effect on spawned processes under mod_perl,
>     so the git commands would never find the project directories.
>     My first thought was to set $GIT_DIR on the commands' command
>     lines like in open($fh, '$GIT_DIR=blah git-rev-list ...') but it
>     would lead to an extra shell being spawned on every invocation
>     of a git command.


I haven't looked at gitweb much, but why can't you solve this by doing
manual pipe,fork,exec combinations?  That should give you complete
control over the environment, right?

(IIRC, the last time I played with mod_perl and spawning processes, I
recall it doing something very confusing with the pipes I had open.)


-- 

Ryan Anderson
  sometimes Pug Majere
