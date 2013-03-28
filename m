From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 2/2] t5520 (pull): use test_config where appropriate
Date: Thu, 28 Mar 2013 20:27:43 +0530
Message-ID: <CALkWK0=wCza1iL8AybrJqj6A4XfwP024PXi3s1jU7HhmAAjngw@mail.gmail.com>
References: <7v4nfz1ndo.fsf@alter.siamese.dyndns.org> <1364474419-22796-1-git-send-email-artagnon@gmail.com>
 <7vy5d7wpbi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 15:58:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULEHi-0004NX-A5
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 15:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756565Ab3C1O6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 10:58:04 -0400
Received: from mail-ia0-f182.google.com ([209.85.210.182]:59451 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756319Ab3C1O6D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 10:58:03 -0400
Received: by mail-ia0-f182.google.com with SMTP id u8so8342812iag.27
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 07:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=61yb0vdOW/XeDKkjRmMF0DK3Re2uRsA8wkLY3xb/G0s=;
        b=L/Kv5L5uJecEN4ece7fI6JDJo+QYP3TLgBL3EuY3APbawxUx86jTBFauPg4pN7uMk/
         Nhol+U1d/asT5E5l1UVFHPc3RAQHkowlew//38W/P8Y/lZ6HEILxhs9NjpehD159yyTM
         azv1BaUBbySbFxX9c9mpUfPAFFsRvlLbsQMQG37OeqJRWf8jzdnGrf7lN8XhGw6e4sce
         8H5zWwArQSYBEpMcp9JkZ3BNmpDCh3SbBxTHMn2rKs1B7MzvnUjvWZ08mH/kssY+OUYE
         EeyrGQXi/pik8lFbh8fCknIIBLZqxtCwU4SJjIA4VqyWep9vmwzaAHgKAb1hnyuqiNHu
         6iOg==
X-Received: by 10.50.50.71 with SMTP id a7mr7180520igo.14.1364482683115; Thu,
 28 Mar 2013 07:58:03 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Thu, 28 Mar 2013 07:57:43 -0700 (PDT)
In-Reply-To: <7vy5d7wpbi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219404>

Junio C Hamano wrote:
> Thanks, but doesn't yd/use-test-config-unconfig topic already
> address this?

Just saw it.  9d6aa64 is identical to my patch, but misses the fourth hunk.
