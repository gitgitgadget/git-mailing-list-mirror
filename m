From: Quint Guvernator <quintus.public@gmail.com>
Subject: Re: [PATCH] general style: replaces memcmp() with starts_with()
Date: Fri, 14 Mar 2014 12:32:05 -0400
Message-ID: <CALs4jVGezrktbhhzk4E-C5-xDwyGAF9_1XbzHR4mdsou9GhDkA@mail.gmail.com>
References: <1394631854-11208-1-git-send-email-quintus.public@gmail.com>
 <CACsJy8DUhqn_ESzT-KpAdrWvWcLbPUiXDmBZXu7UtHU+M0GLgw@mail.gmail.com>
 <CALs4jVFM58Yiku4B8NrVeac0Hmt5YsPNYb_EjY6bOr=JO6pP+A@mail.gmail.com> <5321D75B.5020600@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Mar 14 17:32:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOV2A-000507-4m
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 17:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755974AbaCNQc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 12:32:29 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34280 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755968AbaCNQc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 12:32:26 -0400
Received: by mail-wi0-f173.google.com with SMTP id f8so5634563wiw.12
        for <git@vger.kernel.org>; Fri, 14 Mar 2014 09:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Oqt7pVw5yfyFVdYZwIj8qMXRDoTLORXVa5b79Fns0fE=;
        b=MvodSmCzKL3nl87jI1cfxOoTKU11h6UPxNC4XK6ne/QgbkZjIBCxCKfqneQNgnGEHa
         kqV58v2v8K6aZn2fxI6asHfUYSChinoBL4HQawMs+h057G6HkwY18R/3VNgGKohYkAVG
         gPF3tEW2JicPAgpdzxWzmqqP2tRxaV/4Cd/snzZjkQ442kJEuKWgUWmFKmU3n/mC08++
         kS8JUTHY0zIJOLx4qqFWGSx9BNoqeBvxIftMZwdO3BwRglfQsGaahM4UPUrKKHmx8DwO
         siYDFbaIYmIjvNFnDCWTBT20h/Gz9sAbMd1w4yh+sjPWXqiOcs3lOgeU9GRc9JByB6r1
         xlRA==
X-Received: by 10.194.75.225 with SMTP id f1mr586995wjw.87.1394814745432; Fri,
 14 Mar 2014 09:32:25 -0700 (PDT)
Received: by 10.216.231.138 with HTTP; Fri, 14 Mar 2014 09:32:05 -0700 (PDT)
In-Reply-To: <5321D75B.5020600@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244092>

2014-03-13 12:05 GMT-04:00 Michael Haggerty <mhagger@alum.mit.edu>:
> It is very, very unlikely that you inverted the sense of dozens of tests
> throughout the Git code base and the tests ran correctly.  I rather
> think that you made a mistake when testing.  You should double- and
> triple-check that you really ran the tests and ran them correctly.

It looks like HEAD was in the wrong place when I ran the tests. They
do not in fact pass.

Apologies,
Quint
