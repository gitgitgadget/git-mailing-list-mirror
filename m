From: Antony Stubbs <antony.stubbs@gmail.com>
Subject: Re: cvs import and internal plumbing commands
Date: Sat, 18 Jul 2009 09:59:38 +1200
Message-ID: <FA5A96AF-5EC1-47B0-AF53-7163C804AE3D@gmail.com>
References: <B9FEA72A-882C-4CF9-97A3-A353F282ACBB@gmail.com> <20090716100121.GA6742@coredump.intra.peff.net> <7590CBC0-25BA-41D4-9BB5-40550A6CDDF6@gmail.com> <20090717214523.GA29955@coredump.intra.peff.net>
Mime-Version: 1.0 (iPhone Mail 7A341)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 17 23:59:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRvT6-0001GH-Sa
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 23:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757902AbZGQV7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 17:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757887AbZGQV7o
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 17:59:44 -0400
Received: from mail-px0-f185.google.com ([209.85.216.185]:34699 "EHLO
	mail-px0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756520AbZGQV7n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 17:59:43 -0400
Received: by pxi15 with SMTP id 15so772911pxi.33
        for <git@vger.kernel.org>; Fri, 17 Jul 2009 14:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=i/agu699rmJoDJhNPJELFyZrzReKGPIf8ulq/sjCLmE=;
        b=PegwgC0fZcFlCmiMkzBHdPxxos5SmC1MrTthtE+5k8A9GqNZP1Ps/Z6uub63p6k/dJ
         KNSdAG2ArY0UtMoDAciB8014UXrYla38FTIWd2U4EfGgzIwXlMZMh3jYdTcunn0tHBFG
         koZFu6OnN5nSap1oapR9OPF9fIb+eRPmlifMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:x-mailer:mime-version:subject:date:cc;
        b=nm8pjrBKWAjhZjV7JGPYygQeD7iCGMo1e0lWFycl4xpnUTb+08cEBKhrwHdLzyBei3
         pfZ+4b5ZviixfaHbDs9yBjxQQZ53TSHXhFkOiYG5JwtlDhkLjPelPPZCJCBfi8VjrFLb
         tb+gXVBtFkqnax3DkyTUPNzZ/0uu9Yu6B2eOg=
Received: by 10.115.32.1 with SMTP id k1mr2303438waj.66.1247867983496;
        Fri, 17 Jul 2009 14:59:43 -0700 (PDT)
Received: from ?121.90.28.174? ([121.90.28.174])
        by mx.google.com with ESMTPS id l30sm3657748waf.35.2009.07.17.14.59.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Jul 2009 14:59:41 -0700 (PDT)
In-Reply-To: <20090717214523.GA29955@coredump.intra.peff.net>
X-Mailer: iPhone Mail (7A341)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123492>

On 18/07/2009, at 9:45 AM, Jeff King <peff@peff.net> wrote:

> On Sat, Jul 18, 2009 at 09:44:08AM +1200, Antony Stubbs wrote:
>
>>> The old style commands should be in the execdir (e.g.,
>>> /usr/local/libexec/git-core). That directory should be placed at the
>>> beginning of the PATH when you run "git cvsimport".
>>
>> Ok cool, I'll have a look when I get home.
>>
>> But should we not migrate it for the future anyway? An at least that
>> way it would work by default, in this environment?
>
> Yes, I think it is reasonable to migrate it in any case, if only  
> because
> it serves as an example when people read it, and we are trying to
> encourage the dashless form.

Great - ok, is there anything else I need to do re the patch I wrote,  
in your opinion?

--Antony
