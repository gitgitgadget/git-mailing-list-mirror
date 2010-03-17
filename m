From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git branch --current?
Date: Wed, 17 Mar 2010 11:14:44 -0400
Message-ID: <76718491003170814v71e31e91q994daee849da4caf@mail.gmail.com>
References: <fcaeb9bf1003170743kc347d53jefe41039e3b9a69a@mail.gmail.com>
	 <76718491003170748h349c5ed0u7649864cc824f549@mail.gmail.com>
	 <fcaeb9bf1003170804s4c9fdbb6id2c045bdb90f8c6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 16:14:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NruxV-0008Q3-1m
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 16:14:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868Ab0CQPOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 11:14:46 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54824 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab0CQPOp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 11:14:45 -0400
Received: by pva4 with SMTP id 4so556940pva.19
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 08:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=9w+9WtY+wg8AVPHLm+6lfoMy9UcHcfxRZp5h1BNLHZA=;
        b=t1C9gUxePKQ9DzMVcadIDEHcgyA7yElCLO/ZNtfuIlNLbQHyGIJHkD/AfDeK4lGDsH
         ISQS/lwbxIRsIIWQjX8F9dGOvLAaqorYcit96C6YgZS7aTFBd/UOrjtRWfIIcQatqf9Y
         j7l0mUOgkvriIvqXWnzsgZGObf7MVtLZWwJDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=DmnvLFIoPfekeBDxTIXGhwCpROiKkFpFY8aHhdojGlqfJvvrxRFujZyr3flYhhlTy2
         /EbLHfryaNtwN/5KN6IQEzeLQpy3o2/QSJT2FU/aZGmIuN9wpvVHx0xkvyUkjRiKCUus
         lDkAipyRSQSj0/zQen7mpbqRknzlViiALEZYA=
Received: by 10.114.6.7 with SMTP id 7mr889540waf.90.1268838884648; Wed, 17 
	Mar 2010 08:14:44 -0700 (PDT)
In-Reply-To: <fcaeb9bf1003170804s4c9fdbb6id2c045bdb90f8c6f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142399>

On Wed, Mar 17, 2010 at 11:04 AM, Nguyen Thai Ngoc Duy
<pclouds@gmail.com> wrote:
> Hmm.. I have alias.pwb = symbolic-ref HEAD. Both solutions are not as
> good as "git branch", say detached HEAD case.

How about naming something like this git-pwb and copying it to
somewhere in PATH:

#!/bin/sh
. /opt/git/share/git-core/git-completion.bash
echo $(__git_ps1)


Perhaps you are inspired to contribute git-completion.csh?

:-)

j.
