From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Support running an arbitrary git action through checkout
Date: Fri, 10 May 2013 22:05:48 +0530
Message-ID: <CALkWK0kES+b3A64-nm+4aerBiEBn-cHKkHXb-Vhtp4JdMP9COQ@mail.gmail.com>
References: <2d5cfb3be9487f607051cad3d5230434660307ba.1368198269.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Steve Losh <steve@stevelosh.com>,
	Jeff King <peff@peff.net>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri May 10 18:36:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaqJ8-0004F3-11
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 18:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756029Ab3EJQga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 12:36:30 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:53174 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754990Ab3EJQg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 12:36:29 -0400
Received: by mail-ie0-f182.google.com with SMTP id a14so8400755iee.13
        for <git@vger.kernel.org>; Fri, 10 May 2013 09:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=FiJ2Q2Y8bMkQyvh+I4ry6rWzkremFZwJvq0s7GBs1es=;
        b=DTTG+JRpElOl87/jWUvVwAWY7ueTI99c2Q+C/FG4FtNwl0Ge9f7Y1cM68vEW/9fjzO
         uPUu52mX7JcKSztML8Q8tO478nNM4CQp0/Hnk6/y5iI167vqbzN1mLBprAZUksvAxwFq
         Prmyhl1Re2lgP5WJGZHHnMvR9gU9RmfGt8xVgzztge44rGpv/2IU4t+HyEmHXmu14epf
         kBYqKmJNN1vs2V2G9RJvDYWdz+RkRCxn9rIOgC3a4w5QJtoNewGuCDtPgIyccu2ueFyN
         4YNqhN3JATT26LkUayfS6JLdxzuWJAZwn6V+NvoVn+jTfkcpMB0ntms9pHZ8W8siiAoL
         MGeg==
X-Received: by 10.42.27.146 with SMTP id j18mr7898038icc.54.1368203788692;
 Fri, 10 May 2013 09:36:28 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 10 May 2013 09:35:48 -0700 (PDT)
In-Reply-To: <2d5cfb3be9487f607051cad3d5230434660307ba.1368198269.git.trast@inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223878>

Thomas Rast wrote:
> [1] correctly observed that we are already wrapping three different
> operations under the git-checkout command.

Incorrect.  We merge_trees() and update refs.  I see no reason to
create artificial abstractions on top of this.

> [...]

Let's not talk about how gross your implementation is.
