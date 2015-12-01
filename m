From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 0/2] git-candidate: git based patch tracking and review
Date: Tue, 1 Dec 2015 16:00:52 -0500
Message-ID: <CAD0k6qQ98ED4xLynRZdnnPX_HDHhEq5SQhNov-5cwG82pqMFGw@mail.gmail.com>
References: <1447160198-23296-1-git-send-email-richard.ipsum@codethink.co.uk>
 <5643107B.20501@alum.mit.edu> <20151201205527.GF18255@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Richard Ipsum <richard.ipsum@codethink.co.uk>,
	git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 22:01:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3s33-0004Fl-3E
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 22:01:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755307AbbLAVBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 16:01:13 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:36270 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755191AbbLAVBM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 16:01:12 -0500
Received: by iofh3 with SMTP id h3so23735732iof.3
        for <git@vger.kernel.org>; Tue, 01 Dec 2015 13:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qgmxatlElHzasW7gXqM7g0AOBr+UCUxoc3Ri1PjdZco=;
        b=SyypQEouYSNmPPOczHKJPJOOoTniIKfRAQ4jIoDZ8KBpAngauqzXQDoDD/IkP3+S0R
         BmLCIU6h6xWI5uOJ7dgFKIFCHWeULUxI6wItisTVmOuCxjaHNZhDIsi82Rj4JSSnfUZb
         HNvA7dVIFwFFkH851LpV5lcQzN2qiVzOEGAPTvsae3CNojtH84+8gDKpAVpEJQ9pauX1
         EJ1DqKwSR8SLB8leSWnPbG9LHPmQcS7BC0xwFa1dNBFL8Yw+g0AWKnBZEqYW7G+v1gcQ
         esO2pZXiAvByZeW3TbZTghSCpJ8s4XO8pTioItFFnTcGuWDtCNSk3GrbyVM5cjeK+3WA
         wgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=qgmxatlElHzasW7gXqM7g0AOBr+UCUxoc3Ri1PjdZco=;
        b=R/KTqJeQq+Y6J2jduSLA3qCECDYl2Ahvsumsw+byyLpEhnppTcCEKTgWpHN0RHjQ9A
         4hvO+8ZrykEXr8axx3kjwyXA1kJQ+lsSrPbQSAdwUH5DkfQ1G5+4369TFqM2exWdpqLN
         nr2rdi3sK1paKWoLb7oipNh6Ncv5Eq6RZBCWaXNfc+sJlt3opzo2ngHKDAzucNZxBWWR
         HEJH2xrKeHVn0YGC8SNX4bS8osUmrfZU4d8eCKwV2diPuxvs9+r+TtvJ7j6ULPri6mL4
         Bl8i9U6cHU+WEXlZng142Jcr1dWc+c/wcDfaFkrf58mfk1YJVdYFvje7TQ/Ut24VLZQF
         +1Mw==
X-Gm-Message-State: ALoCoQnlD7WUO0j+N3HtaaY6DZ7CM5ZDmP7+VV5AcYL8T0bMKlgWzS7PSnDlhLq8ICwSIprKpS7M
X-Received: by 10.107.25.199 with SMTP id 190mr158178ioz.37.1449003671720;
 Tue, 01 Dec 2015 13:01:11 -0800 (PST)
Received: by 10.36.122.193 with HTTP; Tue, 1 Dec 2015 13:00:52 -0800 (PST)
In-Reply-To: <20151201205527.GF18255@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281855>

On Tue, Dec 1, 2015 at 3:55 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Cc-ing dborowitz, who has been working on storing Gerrit's code review
> information in Git instead of a separate database (e.g., see [1]).

Thanks, we actually already had a thread going that I realize only in
retrospect did not include the git mailing list.
