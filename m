From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Subversion integration with git
Date: Tue, 30 Mar 2010 19:59:56 +0530
Message-ID: <f3271551003300729i340ee031r3151cad845e299be@mail.gmail.com>
References: <3311ED3F-77BC-4F66-80D5-AA9E21ACF0E2@cordelta.com> 
	<40aa078e1003250731y2c900605k9c681475621a1ff2@mail.gmail.com> 
	<E560EF9A-AF07-4316-9047-6D1A1802F743@cordelta.com> <f3271551003251052j5863af46i3066f0f42788ba3b@mail.gmail.com> 
	<52A6E51B-058C-4B06-A271-26219B388BE7@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Michael Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 16:30:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwcSa-0003Xh-Kl
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 16:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756422Ab0C3OaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 10:30:20 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:58391 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756406Ab0C3OaR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 10:30:17 -0400
Received: by ywh2 with SMTP id 2so5745934ywh.33
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 07:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=fumA8MPHfomOlnJm/S090smhoC09+Izt5IPpuYZafl8=;
        b=ZKvbYaLNfXy3mayLwkeppKbGDfovvQDJKb2hxxL5Sdu05StWAOgeZ28ilhwt6QXeHN
         NYyzDE/Jbh0bZJKHDFiq5Rk4XWpwmjWE65cAQEIJJBEyE/qYBx6AQHaAZejlmwcrI0nN
         g/IrWuZFHOuk76haIfjOo3CkxakzsikqTeWGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=jxak0cmZAOvTpoUh7z35mI0oCqzjn30ZdWcJvaHETMlnSrdl+ILnViCqbgUoOtKL5d
         pe+BwKnIKTg7kVZSLhmlwoInH0FGPQ33wPVsQ05fhYwKMT46ctULVHbf80RhYbt3+6Hh
         Lo/aTHkep+6bP7DKfmtUarLGxJulxmAcKbAvE=
Received: by 10.90.69.14 with HTTP; Tue, 30 Mar 2010 07:29:56 -0700 (PDT)
In-Reply-To: <52A6E51B-058C-4B06-A271-26219B388BE7@cordelta.com>
Received: by 10.91.161.39 with SMTP id n39mr864883ago.98.1269959416306; Tue, 
	30 Mar 2010 07:30:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143569>

Hi,

On Tue, Mar 30, 2010 at 7:35 PM, David Michael Barr
<david.barr@cordelta.com> wrote:
> I've started looking at the first piece of the pipeline, reading from a
> remote subversion URL. I stumbled upon rsvndump[2], which is
> GPLv3+ licensed and promises to produce a Subversion dump from
> a remote repository. This could be piped to my utility,
> svn-dump-fast-export[3], to produce suitable input for git fast-import.

In the latest version of my proposal, I've proposed to write a
mirroring tool which will basically be a stripped down version of
svnsync [1]. For testing, I therefore recommend that you use svnsync
instead of rsvndump because the former is included in the official
source tree. If however, you do a comparison and find that rsvndump is
actually a better alternative, let me know.

> I believe this would address the first two components of Ram's.
> proposal and allow more focus to be given to the interesting ones.
> That's presuming that I have a feature-complete release by the time
> the GSoC project begins.

That's fantastic! I suspect you haven't looked at the latest revision
of my proposal. Since Gmane doesn't seem to have indexed it, I just
sent you a mail off the list.

-- Ram
