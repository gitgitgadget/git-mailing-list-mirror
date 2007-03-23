From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: Errors pushing tags in "next"
Date: Fri, 23 Mar 2007 02:19:52 -0700 (PDT)
Message-ID: <803772.83961.qm@web31809.mail.mud.yahoo.com>
References: <20070323090213.GA7186@fiberbit.xs4all.nl>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Marco Roeland <marco.roeland@xs4all.nl>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 10:19:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUfwD-0005hR-2y
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 10:19:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbXCWJTy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 05:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934273AbXCWJTy
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 05:19:54 -0400
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:31619 "HELO
	web31809.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932570AbXCWJTx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Mar 2007 05:19:53 -0400
Received: (qmail 84547 invoked by uid 60001); 23 Mar 2007 09:19:52 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=4lRc1Vk3kjkefZUXEexRJv0cV0K5FNdHezV4kwr5vmHtLuHUf8/fbt+2urfGT1GpB7nX8kJcdlWIdebMx5wEtp+4n9cPUxopAd74th7I41tZMXBzI2P1wE6eFdE2dGfv2R0T6PvCvNiW29oGhOcQjb28Bh5MYkMlVG6FiQtKLAo=;
X-YMail-OSG: Gr.k8LsVM1nKodBOo5pWZl0ylKtUIAGKu5PtJaa8Q6VTusKXrKdqUoOv05w1NgaCzlq79OY9_ALl5Di59Jgp3ILNUExPSyfwZcR1glJH9vIlmx6ulMRrDKb_sZfcLLcMdF1AioAI4lxFqjFP2oXDhw--
Received: from [68.186.59.161] by web31809.mail.mud.yahoo.com via HTTP; Fri, 23 Mar 2007 02:19:52 PDT
In-Reply-To: <20070323090213.GA7186@fiberbit.xs4all.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42916>

--- Marco Roeland <marco.roeland@xs4all.nl> wrote:
> On Friday March 23rd 2007 at 01:16 Junio C Hamano wrote:
> 
> > Luben Tuikov <ltuikov@yahoo.com> writes:
> > 
> > > BTW, git has always said to me "Pushing version ... to the masses"
> > > whenever I'd do "git-push --tags web".
> > 
> > Sorry, I must be blind, and git-grep is too.
> > 
> > $ git grep -e 'to the masses' -e 'Pushing v'
> > 
> > returns absolutely empty.
> 
> The line comes from an older version of templates/hooks--update. The
> line was removed in commit 829a686f1b50ba96cac2d88494fa339efe0c0862 .
> 
> So Luben does seem to have a hook installed, perhaps this is the
> culprit.

I see.

I double checked and I do have "update" and "post-update" hooks
enabled.  I don't think that it is "post-update" and this leaves
"update" to be the problem (which is from an ancient git version
when the repo was created...).

I'll update the "update" hook from a recent git version and
will see if I get the same warning message.  Hopefully not.

Thanks,
   Luben
