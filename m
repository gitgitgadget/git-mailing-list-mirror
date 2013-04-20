From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [QUERY] Why do we have git-completion.zsh?
Date: Sat, 20 Apr 2013 11:53:29 -0700
Message-ID: <20130420185329.GB8586@elie.Belkin>
References: <CALkWK0=NrJ-9mxSkOBw=kJ0CTJLUFNWBoGdqGcHEU6YqR-foFg@mail.gmail.com>
 <20130420184539.GA8586@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 20 20:53:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTcut-0003Ao-2d
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 20:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359Ab3DTSxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 14:53:38 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:40858 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992Ab3DTSxh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 14:53:37 -0400
Received: by mail-pd0-f174.google.com with SMTP id p12so2823337pdj.19
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 11:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=RijoC9pCd764hPYW27DF3vNSzrFpU/CoVr72YDvHUrc=;
        b=zf3UjoygzaVd4Jqe4Lquvahm7M8UuJAxcRRa50wX1p6t/KudmT7UOzJeNm6V11TnRi
         8DHvfeEuyESjpCYZ/AZG+ZamL97bDi/7M+uKBeE00mslw+XNWraSS5rTSg+X8bdBODmf
         I8r7ufSjKV/atffgOhvabcB4f0DBT8er9Jj7K2RKhSZ6UYg44FxtzdsLuUx+Y3bjxCUx
         nGixQJZWtKLE+ekd9kUV/vwMfkUtTMmSRIamjcKh7BUi61JugClo0Mdo/WP1e4W+4uS1
         fzEhbAUzQsz1dqgNeGMZE7D5liv0lHli3S9bk8yU/x3KqdKukJgIyKsz6BGzay7904+T
         Arew==
X-Received: by 10.66.89.199 with SMTP id bq7mr8518926pab.202.1366484017136;
        Sat, 20 Apr 2013 11:53:37 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id fq1sm18118847pbb.33.2013.04.20.11.53.35
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Apr 2013 11:53:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130420184539.GA8586@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221872>

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:

>>                             However, I don't understand why we
>> maintain it, because there's a comprehensive first-class completer in
>> ZSH core [1] which I use all the time.  Shouldn't the completion folks
>> be contributing to this instead?
>
> Only if they want to.
[...]
> http://thread.gmane.org/gmane.comp.version-control.git/210022/focus=210024

Sorry, wrong link.  Here's a better one:

http://www.zsh.org/mla/workers/2011/msg00497.html

More fundamentally, your question seems to assume some kind of shared
plan regarding what people work on, rather than each person choosing
to work on what they consider valuable without having to justify it to
others.  I am very happy with Felipe's work on git's completion code
and don't think it does any harm to efforts elsewhere.

Thanks for your interest,
Jonathan
