From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Adding a commit message to the index
Date: Sun, 19 Sep 2010 12:19:59 +0000
Message-ID: <AANLkTinbgTx=ihy82zPRvsv-WvdeEPt0fX+arCQaKnUr@mail.gmail.com>
References: <3347.4c955dd6.4a79e@getafix.xdna.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Cameron Hutchison <lists@xdna.net>
X-From: git-owner@vger.kernel.org Sun Sep 19 14:20:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxIsJ-00082B-Nx
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 14:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845Ab0ISMUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Sep 2010 08:20:00 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41152 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163Ab0ISMT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 08:19:59 -0400
Received: by iwn5 with SMTP id 5so3394168iwn.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 05:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=5qZ/nMGXlkYyWleqgdBoXvq5NedvnFvIVqU5vh0fq1s=;
        b=E03/WVo1etny+mxW0zPv33C7slgmelPFVa6NrrTanDr4JEEin3UJiicoTcQJl6lrKL
         MKClemBQfPZR5ghMWkWTG3F2P9nJkbCZX7giCR67rOaB1GHxpdyg2ZOASbSg+ZLtbLbs
         XTyydTWWesJFes5KVMWDfQewE1gfj6cc8iOpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=pRaVjjHLMtol+xGiSkXd6flbA7shSDgg20QkREMBhw3Mnk4CfFff7D+GMkO8jjxEgQ
         QRrPnA5R+QqOIu/uH97R1yMBqkylG+ZGypTn0wCjZdoer9np5c3Gfd6mjHAi4HJaIMyo
         gp8llx24iSklQ6WyJ7ZtNjOasB76EZPmPhqzk=
Received: by 10.231.172.70 with SMTP id k6mr8351169ibz.125.1284898799316; Sun,
 19 Sep 2010 05:19:59 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sun, 19 Sep 2010 05:19:59 -0700 (PDT)
In-Reply-To: <3347.4c955dd6.4a79e@getafix.xdna.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156493>

On Sun, Sep 19, 2010 at 00:48, Cameron Hutchison <lists@xdna.net> wrote:
> Is it possible to add a commit message to the index, and have it used as
> the final commit message, or as the template for the final commit
> message?

What Joshua suggests is better, but you can abuse git-commit by
writing a commit message to e.g. .git/MERGE_MSG, then the message will
be used at the next 'git commit'.

But just commiting /now/ and squashing/rebasing later is a much better
workflow.
