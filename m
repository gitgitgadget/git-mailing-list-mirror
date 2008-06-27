From: "Robert Anderson" <rwa000@gmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Fri, 27 Jun 2008 15:55:03 -0700
Message-ID: <9af502e50806271555j3cd06ecau122b11217f612217@mail.gmail.com>
References: <g43jlg$54g$1@ger.gmane.org> <-8386235276716376372@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "David Jeske" <jeske@willowmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 00:56:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCMrP-0004uF-SP
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 00:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760701AbYF0WzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 18:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761000AbYF0WzJ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 18:55:09 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:41112 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760505AbYF0WzI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 18:55:08 -0400
Received: by fg-out-1718.google.com with SMTP id 19so336782fgg.17
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 15:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=OAMhtwy11fBDDj8i1VjsRdyQVnk3p5cLSIGFCEzEm5Q=;
        b=f5AQvkyJEPWqeXSQzHa39Yesnv/ex2gCTbCne15WauIGqh1iaO+w4T9Rik7JVP+5Vl
         G6r2Z62lB2L36kkrGF4n+/KSxMckWFxpoxBpcx0o4pZQlg+E5JSs9OG6gvSjtBlFtJqM
         G37z+KJ4nmP0O1KKo+eL/Fh5iNmi1FUQHgzOE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=uUjV1pj4HYmeBu/s9n8MnXiweoyJntfZMACpQewlDHHnYOuulDj194W0T0E0A+siWQ
         uxNOkkGthsmphA1wDxs+GOj0yzNPqhq5x2jmQNQSYJVkRB1cjwmhvBVhoGfJqH6srCND
         A3nCC+qh/L907cXv/ikLWyYACXH2k7wFY0fiw=
Received: by 10.86.89.1 with SMTP id m1mr2592871fgb.20.1214607303987;
        Fri, 27 Jun 2008 15:55:03 -0700 (PDT)
Received: by 10.86.4.6 with HTTP; Fri, 27 Jun 2008 15:55:03 -0700 (PDT)
In-Reply-To: <-8386235276716376372@unknownmsgid>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86670>

On Fri, Jun 27, 2008 at 1:51 PM, David Jeske <jeske@willowmail.com> wrote:
> -- Jakub Narebski wrote:
>> git rebase --interactive?
>> Any patch management interface (StGIT, Guilt)?
>
> Yes, as I said, that set of operations can be performed with git today.
>
> What git can't do, is let me "supercede" the old DAG-subset, so people I shared
> them with can get my new changes without hurting their world. Currently git
> seems to rely on the idea that "if you accept changes into your tree that will
> be later rebased, it's up to you to figure it out". I don't see why that is the
> case.


Possibly a succinct way of moving this conversation forward is to say that:

What is desired is a workflow where partial commits can be tested,
when it is desirable not to change history.

There are good reasons for desiring a workflow that does not routinely
change history as part of the usual workflow.  Maybe there are clones
of your repo.  Maybe as part of your workflow discipline you do not
want HEAD states that cannot be pushed to public, because you don't
want to manually keep track of when it is ok and when it is not ok to
push HEAD to public, since git cannot tell you this.

Thanks,
Bob
