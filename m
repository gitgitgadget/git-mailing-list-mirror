From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] git-svn: remove --first-parent, add --upstream
Date: Fri, 7 Sep 2007 02:23:58 +0200
Message-ID: <8c5c35580709061723m7e01c9d4p1b1936dc1d590459@mail.gmail.com>
References: <20070906075104.GA10192@hand.yhbt.net>
	 <1189096669534-git-send-email-hjemli@gmail.com>
	 <20070906210155.GA20938@soma> <20070906213556.GA21234@soma>
	 <8c5c35580709061514n1de6f141v5e596074cfa9fb42@mail.gmail.com>
	 <20070906235516.GC4538@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Eric Wong" <normalperson@yhbt.net>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Peter Baumann" <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 07 02:24:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITRdk-0004lX-TA
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 02:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbXIGAYA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 20:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932680AbXIGAYA
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 20:24:00 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:34643 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932674AbXIGAX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 20:23:59 -0400
Received: by wa-out-1112.google.com with SMTP id v27so355884wah
        for <git@vger.kernel.org>; Thu, 06 Sep 2007 17:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ghLMsxHnI4aChsB06gBSx2zB/kJQUU7f8zpi88ut0IM=;
        b=cj5Xk716NeydN7S20AHdb6AEudgI36kAVYCwsou2BSI9eZ0mnP4IpjIqlOPNqwfcLENEOWSzigO3vDFkrR6P0qSYhvZMgh3DWZQ32gvMf1U05mpYqERmBLWJnALbnahVoywyE5Yyug8bum09YK5shFI4nHx83Zdjhs0WYeIER/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FCxGVLHcU2JgXxEEzRi3cTRR05raYaDp6P8Pw3dizjvfFLokhnYAoB51JjJJFt+5HmSPvERXOgOP81eJgKSXqa1BuwjYo2lrHLpNW4186qqliiByZYbUIiq2pJIrjtks7hcX2RNVn6TyWV/ze5T+o8W4O/8AbhFbTIZKT+27nmk=
Received: by 10.114.56.1 with SMTP id e1mr696970waa.1189124638404;
        Thu, 06 Sep 2007 17:23:58 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Thu, 6 Sep 2007 17:23:58 -0700 (PDT)
In-Reply-To: <20070906235516.GC4538@xp.machine.xx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57954>

On 9/7/07, Peter Baumann <waste.manager@gmx.de> wrote:
> Wouldn't it be much more pleasant to say something like
>
>         git-svn dcommit --on the_branch
>
> whereas 'the_branch' is the name of the upstream branch as specified
> in the fetch/branch section in the git config?

Well, git-svn extracts the svn url, revision and repo uuid from the
commit message, while your proposal only specifies the url. But I'm
still not certain that there is a need for --upstream or anything
similar if git-svn always uses 'git log --first-parent' (see
http://article.gmane.org/gmane.comp.version-control.git/57951).

--
larsh
