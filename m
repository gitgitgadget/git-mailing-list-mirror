From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Find successor of common ancestor
Date: Fri, 16 Jul 2010 10:49:45 +0200
Message-ID: <AANLkTintIToGZu3fvK4aE5LFL7MgOnlfwKgsZ79Q0-o1@mail.gmail.com>
References: <20100716082937.GA22894@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: weigelt@metux.de
X-From: git-owner@vger.kernel.org Fri Jul 16 10:50:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZgcd-000291-C1
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 10:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936024Ab0GPIuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jul 2010 04:50:13 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61154 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936021Ab0GPIuG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jul 2010 04:50:06 -0400
Received: by fxm14 with SMTP id 14so897334fxm.19
        for <git@vger.kernel.org>; Fri, 16 Jul 2010 01:50:05 -0700 (PDT)
Received: by 10.103.182.8 with SMTP id j8mr48297mup.103.1279270205171; Fri, 16 
	Jul 2010 01:50:05 -0700 (PDT)
Received: by 10.102.228.2 with HTTP; Fri, 16 Jul 2010 01:49:45 -0700 (PDT)
In-Reply-To: <20100716082937.GA22894@nibiru.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151133>

On Fri, Jul 16, 2010 at 10:29 AM, Enrico Weigelt <weigelt@metux.de> wrote:
>
> Hi folks,
>
>
> suppose the following situation:
>
> I've forked some branch A into B, now A and B have evolved
> independently for quite some time into A' and B'. Now I'd like
> to rebase B' along A' history line step by step - first on A+1,
> then A+3, ... until A' (that's what I'd call zip-rebase).

This is just what "git rebase"  does:

$ git checkout B'
$ git rebase A'

HTH,
Santi
