From: "J. Bakshi" <joydeep@infoservices.in>
Subject: Re: How to provide authentication along with git command itself ?
Date: Thu, 14 Jul 2011 16:31:49 +0530
Message-ID: <20110714163149.63bad937@shiva.selfip.org>
References: <20110714161508.2378c155@shiva.selfip.org>
	<CAH3AnrqR=xMa6KYWBmybXdudo8C8FoeioCs2PgOVZezAE5BWiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 14 13:01:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhJfz-0005uV-HW
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 13:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429Ab1GNLBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 07:01:46 -0400
Received: from static.206.87.46.78.clients.your-server.de ([78.46.87.206]:33049
	"EHLO Kolkata.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754371Ab1GNLBq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2011 07:01:46 -0400
Received: from shiva.selfip.org (unknown [122.176.30.116])
	by Kolkata.infoservices.in (Postfix) with ESMTPSA id A27572004002;
	Thu, 14 Jul 2011 13:01:43 +0200 (CEST)
In-Reply-To: <CAH3AnrqR=xMa6KYWBmybXdudo8C8FoeioCs2PgOVZezAE5BWiw@mail.gmail.com>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177115>

On Thu, 14 Jul 2011 20:53:42 +1000
Jon Seymour <jon.seymour@gmail.com> wrote:

> On Thu, Jul 14, 2011 at 8:45 PM, J. Bakshi <joydeep@infoservices.in> wrote:
> > Hello list,
> >
> > During git push or fetch over http , I need to provide username and password every time, as protected by apache htpasswd file. How can I provide the same along with git command ? Or something so that It save the authentication info somewhere within .git
> >
> > Thanks
> 
> You probably want to create the client setup section of this:
> 
>     http://kernel.org/pub/software/scm/git/docs/howto/setup-git-server-over-http.txt
> 
> Personally, I prefer to use an ssh hosted repository in such cases,
> then use an ssh-agent to cache an SSH private key.
> 
> jon.

Well, I am using version 1.7, hence not DAV but using git-http-backend 
