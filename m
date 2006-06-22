From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Thu, 22 Jun 2006 07:47:27 -0700
Message-ID: <20060622144725.GB3154@h4x0r5.com>
References: <e79921$u0e$1@sea.gmane.org> <46a038f90606201233p6283febbn9a46e36c3a666903@mail.gmail.com> <20060621130535.G2b34d382@leonov.stosberg.net> <e7bhlf$5j2$1@sea.gmane.org> <20060622100024.G7f491d4a@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 16:47:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtQTA-000504-Sz
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 16:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161156AbWFVOrm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 10:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWFVOrm
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 10:47:42 -0400
Received: from h4x0r5.com ([70.85.31.202]:49161 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S1751113AbWFVOrl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 10:47:41 -0400
Received: from ryan by h4x0r5.com with local (Exim 4.50)
	id 1FtQSt-0006un-Bt; Thu, 22 Jun 2006 07:47:27 -0700
To: Dennis Stosberg <dennis@stosberg.net>
Content-Disposition: inline
In-Reply-To: <20060622100024.G7f491d4a@leonov.stosberg.net>
User-Agent: Mutt/1.5.9i
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@h4x0r5.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22344>

On Thu, Jun 22, 2006 at 12:00:25PM +0200, Dennis Stosberg wrote:
> Jakub Narebski wrote:
> 
> > So now you have extra git redirector being spawned, instead of extra shell
> > being spawned. 
> 
> Most of the commands that Gitweb uses are built-ins, so there
> shouldn't be any extra overhead by calling "git command" instead of
> "git-command".  If I haven't missed one, git-annotate is the only one
> which is not a built-in.

git-annotate is a Perl script anyway, so it's not unreasonable to
consider making it a .pm module and just using it directly in gitweb.


-- 

Ryan Anderson
  sometimes Pug Majere
