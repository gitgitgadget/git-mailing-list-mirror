From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/9] submodule: implement `module_clone` as a builtin helper
Date: Mon, 31 Aug 2015 11:53:46 -0700
Message-ID: <xmqqy4gruw5h.fsf@gitster.mtv.corp.google.com>
References: <1440724495-708-1-git-send-email-sbeller@google.com>
	<1440724495-708-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmx.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 20:53:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWUDJ-00052G-AZ
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 20:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbbHaSxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 14:53:49 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36675 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbbHaSxs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 14:53:48 -0400
Received: by pabpg12 with SMTP id pg12so15286321pab.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 11:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=RRb2KW03BRE7mr5hSDKGpqG5SIyB9xt2IwmAlB1D6i8=;
        b=fFE42YSq6wx254yLzBQNjgkRkqIl5rwHx0M4QosbfU3xS+/mzTHn/uV8nXMnTWBko6
         A2WOqidbq447JqeK32UCiqEeWccdsGkU7/L8yvJOcHJR2Af7E2K/4ZRA/O/7zCU+/5kb
         6eeppuANAiB7WUnhdQCmol3d5662XQGLVpszb8Jm0qzbEHMf9ZnqmepJd+I6dpARYqX9
         QRTIGF+7Y/iMPORSkiGZGCifedTUqzFRItpqoJvR2EoRwEZyRAopVOJl474GpVV3iu4d
         FBYhoGU97tDkEZ94h/BZNyfzjjz13Bj0+3+KL5A1/IvDGRqXR/lSFJdT/TbbsD18OJsk
         XZpw==
X-Received: by 10.68.200.72 with SMTP id jq8mr39338391pbc.91.1441047228114;
        Mon, 31 Aug 2015 11:53:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1937:16f4:ede1:6d38])
        by smtp.gmail.com with ESMTPSA id i8sm8913467pbq.31.2015.08.31.11.53.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 31 Aug 2015 11:53:47 -0700 (PDT)
In-Reply-To: <1440724495-708-4-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 27 Aug 2015 18:14:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276909>

Stefan Beller <sbeller@google.com> writes:

> +		char *s = (char*)sm_gitdir;

	char *s = (char *)sm_gitdir;

Many other places have similar, also in 7/9.
