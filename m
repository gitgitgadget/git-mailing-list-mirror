From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] gitweb: Option to not display information about owner
Date: Thu, 26 Apr 2012 08:53:22 -0700
Message-ID: <xmqqaa1ya3rh.fsf@junio.mtv.corp.google.com>
References: <20120403132735.GA12389@camk.edu.pl>
	<20120416213938.GB22574@camk.edu.pl>
	<201204180136.08570.jnareb@gmail.com>
	<201204191807.32410.jnareb@gmail.com>
	<20120424174114.GC15600@camk.edu.pl>
	<xmqqy5pj9kew.fsf@junio.mtv.corp.google.com>
	<20120426150721.GG16489@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Thu Apr 26 17:59:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNR6L-00070g-Rh
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 17:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758047Ab2DZP6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 11:58:08 -0400
Received: from mail-vb0-f74.google.com ([209.85.212.74]:43105 "EHLO
	mail-vb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757991Ab2DZP6G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 11:58:06 -0400
X-Greylist: delayed 6818 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Apr 2012 11:58:06 EDT
Received: by vbnl22 with SMTP id l22so160463vbn.1
        for <git@vger.kernel.org>; Thu, 26 Apr 2012 08:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=SFmTkwaVrC2aG13KUW85HHT6SbwN4wtgkrXpj670IE8=;
        b=keeH1Niht2WceGsA7LKMRzCq/kTZTjRZYR5bFq73plrdIddHuiQBVQ/njYBHFiok1k
         Jr4EW9r69nYgC75aUAyS7YCoqZ4V3ufUWhsw0DhOPvD8iD3ldCSz7nYMH1ZM73UFs6jw
         9Sn2eO91JaP6aqFdo6XverNBxPmGpJR3agUbMZbbwWSUZBp1MjKLGTuz218wdkW+qW9V
         lnGSWH24lYwvSNbuWzSZTK4O/1InTZgl1In3H9kwe3iOeEsCiGXJWRtY7eKmT3w3Re0F
         l1Fs27oBwFzApezpnCCTFBC7CGaM7oALJlg1qvfK0GVhGbtJ32zq+P9wufLUxB6JLSyp
         4ZpQ==
Received: by 10.100.76.4 with SMTP id y4mr2628667ana.21.1335455884767;
        Thu, 26 Apr 2012 08:58:04 -0700 (PDT)
Received: by 10.100.76.4 with SMTP id y4mr2626529ana.21.1335455742676;
        Thu, 26 Apr 2012 08:55:42 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id j51si3462177yhi.1.2012.04.26.08.55.41
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 26 Apr 2012 08:55:41 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 71AFF1E02BB;
	Thu, 26 Apr 2012 08:53:23 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 17F0DE125C; Thu, 26 Apr 2012 08:53:23 -0700 (PDT)
In-Reply-To: <20120426150721.GG16489@camk.edu.pl> (Kacper Kornet's message of
	"Thu, 26 Apr 2012 17:07:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQkpi5gTw5p8xw8uTl3ntYfzd8nrV33ZjKt2v5qsHkEJnMkcRjtaVGGlzXdMWWcWQKqRR3I7rmFVQaBCqNHOVe3hjlOxk0B/ygRgqG0f0J2m8enpbFqJgxVlKlWocwrVpvuqvosff2BcXTjUw1ni+3ZgQnHjIFvJBUYtOC28Wny8ReQ09Vk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196376>

Kacper Kornet <draenog@pld-linux.org> writes:

>> I am guessing both #5401 and #5551 are $it->{'category'} of @projects[]
>> elements.
>
> Yes, I have tested the tree with:
>
> gitweb: Improve repository verification
> gitweb: Option to omit column with time of the last change
> gitweb: Option to not display information about owner
>
> applied on top of v1.7.10. And all tests except 't91??' are passed.
> Could you write on top of which revision have you applied these three
> patches?

Let's see...

$ git log --oneline --first-parent --boundary master..kk/gitweb-omit-expensive
37e2621 gitweb: Option to not display information about owner
5710be4 gitweb: Option to omit column with time of the last change
75e0dff gitweb: Don't set owner if got empty value from projects.list
- fdec2eb Merge branch 'maint-1.7.9' into maint

I replayed these three on v1.7.10^0

$ git checkout v1.7.10^0
$ git format-patch --stdout fdec2eb..kk/gitweb-omit-expensive | git am -s3c

and the result fails exactly the same way, though.

*** prove ***
t9500-gitweb-standalone-no-errors.sh .. Dubious, test returned 1 (wstat 256, 0x100)
Failed 2/117 subtests
        (less 2 skipped subtests: 113 okay)

Test Summary Report
-------------------
t9500-gitweb-standalone-no-errors.sh (Wstat: 256 Tests: 117 Failed: 2)
  Failed tests:  116-117
  Non-zero exit status: 1
Files=1, Tests=117, 15 wallclock secs ( 0.07 usr  0.00 sys + 10.18 cusr  1.42 csys = 11.67 CPU)
Result: FAIL
make[1]: *** [prove] Error 1
make[1]: Leaving directory `/srv/git/t'
make: *** [test] Error 2
