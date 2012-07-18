From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 0/7] correctly calculate patches to rebase
Date: Wed, 18 Jul 2012 00:32:05 -0700
Message-ID: <CAOeW2eEeOZwcmqVy3pqLdkRRpmdGWdHwvv2cX4YGDxz1Xg-Gaw@mail.gmail.com>
References: <1342596455-17046-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 09:32:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrOk0-0006au-M3
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 09:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675Ab2GRHcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 03:32:09 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49614 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab2GRHcF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 03:32:05 -0400
Received: by pbbrp8 with SMTP id rp8so2171068pbb.19
        for <git@vger.kernel.org>; Wed, 18 Jul 2012 00:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=fR4rcLHDchkt9FZFeHbPBUewpTC64X/KOPC0ydU4xlY=;
        b=aHQbwnJiJGrlntQMFIa+KnzWwp8dE9dvObgOPZsluSSNxEZcofpHNlXU4jvx/2ngPI
         2xU3jqSNrMyd7e6bYF5W1unESg1LZD8iJZ3Z6BS55eCQtc+YOXmJfR6FapaB/LiT+tks
         lVnCRZ76xZwkITET/XpQAKn60VgcOMmXAezMepqngGQCMV0jZsK92JwY6hA9HfA21HW9
         9K5aTNBaRLm00+z65uv7dRnQIEwjVIxGPPtMfMLmM1Xi2LYCMYIl6RKfVfaHlD5qjdQl
         cqnGCsp8TNYkB76qKJfWzu0OPj7+FLjTOV/+bahK7J6HztwJetebpYqLf7N+Mn5A5f+7
         z9/g==
Received: by 10.68.190.102 with SMTP id gp6mr5323509pbc.5.1342596725213; Wed,
 18 Jul 2012 00:32:05 -0700 (PDT)
Received: by 10.68.236.138 with HTTP; Wed, 18 Jul 2012 00:32:05 -0700 (PDT)
In-Reply-To: <1342596455-17046-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201666>

Argh! Sorry about the sendemail.chainreplyto=true. I must have read
that warning message incorrectly :-(.
