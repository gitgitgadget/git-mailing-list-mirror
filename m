From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Add comment lines to patch format
Date: Fri, 18 May 2012 08:30:09 -0700
Message-ID: <xmqq62bt4ida.fsf@junio.mtv.corp.google.com>
References: <20120518132228.GA27970@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 18 17:30:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVP8F-0004Pv-6i
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 17:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755323Ab2ERPaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 11:30:12 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:43719 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754844Ab2ERPaK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 11:30:10 -0400
Received: by qabg24 with SMTP id g24so31433qab.1
        for <git@vger.kernel.org>; Fri, 18 May 2012 08:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=aU+WCeK/ho2AhD44uiYCcxTB2fB/FnUH9CC6nZ3U2WA=;
        b=op67kaHh9pR8k74T0DH6oTNXqlf6j0GzkpZIBIl68yUijd2+nkq0A7cTJgM20vZsr2
         +2OGcE+qs6KpKNjch7iG4d2pJCalbw50oMgD92sZODAvu8ZHbYCLgWpf92pCy1qcfD/i
         1ia3wtvX8mjC7ZXjmhdFjlqdpPhHxMySCvJCHIA1GhDqkGvqJceE5cFemfyzeRubAYz9
         Zka1C92jOISq2J/ysovbwV5ydHH0tmx9aFNCN64OS5RlvGMtqEzkkq0V22YPAghHa1ZK
         ZPwuT0pn/+/B9ZWQhnI+qcaPCq9SHaV54yE5IvODQ+9BwDExdeZ7d4T9oVreQrH2FzSZ
         nenw==
Received: by 10.100.255.2 with SMTP id c2mr5299440ani.18.1337355009901;
        Fri, 18 May 2012 08:30:09 -0700 (PDT)
Received: by 10.100.255.2 with SMTP id c2mr5299435ani.18.1337355009847;
        Fri, 18 May 2012 08:30:09 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id v25si8179499yhm.0.2012.05.18.08.30.09
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 18 May 2012 08:30:09 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id BAB561E0105;
	Fri, 18 May 2012 08:30:09 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 5D8F6E1772; Fri, 18 May 2012 08:30:09 -0700 (PDT)
In-Reply-To: <20120518132228.GA27970@do> (Nguyen Thai Ngoc Duy's message of
	"Fri, 18 May 2012 20:22:28 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQlgYjetH3+e7QCQ5nSnuAyxjgo5VBcINQ+DGmn/ArlZSnC4CSm/6153Vrhwz9ovIAevrlbcTI9A/rpUNjf6VS4lL0oA/i8na98vmiLYfHcYquywrnVHb5dDy9GVngJvTc3wyO6K+e+eX7FfQTlC5KT0DwZKeg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197958>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> If anyone knows a tool with similar feature, I'd greatly appreciate it
> (as the Internet taught me, everything I think of is already thought
> of/implemented by someone)

Look in the archive and I think you will find a patch by me that
implemented this not with '=' but with some other character, possibly
with a matching patch to 'apply' without which its output is not usable.
It was back when I was still a contributor, I think, so I do not
remember the details.
