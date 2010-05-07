From: Eli Barzilay <eli@barzilay.org>
Subject: Re: git log -M -- filename is not working?
Date: Fri, 7 May 2010 14:37:09 -0400
Message-ID: <19428.24021.324557.517627@winooski.ccs.neu.edu>
References: <z2w76c5b8581005071107w79d30963g725269febe746f0@mail.gmail.com>
	<h2m8c9a061005071110nf7e63220ked03598bfa66fbc9@mail.gmail.com>
	<z2r76c5b8581005071131q15524cb8td6711dbb9142b28e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 20:42:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OASVD-0001kd-Q6
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 20:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756870Ab0EGShM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 14:37:12 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:42768 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751099Ab0EGShL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 14:37:11 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1OASQ9-0002Wc-Ay; Fri, 07 May 2010 14:37:09 -0400
In-Reply-To: <z2r76c5b8581005071131q15524cb8td6711dbb9142b28e@mail.gmail.com>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146551>

On May  7, Eugene Sajine wrote:
> On Fri, May 7, 2010 at 2:10 PM, Jacob Helwig <jacob.helwig@gmail.com> wrote:
> > You want the --follow flag, too.
> 
> Thanks! I missed this guy. By the way it seems that --follow flag
> works without -M or -C.
> 
> Are those deprecated or I'm missing the difference between three of
> them??

BTW, I've had at least 4 people now who got confused by this.  Is
there any use for -M/-C without --follow?  In any case, it will be
very helpful if the -M/-C descriptions said "see also --follow".

Also, is there a way to set this as the default for `git log'?

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
