From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v2] commit: support commit.verbose and --no-verbose
Date: Sun, 25 May 2014 00:44:13 -0700
Message-ID: <20140525074413.GA26369@hudson.localdomain>
References: <20140525062427.GA94219@sirius.att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Caleb Thompson <cjaysson@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 25 09:44:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WoT6U-0007Bc-Pn
	for gcvg-git-2@plane.gmane.org; Sun, 25 May 2014 09:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbaEYHoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2014 03:44:19 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33967 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbaEYHoS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2014 03:44:18 -0400
Received: by mail-pa0-f53.google.com with SMTP id kp14so6070439pab.12
        for <git@vger.kernel.org>; Sun, 25 May 2014 00:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=prDBgZ1tK5LRdmW3NrNvIU/GVPzHr+r05S2ZChMidR4=;
        b=MLzb57ksS+Cf4KC03F/6NoJvD6NRX8D54TAcQ0rCBQOtHuBAhg25an6Lxhb8A7H707
         HLjZGljYkZ/SS2vwI13IUqKLl77yN4zOvz0d9o6AeHge4EK8uvKCvho3pQHF+M0/0ztM
         1jUlJoDQe39ZXex5La2ZwPZQqQY8GH6QKOgU1S9u4dlOIZpgZ2vpld5JZCx9h22qNb7X
         N1Ai0AgdeaByFqA9QZFIRgasXUiZReHNjj26bSL0FIF4w7TNWomhkJEUWE/8dc36y5cC
         QdLlni1xozWeHDJft25wqrhafrOypjIBYknBuwWhN4Ki96S4b2DoV8lZBz1j7NRWyZE1
         Da9w==
X-Received: by 10.66.150.169 with SMTP id uj9mr18773953pab.148.1401003858258;
        Sun, 25 May 2014 00:44:18 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id pz10sm12427591pbb.33.2014.05.25.00.44.15
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 25 May 2014 00:44:16 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Sun, 25 May 2014 00:44:13 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Caleb Thompson <cjaysson@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20140525062427.GA94219@sirius.att.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250081>

On Sun, May 25, 2014 at 01:24:27AM -0500, Caleb Thompson wrote:
> Incorporated changes from Duy Nguyen and Jeremiah Mahler.
> 
...
> 
> +test_expect_success 'commit shows verbose diff with set commit.verbose' '
> +	echo morecontent >file &&
> +	git add file &&
> +	test_config commit.verbose true &&
> +	check_message message
> +'

This test case doesn't appear to be checking for the verbose output.
No commit is made so it can't check for the presence of a diff.
"check_message message" passes as it did in the test above this (not shown).

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
