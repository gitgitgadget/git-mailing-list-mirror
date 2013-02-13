From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2013, #05; Tue, 12)
Date: Wed, 13 Feb 2013 11:42:06 +1100
Message-ID: <CAH5451mmXg=xvb-gW0qNvp7f8M5Jk5_ZS+UHAzMaGhJ677zWmw@mail.gmail.com>
References: <7v621xdql8.fsf@alter.siamese.dyndns.org> <CAH5451nPKq8DKwo+Bkxh08N-wqrYCY4BihbvaE14z5iGVA1iZw@mail.gmail.com>
 <7vsj51caqb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 01:48:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5QWZ-0003DR-Ti
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 01:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759519Ab3BMAsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 19:48:12 -0500
Received: from mail-vc0-f176.google.com ([209.85.220.176]:51838 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328Ab3BMAsL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 19:48:11 -0500
Received: by mail-vc0-f176.google.com with SMTP id fk10so446286vcb.35
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 16:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=9bv+/3tN+/gKb5QhOVA7zlprnQTyMZ2BQJBZ+vv1AG8=;
        b=TX9vAOfKlBYbBcq7yO+DTGRNt959/Ar7u0BK8S1h4fFp6Py7ZyGt5YLmXG2BSL6OCX
         1t+Cn6Lznpaiu+VCU3MBC4Pauk31/B/48o/v2HV6ZxGhAiceBSh9ey9u0FzNSVSp48f5
         AX58CvBhP0X+HSN71Nrhly7Tuoz2XuYudG1yTXBb9SFg0jwWkGjWZqIByOt5deXNEU+N
         K7jrtd7v3WnKhMu8oAMrtYqXpMBdPWuOW0THZJUvMg1ADEW5FWvEFTI49gpJPqmos/lK
         kCC2JvTlObX0X9A04AjEhsexsf9ECDFblkeCNKKbuWdStBGOYJMFxSXNor+jJ6eKfkoC
         o6Qw==
X-Received: by 10.220.228.138 with SMTP id je10mr26533088vcb.67.1360716147378;
 Tue, 12 Feb 2013 16:42:27 -0800 (PST)
Received: by 10.220.107.82 with HTTP; Tue, 12 Feb 2013 16:42:06 -0800 (PST)
In-Reply-To: <7vsj51caqb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216233>

On 13 February 2013 11:34, Junio C Hamano <gitster@pobox.com> wrote:
> The change could negatively affect people who expect that removing
> files that are not used for their purpose (e.g. a large file that is
> unnecessary for their build) will _not_ affect what they get from
> "git add .";

How big a problem is this?

If we need to support this behaviour than I would suppose a config
option is required. A default config transition path similar to git
push defaults would probably work well, in the case where breaking
these expectations is unacceptable.

> obviously they must have trained themselves not to do
> "git add -u" or "git commit -a".

Many people use git add -p by default, so I would not be surprised
about people not using -u or -a.

Regards,

Andrew Ardill
