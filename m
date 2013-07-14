From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 1/2] send-email: squelch warning from Net::SMTP::SSL
Date: Mon, 15 Jul 2013 03:19:46 +0530
Message-ID: <CALkWK0k_up65K_i+Y+kj3vqWPoC_ti5FtPUffkPwVnJqBcdReA@mail.gmail.com>
References: <1373025947-26495-1-git-send-email-artagnon@gmail.com>
 <1373025947-26495-2-git-send-email-artagnon@gmail.com> <51D82970.5070108@web.de>
 <20130706143256.GX862789@vauxhall.crustytoothpaste.net> <51D83C7E.8000902@web.de>
 <CALkWK0kAfZLqyCO+e+0PH0-MmjMYX1nJmit5Qb5L3Qf6nyhC9Q@mail.gmail.com> <20130714170316.GE11097@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sun Jul 14 23:50:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyUBb-0002Ex-QU
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 23:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753349Ab3GNVu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 17:50:28 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:53197 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304Ab3GNVu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 17:50:27 -0400
Received: by mail-ie0-f172.google.com with SMTP id 16so24495442iea.31
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 14:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KslQhDy2Vqow+zMGluw1RVoeV0DqwmuNLUskm48LRSw=;
        b=aPPCZ819aWxkd7Go+6zhzRzPypiyJszq+VTq2oFKKPi4IaTF//FwG0DG1LFQtNwLFd
         u11DZjHk/WQi9CXhmgMC1B/FalXuDknkz+Mr599h6+4AoEofopV/SV+hBj+F7PU+e/Av
         Sp3pAAWjfTPeggDL34vlveY3jycGBMDa5C213VI58rGqmpgUc/TNk4PtH8CT6L57ONq6
         97LRBSTcHXFsLJ3I+KRpJQQSCJx/mZMrSgnM5xrxub1pa54TwWvr2YLiH19aMiaYc0zz
         80AUdCzrYvS+Dg/pWuMlKPLZX3V65AVo1iQrvxqTFtznJKOhLKGRjg3HBauYaQUpBGyT
         746Q==
X-Received: by 10.43.88.3 with SMTP id ay3mr16200562icc.61.1373838627164; Sun,
 14 Jul 2013 14:50:27 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Sun, 14 Jul 2013 14:49:46 -0700 (PDT)
In-Reply-To: <20130714170316.GE11097@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230399>

brian m. carlson wrote:
> I didn't stick the require in the eval because git-send-email will fail
> in this case anyway if you don't have it, since Net::SMTP::SSL requires
> it.  Let me know if you want a patch for this on top of the existing two
> in this series and I'll provide one.

Yeah, that'd be nice.  I'm not enjoying this Perl-wrestling very much.
