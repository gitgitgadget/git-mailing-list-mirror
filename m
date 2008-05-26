From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: cvsimport in cron
Date: Tue, 27 May 2008 11:13:34 +1200
Message-ID: <46a038f90805261613v4ad72ddcxe6ee78fa0b54f89e@mail.gmail.com>
References: <17476529.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: barrymac <barrymac@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 01:14:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0ltd-00086y-Jh
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 01:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755450AbYEZXNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 19:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754919AbYEZXNh
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 19:13:37 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:5754 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647AbYEZXNh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 19:13:37 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1854880wfd.4
        for <git@vger.kernel.org>; Mon, 26 May 2008 16:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=dARi5946RSBLrX7GWGy2gWMJOEcf/FZYaAcc4mLKU8U=;
        b=cy21MQpNV0vx4dyt8uNf8B9MV3NsIim0xbU4FzPOa35Q2osOQHoQrDZWNggdZbFaesy78PsT3rna2ZJ1qz1rRNTaOvfR7s4ipbMI0Pa3JzIPT8n/V5QA9fxCUt1qE/6xHoUL0KiADWoaruZSqPWS7O74dJqbMuPGfqsovvO5x5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hAedVc857iikYnb4yyoHXYIb01xD9aZpYojYcWPcNquAZzsr/5EMrdw+Zsve9dora16Ff+d73sCW902UQjVYGBgaNJadkxHptlxzy12vztgjfs1ODSToD7w18NMMVOVrdkqggHT2RfT2F5IGp4FOZjutrnhF1RWAygUHJeiHpPg=
Received: by 10.143.10.15 with SMTP id n15mr200300wfi.307.1211843614736;
        Mon, 26 May 2008 16:13:34 -0700 (PDT)
Received: by 10.142.128.16 with HTTP; Mon, 26 May 2008 16:13:34 -0700 (PDT)
In-Reply-To: <17476529.post@talk.nabble.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82972>

On Tue, May 27, 2008 at 6:00 AM, barrymac <barrymac@gmail.com> wrote:
> Apologies if this is a standard mistake, I'm not very experienced with cron.
> I'm trying to run cvsimport commands from within a cron job but it always
> returns:

I've done this plenty, so it's known to work. Not sure why it's
failing in your case.

> I use ssh keys and have tested that they work  by using scp within the
> script. The script goes as follows:

That's a good start. Have you tried a cvs-over-ssh cvs operation from cron?

> It would also be nice if someone could tell me also how to log the output.

Just wrap the commandline in

  ( $cmd 2>&1) > /tmp/cvsimport.log

HTH, and tell us what the problem was - so the next one to bump into
it find the answer in the list ;-)

cheers,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
