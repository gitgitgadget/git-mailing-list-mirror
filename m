From: Andreas Ericsson <ae@op5.se>
Subject: Re: git & patterns
Date: Wed, 18 May 2011 15:07:16 +0200
Message-ID: <4DD3C484.2070102@op5.se>
References: <4DD3A402.3040802@hupie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ferry Huberts <mailings@hupie.com>
X-From: git-owner@vger.kernel.org Wed May 18 15:07:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMgTG-0004PO-Kg
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 15:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933106Ab1ERNHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 09:07:20 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42839 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933111Ab1ERNHT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 09:07:19 -0400
Received: by bwz15 with SMTP id 15so1401145bwz.19
        for <git@vger.kernel.org>; Wed, 18 May 2011 06:07:18 -0700 (PDT)
Received: by 10.204.74.7 with SMTP id s7mr1806809bkj.57.1305724038009;
        Wed, 18 May 2011 06:07:18 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id l1sm972577bkl.13.2011.05.18.06.07.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 18 May 2011 06:07:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Thunderbird/3.1.10 ThunderGit/0.1a
In-Reply-To: <4DD3A402.3040802@hupie.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173877>

On 05/18/2011 12:48 PM, Ferry Huberts wrote:
> Hi list
> 
> After reading the manual page for git describe it was not clear to me what
> kind of pattern the --match option should take. Was it to be
> a shell pattern (to be expected) or a regular expression pattern?
> 
> So I dug in the code to find fnmatch: shell pattern.
> 
> Now my question(s):
> - could the manual page be update to make this explicit please? (plus
> other manual pages talking about (shell) patterns)

Patches welcome.

> - could git start taking regular expression patterns please?
> 

I'm not the maintainer, but with my incredible powers of foresight I'll
take a wild stab at answering in his stead:
Not with the current argument, no, but introducing '--rematch' or '--rmatch'
to take a regular expression instead would probably be a welcome patch if
it's well done.


> I'm using the --match option on git describe to generate version
> information from and matching against a regular expression is soooo much
> more powerful and allows me to fully define my naming convention while
> shell patterns do not allow me to do so.
> 
> Or am I missing something?
> 

You're not, but we're missing the patch ;)
For my own needs, the fnmatch patterns work quite well.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
