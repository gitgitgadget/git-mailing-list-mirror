From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 07/18] revert: Eliminate global "commit" variable
Date: Wed, 27 Jul 2011 14:29:49 +0530
Message-ID: <CALkWK0=Bsq5RpmHLj9H0yVw-ALGWqOaOM2r9SyeBAPHqiwazew@mail.gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-8-git-send-email-artagnon@gmail.com> <20110727044341.GE18470@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 11:00:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlzyS-000615-Q7
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 11:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001Ab1G0JAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 05:00:12 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39024 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178Ab1G0JAK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 05:00:10 -0400
Received: by wyg8 with SMTP id 8so822078wyg.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 02:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5OVWS8sGXEg9SgSh70UX8I9/s24tVA1inKAJSFG7wQY=;
        b=k1zkYzYwKrzw8V2tVvI1hFEOYaGZKC/ter+pjPTUrq87oZ7Fh5N87isW2naRL5o+ex
         yK9fyZShaD7qVyPIAbAZ6LOY8OS28nQvV+SMf2xa3N/2X1tR3/K2Y6ahA1E4i71D0zY6
         sfO2uuK3b82JXg2UFx6xEiBq9wPAcykgJ0cVY=
Received: by 10.216.143.66 with SMTP id k44mr2658508wej.81.1311757209072; Wed,
 27 Jul 2011 02:00:09 -0700 (PDT)
Received: by 10.216.70.16 with HTTP; Wed, 27 Jul 2011 01:59:49 -0700 (PDT)
In-Reply-To: <20110727044341.GE18470@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177949>

Hi,

Jonathan Nieder writes:
> Tiny commit message nit: code, diagrams, and other text for which line
> breaks are significant are more easily read when indented so the
> reader knows you are not just editing with a funny line width (e.g.,
> grepping for : at ends of lines in the pager shown by "git log" should
> show some examples).

Fixed.  Thanks.

-- Ram
