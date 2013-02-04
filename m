From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Feature request: Allow extracting revisions into directories
Date: Mon, 4 Feb 2013 23:58:39 +1100
Message-ID: <CAH5451mp6fRU25LWE+8gk1h6Mz=y_XQHaU-iE0k4=bP0RfzLAA@mail.gmail.com>
References: <1359901085.24730.11.camel@t520> <510F9907.7010107@drmicha.warpmail.net>
 <1359980045.24730.32.camel@t520>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Robert Clausecker <fuzxxl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 13:59:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2Lds-0008DD-AF
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 13:59:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754261Ab3BDM7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 07:59:00 -0500
Received: from mail-vb0-f50.google.com ([209.85.212.50]:38037 "EHLO
	mail-vb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696Ab3BDM7A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 07:59:00 -0500
Received: by mail-vb0-f50.google.com with SMTP id ft2so3839847vbb.9
        for <git@vger.kernel.org>; Mon, 04 Feb 2013 04:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=018v8D3IiGaORBF9hXwsfXGDPXrEBeSDcrIYrYjnFew=;
        b=QvE1d8Sg/CG8getE3MNO2Jofq/k6PC1d6Cc4kLDIrQ0WbpkhZ+0Cf8wr702xqiYxHb
         +L0j3SXZINN0y6Ey+eahErQ9JmYZA1v74I15cyqU+vNKJq4DEdPmUZOapYyME8LIwlYv
         Nx+O2XzXZSHoMwWhBkAWXbbBR46BtpBM0JCLLKn2OyEYjTQhOLMu8gaA5SeopgvIrl25
         HG+kotkgwLn0oDmFoIoCbMb/w92RuPWKyKs3h4zZlAwqFJTNpEbCcgdJlAmudurdoDA+
         MwypMJV+eNJTRQSFWuF3C6VzZLh4kR4/iKY6a3lD6JMKWAW9fQnB+Sm5wSgdVje+ivIb
         Exeg==
X-Received: by 10.52.95.243 with SMTP id dn19mr19189498vdb.110.1359982739527;
 Mon, 04 Feb 2013 04:58:59 -0800 (PST)
Received: by 10.220.107.82 with HTTP; Mon, 4 Feb 2013 04:58:39 -0800 (PST)
In-Reply-To: <1359980045.24730.32.camel@t520>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215380>

On 4 February 2013 23:14, Robert Clausecker <fuzxxl@gmail.com> wrote:
> The specific workflow I am planning is this:
>
> I have a server that hosts a bare git repository. This git repository
> contains a branch production. Whenever somebody pushes to production a
> hook automatically puts a copy of the current production branch
> into /var/www/foo. I could of course use pull for that but it just does
> not feels right. Why should I have a repository twice on the server?

Maybe I'm missing something. How does the behaviour you need differ from

> GIT_WORKING_DIR=/var/www/foo git checkout -f <tree-ish>

??

Regards,

Andrew Ardill
