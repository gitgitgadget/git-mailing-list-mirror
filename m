From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-svn.txt: mention how to rebuild rev_map files
Date: Wed, 25 Sep 2013 17:06:48 -0700
Message-ID: <20130926000648.GE9464@google.com>
References: <1379971145-8971-1-git-send-email-keshav.kini@gmail.com>
 <20130925194402.GA9464@google.com>
 <874n98qxqx.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Keshav Kini <keshav.kini@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 26 02:07:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOz6e-00023I-V3
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 02:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061Ab3IZAGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 20:06:53 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:62583 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab3IZAGw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 20:06:52 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so353415pdj.26
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 17:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Lw42X113mUZC7e6MtBJJewAEphNtcemGiXNVz+dfHzg=;
        b=wmLAnijkjsOzad0bmNjfYL72DOne4xlKr4LvbEMgkzjlffvw8+qjkAzx1yuJqxpS5O
         kvWM1VxOpcKLHpOHlFwJVn8qrZaMnBd3vQrkD0zm/w6p1+DggIPHAma1G0ovMN0LAVWh
         LhtkJl5904JBVo7r0lF/tgofhJaEH8Caf0SinX2mPVLr/u0W5AfSUzYsO8QBPcqa3YM7
         XLXTvUUArrVtXIRVc0YwxreLE5/mER/6lJJkBh9Key9Ad9pblJJbkHYNh3D7SyE+Opdz
         n9g8gu9u9j77X3P7aiGfAnhgQj2O7g6OcqkAlz/tIXBsDjuwJ2F9m8R1HrFGSbggWWY1
         rgZg==
X-Received: by 10.68.33.34 with SMTP id o2mr13203557pbi.128.1380154011910;
        Wed, 25 Sep 2013 17:06:51 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id dw3sm50310736pbc.17.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 17:06:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <874n98qxqx.fsf@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235384>

Keshav Kini wrote:

> I changed the wording of your first paragraph a bit according to what I
> thought it meant. Does it still convey what you wanted to convey, and is
> it still correct?
>
>         Mapping between Subversion revision numbers and Git commit
>         names.  In a repository where the noMetadata option is not set,
>         this can be rebuilt from the git-svn-id: lines that are at the
>         end of every commit (see the 'svn.noMetadata' section above for
>         details).

Sounds good.

> Also, I'm having a bit of trouble trying to get a definition to start
> with a '.' character in AsciiDoc.  Escaping the '.' produces a
> definition block, but with a literal '\' before the '.'.  If I don't
> escape the '.', asciidoc thinks it's a section heading or something. Is
> asciidoc just incapable of doing this, or am I missing something?

Oh.  Yeah, this can be a pain.  Quoting the filename with `backticks`
might work.  Writing $GIT_DIR instead of .git might be simpler (see
v1.5.3.2~18 "Documentation/git-config.txt: AsciiDoc tweak to avoid
leading dot", 2007-09-14).

Thanks,
Jonathan
