From: Andreas Ericsson <ae@op5.se>
Subject: Re: ignoring file modes completely
Date: Sat, 05 Feb 2011 17:58:49 +0100
Message-ID: <4D4D81C9.5080002@op5.se>
References: <4D4D6BC2.90101@io.com> <1296921829.5467.1.camel@localhost.localdomain> <4D4D7636.7090608@io.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: rkitover@io.com
X-From: git-owner@vger.kernel.org Sat Feb 05 17:59:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PllTT-0004l7-0U
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 17:59:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619Ab1BEQ6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 11:58:54 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53913 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323Ab1BEQ6x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 11:58:53 -0500
Received: by wyb28 with SMTP id 28so3266545wyb.19
        for <git@vger.kernel.org>; Sat, 05 Feb 2011 08:58:52 -0800 (PST)
Received: by 10.216.153.147 with SMTP id f19mr602962wek.40.1296925132228;
        Sat, 05 Feb 2011 08:58:52 -0800 (PST)
Received: from [172.27.78.103] (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id b54sm1092723wer.45.2011.02.05.08.58.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Feb 2011 08:58:51 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Thunderbird/3.1.7 ThunderGit/0.1a
In-Reply-To: <4D4D7636.7090608@io.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166102>

On 02/05/2011 05:09 PM, Rafael Kitover wrote:
> On 2/5/2011 11:03 AM, Jared Hance wrote:
>> On Sat, 2011-02-05 at 10:24 -0500, Rafael Kitover wrote:
>>> Hello,
>>>
>>> I found the core.filemode option, which ignores executable bits, but I
>>> need an option to ignore all mode differences, and such an option does
>>> not seem to exist.
>>
>> The only mode tracked by Git is the executable bit, so this shouldn't
>> even be an issue. Are you sure the executable bit isn't the problem?
>>
> $ git config --global core.filemode
> false
> 
> Output of "git diff HEAD" :
> 
> diff --git a/Makefile.PL b/Makefile.PL
> old mode 100755
> new mode 100644
> diff --git a/t/02ads.t b/t/02ads.t
> old mode 100755
> new mode 100644
> diff --git a/t/02cxn.t b/t/02cxn.t
> old mode 100755
> new mode 100644
> diff --git a/t/04os.t b/t/04os.t
> old mode 100755
> new mode 100644

Those are all executable bit diffs.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
