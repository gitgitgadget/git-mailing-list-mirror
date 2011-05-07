From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: Re: [PATCH v3 3/3] Add support for -p/--patch to git-commit
Date: Sat, 7 May 2011 10:55:05 -0700
Message-ID: <BANLkTi=Y5o=KP1LnkKqGq31Sqfn-ZZCGNA@mail.gmail.com>
References: <1304748001-17982-1-git-send-email-conrad.irwin@gmail.com>
	<1304748001-17982-4-git-send-email-conrad.irwin@gmail.com>
	<20110507104613.GA20375@kudu.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Valentin Haenel <valentin@fsfe.org>
X-From: git-owner@vger.kernel.org Sat May 07 19:55:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIlj9-0004IP-DC
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 19:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507Ab1EGRzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 13:55:07 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:41839 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865Ab1EGRzG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2011 13:55:06 -0400
Received: by yia27 with SMTP id 27so1481513yia.19
        for <git@vger.kernel.org>; Sat, 07 May 2011 10:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=TBw051ZCP0zNj/FOerHaKTcLR9AM9ctnlVaSxEGwHR0=;
        b=QGazH/X2Ns5eNZ0kKSR5IAi5Ez2ABOGIWEhrtI5nr3whfJh4jKcc+M/fd8to3nAkzc
         EXdbI2lSdylHuvU1WM24n3NJf3a88UouzqTKq0iKAxI11IZpJ/PaSXK/umZEwWJMRt1+
         ba+LLg3UL58wSW7vo6t2tERpiTKEViJcSBDMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ZEmawShb+2w0bqHEWmQQA+uNOzDatJijg4A/kv4HFk0G6fgOZ7NT684Cw79bZvSwHB
         xqFUmoCIrHpcitQQwQQXVKO1AEQm5UM3uVkirfIQ82/ZaYxDN6d3SUmXdOvjy9wYVAUf
         lIAFRcTPsu8Jow/ikbr2HrEAlG0v7otqkG9CY=
Received: by 10.236.175.7 with SMTP id y7mr396584yhl.444.1304790905371; Sat,
 07 May 2011 10:55:05 -0700 (PDT)
Received: by 10.236.110.176 with HTTP; Sat, 7 May 2011 10:55:05 -0700 (PDT)
In-Reply-To: <20110507104613.GA20375@kudu.in-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173056>

On Sat, May 7, 2011 at 3:46 AM, Valentin Haenel <valentin@fsfe.org> wrote:
> Since it uses the add--interactive.perl stuff, it would also be affacted
> by 'interactive.singlekey'. So it might be worth mentioning that in
> config.txt for sake of completeness. I currently have some patches that
> modify config.txt in this regard, cooking in next, see: 46b522c
>

Ok, I've re-rolled the 3rd patch to use documentation in a similar
manner to yours for consistency. (It actually links to the
documentation for git-add as opposed to hinting that more information
may be found there).

I've also created a fourth patch that applies to the merge of this
patch set with vh/config-interactive-singlekey-doc to add git-commit
to the list of commands affected by interactive.singlekey.

Thanks,
Conrad
