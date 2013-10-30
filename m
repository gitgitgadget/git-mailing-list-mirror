From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 02/23] t5510: prepare test refs more straightforwardly
Date: Wed, 30 Oct 2013 16:27:28 +0530
Message-ID: <CALkWK0=tcEbdvFaaV1YFBTXWAHaHYcJ1YNLpj0Sj5sGK_inapQ@mail.gmail.com>
References: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu> <1383111192-23780-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 30 11:58:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbTTb-0000vY-5j
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 11:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858Ab3J3K6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 06:58:10 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:54774 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528Ab3J3K6J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 06:58:09 -0400
Received: by mail-ie0-f180.google.com with SMTP id e14so1867218iej.25
        for <git@vger.kernel.org>; Wed, 30 Oct 2013 03:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EWjvJ64GOdrVnD9Mawo+T2xlWb8hooJessRvfB+bibc=;
        b=rixEC99HXUxZjhwXJLr1V++Nqf7rvMDQRGzupcAGigen91snZPe558SwYWx6MRi6BC
         y68frrVKNoUgI5U66at/cihNbHZlzmk8xWY2xN7iI1KuYWzxZmqGvQGMJM2D0yPpgEVn
         RV4hSDQfBcmzW9bHc3tTU0rvsvDvC55RdC/uIKNfIsk63OZ8pEPQk9ZjUlplpZLW+kdU
         itnDBa6d7HYN7zreKzBSf0C/wUCTbJ/bVJ6VLJkPJsZ0zTjZIdQazieC3ETzqMAWGxID
         Z/IYsFoq8gj2Msc5aBmPjjOrZ9iMA6UzAWJGuresox2ZhVpBouKjpDShGTONQQLGEZVJ
         XhaA==
X-Received: by 10.50.16.45 with SMTP id c13mr1747186igd.55.1383130688662; Wed,
 30 Oct 2013 03:58:08 -0700 (PDT)
Received: by 10.64.73.36 with HTTP; Wed, 30 Oct 2013 03:57:28 -0700 (PDT)
In-Reply-To: <1383111192-23780-3-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237011>

Michael Haggerty wrote:
> "git fetch" was being used with contrived refspecs to create tags and
> remote-tracking branches in test repositories in preparation for the
> actual tests.  This is obscure and also makes one wonder whether this
> is indeed just preparation or whether some side-effect of "git fetch"
> is being tested.

As the test titles indicate, we are exercising the 'fetch --prune'
functionality. However, I don't see the 'git fetch <remote>
<src>:<dst>' form exercised anywhere else in the file.
