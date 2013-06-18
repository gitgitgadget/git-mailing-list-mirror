From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Documentation/git-merge.txt: weaken warning about
 uncommited changes
Date: Tue, 18 Jun 2013 14:19:28 +0530
Message-ID: <CALkWK0=USVa2htHSTyj4C7FrKEko-e_UGAnu-3UNvx_ue1vwig@mail.gmail.com>
References: <1371544975-18703-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Jonathan Nieder <jrnieder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 18 10:50:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UorcG-00044z-D7
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 10:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754907Ab3FRIuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 04:50:10 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:32938 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754477Ab3FRIuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 04:50:09 -0400
Received: by mail-ie0-f174.google.com with SMTP id 9so9218164iec.19
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 01:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DMlF2LRX2MsfAr+yHvJCJHbRDofWTWhD9PSdwwz1MdU=;
        b=Yv4FWfNTq/CsvFH4TCf7SUdO1LribrG/QL0tRANIX9JONaaC9Pgha3t8Xid/7jrPjV
         EYQtvLx7T+3KVVNikR6j1BODYgvYRoSq5GR5OVXgva/uwN2iLLIGjcJQU3emnA9SeVYp
         XXW0aYVpSjGcdFVPVBCNzI27oGY8QaQ6TEkFb6GAVlzv+VIpvF2F47K6yOJmqVk3R3V7
         eW8ipqunXqqmP5edFVph7h980mQyX/cYOaJ1hxP3gM8ksZ4AVwP1nTuDFXoITFBWSndU
         WDep+BSIS6nfQdGyFZkvNIy6pgrjWX2/IbSFkgQd/Ir/V3CxY9ntmNx0lW/iFtZ/0vy0
         HKcA==
X-Received: by 10.42.73.138 with SMTP id s10mr845588icj.10.1371545408365; Tue,
 18 Jun 2013 01:50:08 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 18 Jun 2013 01:49:28 -0700 (PDT)
In-Reply-To: <1371544975-18703-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228175>

Matthieu Moy wrote:
> Weaken the warning by discouraging only merge with /non-trivial/
> uncommited changes.
>
> I don't think documenting all the failure cases in the doc would be a
> good idea, so I've left the "in some cases" part.

It's already documented in the pre-merge checks section, as Jonathan
pointed out [1].  We should update the documentation to point to it: I
do not think "non-trivial" is much of an improvement.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/221069/focus=221366
