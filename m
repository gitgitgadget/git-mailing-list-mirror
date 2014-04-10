From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 7/9] sha1_name: cleanup interpret_branch_name()
Date: Thu, 10 Apr 2014 17:45:51 -0400
Message-ID: <CALkWK0mWW+RrkEyuBw6c7yLwR8qpiTTJYR_cO33=tW716w94qg@mail.gmail.com>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com> <1397156686-31349-8-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@imag.fr>, Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 23:46:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYMnt-0007EU-5L
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 23:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809AbaDJVqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 17:46:33 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:60285 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692AbaDJVqc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 17:46:32 -0400
Received: by mail-ob0-f173.google.com with SMTP id gq1so5097910obb.4
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 14:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5/W6W5BmmVVWTC0w50+3j/uyWWrs9i7ii1U/KPKAAes=;
        b=aC19/BDUO6cHACUqpaqcE9ljmuXap3wdJj7UhVbvnKTBF80uBUvWadSPIpwUgnZZbI
         qjJ+xCCY3E1rcaSCHvCuHqTdQ0WFA2fVAPmyQEmiSiJoCjdUG2W5ziTrnH3L08tgQ+CC
         ekGaUCEvXsNnmsHz94lHgLusIeewMmivu1yOWMw7aX5bSDUsFCGA3flH5AwrzTyOt/mB
         Y+CpGgSTAp5KfqdxsvouLkBsUKMEd3w1eUGV5UxkXs7vDZQ8FNP9N35C62fJbzprWFff
         vYsYgM18Bvh46aYpcn9bLM5dLmJRqHHvKoLx2036Y5EFU16NjcG9DptE8k+tB1vHLNU9
         XKqQ==
X-Received: by 10.60.83.234 with SMTP id t10mr15999479oey.4.1397166391678;
 Thu, 10 Apr 2014 14:46:31 -0700 (PDT)
Received: by 10.182.151.43 with HTTP; Thu, 10 Apr 2014 14:45:51 -0700 (PDT)
In-Reply-To: <1397156686-31349-8-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246057>

Felipe Contreras wrote:
>  sha1_name.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

I like this variable rename. This instance has annoyed me in the past.
