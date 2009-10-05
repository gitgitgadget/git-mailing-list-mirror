From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when 
	appropriate to do so
Date: Mon, 5 Oct 2009 17:57:19 -0400
Message-ID: <76718490910051457l2b12bae6w148ed3b7716bf5fe@mail.gmail.com>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
	 <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
	 <fabb9a1e0910051426n7f4f8602l8fad733ac3ba82b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 23:59:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Muvag-0007RC-MB
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 23:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754892AbZJEV55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 17:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754827AbZJEV55
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 17:57:57 -0400
Received: from mail-iw0-f178.google.com ([209.85.223.178]:46091 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754761AbZJEV54 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 17:57:56 -0400
Received: by iwn8 with SMTP id 8so1952397iwn.33
        for <git@vger.kernel.org>; Mon, 05 Oct 2009 14:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=wiVJUsY4wbKPfq8jdXbl2THfZZiNCPVrJu5E4IaFHoY=;
        b=BPm17/zDIXqA7Q6ARkuCLgs9weoW2gx17f1+IUhTgOQ+TPZUHHLaWxGAYn19lPAMDF
         iaws4bzHl4WnV047D89w6vgFX6kf39jIcarR6Bxpo3n6zQaT7iwWTkt92rFo//bPBAiw
         cGGxNqjJEZX5qUPSzyKxEl6QE7NPWFFuxMXKg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=o6V1k0mxrIAQtmUzfHyfc+g6yiSXfu6QKu9eKz9NN2yiLyFCH6FAwJDwn/NZh2ksS5
         UY/04g7vYD+OxQrqcMQCmLczKmaTjsqDdh/1qCIHlzFamLLvoLi71uZkNvKIIzCCIxQt
         a0FV6qOGbTWUu0GofFBWcPvqgFheoGkHG9voo=
Received: by 10.231.1.22 with SMTP id 22mr875963ibd.56.1254779839373; Mon, 05 
	Oct 2009 14:57:19 -0700 (PDT)
In-Reply-To: <fabb9a1e0910051426n7f4f8602l8fad733ac3ba82b3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129597>

On Mon, Oct 5, 2009 at 5:26 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> @jay: you assume that if there is more than one matching remote the
> user is experienced (as they have multiple remotes) enough to know
> what to do?

That and it was just an RFC patch, so I just decided to ignore that
case initially.

j.
