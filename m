From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Versioning configuration files on a server: fatal: Unable to
 create '//etc/.git/index.lock': No such file or directory
Date: Thu, 18 Nov 2010 23:07:39 +0700
Message-ID: <AANLkTi=mf_1HaJ0qZJ4nG1=zti9CJdTZHAfhLayR4FRS@mail.gmail.com>
References: <AANLkTi=UPWTeZP9uF+FGtsSs7wH3AmwdeLtsPJQnKvez@mail.gmail.com>
 <20101117112042.GX22067@login.drsnuggles.stderr.nl> <20101118155211.GE22067@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Albert Strasheim <fullung@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 18 17:08:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ71z-0004XJ-2S
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 17:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759477Ab0KRQIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 11:08:07 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40201 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759451Ab0KRQIE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 11:08:04 -0500
Received: by wyb28 with SMTP id 28so3392833wyb.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 08:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type;
        bh=T39dLLQRrC2Rblyw8F9wP0r9kmvIFiUc3slY5brXotg=;
        b=WYASvdjKxYcK5SCyaLdoJAtGDX3fCgRHvuJMdHgahwQiQXQzy/dQEOROSyGEFwyVas
         fRYxuF9a+yaAA/SUoeuNinSRWzdsLFeaTcKQ/UlWHQZqMM2jaMAQIsbCmF1PA06GhnMQ
         V8xqraOCWsZ41i5K5/L+SnqTstCq2orjYUk34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=N9KAy/N9fDm17xHNJTiSx83LSMa7oxEozM+8F3aFovjjjNpRFIQHgPwo0Ov81kfEbP
         S+elCqzPx2NzKCf7Jj/k72vP0hofJ9PwwIOWhpkzq812JXoLBgO2VChF/DPHjpCHaW6z
         39eJ1H5OwQVYU4GCetqxtP8v9jGNTPzKCHKD4=
Received: by 10.216.166.68 with SMTP id f46mr3252328wel.26.1290096481173; Thu,
 18 Nov 2010 08:08:01 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Thu, 18 Nov 2010 08:07:39 -0800 (PST)
In-Reply-To: <20101118155211.GE22067@login.drsnuggles.stderr.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161679>

On Thu, Nov 18, 2010 at 10:52 PM, Matthijs Kooijman <matthijs@stdin.nl> wrote:
> Hi all,
>
>> I've been using git for exactly this purpose succesfully for a while now
>> (git 1.5.6.5 from Debian stable and I think also 1.7.2.3 from Debian
>> testing).
> Coming back to the testing machine I was using this on, I see this
> problem as well now. I'm pretty sure it wasn't there before, which would
> mean it was introduced by a recent upgrade.
>
> Checking the logs shows that I was running 1.7.1 before, and now 1.7.2.3
> is broken. Downgrading to 1.7.1 indeed removes the problem.
>
> I've rummaged around in the source a bit, haven't found the cause yet
> (and I'm out of time now).
>
> The issue also still occurs with a fairly recent git master (ca209065f:
> completion: fix zsh check under bash with 'set -u').

You may be interested in 72ec8ba (Support working directory located at
root - 2010-02-14). t1509 reports the breakages. Unfortunately this
kind of tests can't be run automatically
-- 
Duy
