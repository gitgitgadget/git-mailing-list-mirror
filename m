From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/9] for-each-ref: avoid printing each element directly to stdout
Date: Sun, 19 May 2013 16:47:19 +0530
Message-ID: <CALkWK0mSxYhJDBzrtfZyKQquqAYJiYj2AFBdk3hdDyQgSW3ZRw@mail.gmail.com>
References: <1368959235-27777-1-git-send-email-pclouds@gmail.com> <1368959235-27777-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 13:18:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue1cs-0005HV-Bg
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 13:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154Ab3ESLSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 07:18:01 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:61062 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899Ab3ESLSA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 07:18:00 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so12193476iej.30
        for <git@vger.kernel.org>; Sun, 19 May 2013 04:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=18un/pX2+Ol0ZKGSGowPffNDyTrM/Rpn4+67+c4Clj8=;
        b=iTyrCE9UgUyoiQpCJqI9KRfWZapLEJo9X7bvQq9pDzqjIzSbcGatML2FepOUMg9h9H
         cnyRmEOEf40DIS9w/tq+pEjSGHyp+pd9yGhO3CydGuchrHD4ug2ZjEkyJj3EDEQW7lNZ
         Ir8DtaB6tVypJRwI+qbhhB3fVv0sxd4kbQikfJlIlE8g4lFJvxBhk3o9bOObnjMhIowe
         vneDxJ9rESXU2rwuGzJbaDXfwLa+fT55mutcOCILJrLAXKgqgCKJP6W3EQ9R/s5HJm4l
         gK8acl2wiZ7brc49ZmaQQvkgE576NwboXrAlMFqrZ+1xU5Qx/uAKtntUGOpeJ4JWN45g
         5vHw==
X-Received: by 10.42.47.77 with SMTP id n13mr483591icf.12.1368962280069; Sun,
 19 May 2013 04:18:00 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Sun, 19 May 2013 04:17:19 -0700 (PDT)
In-Reply-To: <1368959235-27777-4-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224850>

> [PATCH 3/9] for-each-ref: avoid printing each element directly to stdout

Why did you do this?  Atoms are designed to be independent of each
other.  I'll keep reading: might find out in a later patch.
