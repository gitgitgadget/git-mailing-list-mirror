From: Tim Visher <tim.visher@gmail.com>
Subject: Different Fetch and Push URLs?
Date: Fri, 26 Feb 2010 10:01:40 -0500
Message-ID: <c115fd3c1002260701u11cf506fq747d7217d31eba59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 26 16:02:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nl1hi-0005IL-98
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 16:02:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913Ab0BZPCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 10:02:04 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:59413 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964837Ab0BZPCC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 10:02:02 -0500
Received: by ywh35 with SMTP id 35so75206ywh.4
        for <git@vger.kernel.org>; Fri, 26 Feb 2010 07:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=U9+R8zWPZNxjuLF2veZOVaF2AYkQbcRLOHlr93qMbhc=;
        b=cHlHMNnKB5u1eNNZiRsfZOmrME5Fr3M6Udr5jNKmBwVJx/BwFi73NTApui8AcZBlf2
         rgNsCtUkX6LBqxnitNgRLgsPoEQVYfF7XfoEtEPFOwQyB0LK/6ppB2Pv3EDosiC5K2XU
         Jm/+xyeQse2FN7xbSGAUb8NlFwPkwdxTHuebs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=uRXz6516vcAShMNpQuuTsC5mnhpVNgoIykr3gz8N6VfhYLt+gpzJbQ4SRCaA/FbmbW
         6xq+O5dfi37euBPvXwB7u3vcUf0l+F4L5NABkRgRz3x7X5rqIY9LfVxrlLhPE1PBUR5A
         ABb8qpRS/mwwyLbuA1mViPCWqFA1ndNzoXHSQ=
Received: by 10.100.236.5 with SMTP id j5mr807234anh.60.1267196520189; Fri, 26 
	Feb 2010 07:02:00 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141131>

Hello Everyone,

My work situation leaves me in a situation where I can clone from my
central repo but I can't push there.  Is it possible and does it make
any sense to have a single remote with one URL that I pull from and
another than I push to?  I only ask because I was looking at the
output of `git remote show` and noticed that there are 2 URLs.  If it
is possible, how do I do it?  I looked in `.git/config` and there's
only 1 URL there.

I am aware that I could have 2 remotes and simply consciously remember
to only push to the one that I have access to.  This is what I usually
do but the scenario I describe above seems nicer to me.

Thanks!

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
