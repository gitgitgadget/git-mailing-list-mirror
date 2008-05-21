From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: Re: two git-cherry-pick enhancements
Date: Wed, 21 May 2008 13:36:29 -0500
Message-ID: <5d46db230805211136k7bf81bc0t9610fe2bb50a08b9@mail.gmail.com>
References: <20080521163817.GA13124@denkbrett.schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Nico -telmich- Schottelius" <nico-git-20080521@schottelius.org>
X-From: git-owner@vger.kernel.org Wed May 21 20:37:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JytBm-0004GA-9x
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 20:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754719AbYEUSgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 14:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752424AbYEUSgd
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 14:36:33 -0400
Received: from ti-out-0910.google.com ([209.85.142.191]:25457 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbYEUSgc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 14:36:32 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1576092tic.23
        for <git@vger.kernel.org>; Wed, 21 May 2008 11:36:30 -0700 (PDT)
Received: by 10.151.145.17 with SMTP id x17mr693413ybn.20.1211394989145;
        Wed, 21 May 2008 11:36:29 -0700 (PDT)
Received: by 10.150.181.17 with HTTP; Wed, 21 May 2008 11:36:29 -0700 (PDT)
In-Reply-To: <20080521163817.GA13124@denkbrett.schottelius.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82563>

On Wed, May 21, 2008 at 11:38 AM, Nico -telmich- Schottelius
<nico-git-20080521@schottelius.org> wrote:
> Hello!
>
> When using git-cherry-pick there are two things missing for me and just
> wondered how you see it (or maybe have a good solution):
>
> - Apply only parts of the patch which applies to <file ...>:
>   I sometimes want to apply patches only to some, but not all
>   files the patch introduces
>
> - Interactively selecting which parts to apply:
>   I want only 7 out of 10 changes the patch introduces.
>   It would help alot, if I could choose which parts I want
>   to apply for every part of the patch.
>
> Anything planned like that or did I oversee the right way?
>
> Sincerly
>
> Nico
>
> P.S.: Please CC me on reply, I am not subscribed.
>

You could "git cherry-pick --no-commit <id>" and then "git add -p"

-Govind
