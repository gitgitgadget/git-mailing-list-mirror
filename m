From: "J. Bakshi" <joydeep@infoservices.in>
Subject: Re: pre-commit not working at server side push
Date: Wed, 20 Jul 2011 12:51:24 +0530
Message-ID: <20110720125124.3c746a1a@shiva.selfip.org>
References: <20110720121356.4dc21f6b@shiva.selfip.org>
	<20110720071807.GA10104@LK-Perkele-VI.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Jul 20 09:21:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjR63-0001EZ-Jg
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 09:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993Ab1GTHV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 03:21:26 -0400
Received: from static.206.87.46.78.clients.your-server.de ([78.46.87.206]:35984
	"EHLO Kolkata.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750777Ab1GTHVZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2011 03:21:25 -0400
Received: from shiva.selfip.org (unknown [122.176.30.116])
	by Kolkata.infoservices.in (Postfix) with ESMTPSA id 71A721808001;
	Wed, 20 Jul 2011 09:21:21 +0200 (CEST)
In-Reply-To: <20110720071807.GA10104@LK-Perkele-VI.localdomain>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177523>

On Wed, 20 Jul 2011 10:18:07 +0300
Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:

> On Wed, Jul 20, 2011 at 12:13:56PM +0530, J. Bakshi wrote:
> > Hello list,
> > 
> > I have this bash script to check php syntax error and prevent the commit if there is any
>  
> <snip>
>  
> > Running fine when placed it at local copy.
> > 
> > I have placed the hook at the server under hooks directory and provided the execute permission also
> > 
> > $ chmod a+x hooks/pre-commit
> > 
> > But even with wrong php syntax I am able to push the file. Have I missed something ?
> 
> Pre-commit runs on commit, not on push. And push is not commit.
> 
> -Ilari

Thanks, already figured it out, it would be pre-receive on server; but still not working.
