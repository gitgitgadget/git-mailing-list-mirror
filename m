From: Peter Williams <peter_ono@users.sourceforge.net>
Subject: Re: [HELP] Adding git awareness to the darning patch management system.
Date: Thu, 01 Dec 2011 09:47:58 +1000
Message-ID: <4ED6C0AE.9010703@users.sourceforge.net>
References: <4ED59232.3000807@users.sourceforge.net> <CALUzUxrcWB62jARtgifTOocGL4gEGXDFMiO=ppHXzFyUmb+3ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 01 03:28:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVwNb-0007OB-LA
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 03:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859Ab1LAC2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 21:28:00 -0500
Received: from nskntqsrv03p.mx.bigpond.com ([61.9.168.237]:47137 "EHLO
	nskntqsrv03p.mx.bigpond.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753822Ab1LAC17 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Nov 2011 21:27:59 -0500
Received: from nskntotgx01p.mx.bigpond.com ([60.231.88.110])
          by nskntmtas03p.mx.bigpond.com with ESMTP
          id <20111130234759.YHDX2063.nskntmtas03p.mx.bigpond.com@nskntotgx01p.mx.bigpond.com>;
          Wed, 30 Nov 2011 23:47:59 +0000
Received: from mudlark.pw.nest ([60.231.88.110])
          by nskntotgx01p.mx.bigpond.com with ESMTP
          id <20111130234759.FLJ23205.nskntotgx01p.mx.bigpond.com@mudlark.pw.nest>;
          Wed, 30 Nov 2011 23:47:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111115 Thunderbird/8.0
In-Reply-To: <CALUzUxrcWB62jARtgifTOocGL4gEGXDFMiO=ppHXzFyUmb+3ww@mail.gmail.com>
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at nskntotgx01p.mx.bigpond.com from [60.231.88.110] using ID pwil3058@bigpond.net.au at Wed, 30 Nov 2011 23:47:58 +0000
X-SIH-MSG-ID: ohwyFtT9TECznTh522DtQVUtlUy7/yU1v8pWRYIhuRwYUkTAuN/WS9SicqNRptuyxEATcAqGPnEiYKbgWoXUu8myIb1QYA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186158>

On 30/11/11 19:04, Tay Ray Chuan wrote:
> On Wed, Nov 30, 2011 at 10:17 AM, Peter Williams
> <peter_ono@users.sourceforge.net>  wrote:
>> I'm the author of the darning patch management system
>> <http://darning.sourceforge.net/>  and would like some help adding git
>> awareness to the system.  At this stage of the development, "awareness" is
>> fairly simple concept with two broad aims:
>
> That link says it "combines the strengths of quilt and mq and
> eliminates their weaknesses", but I don't see any info on why this is
> the case with your program;

Documenting this is on my todo list (but not at the top).

Quilt's weaknesses are documented on their website and my issues with MQ 
is that it (potentially) compromises the Mercurial repository and others 
to which it may push.  (MQ also has the problem that its current 
maintainers don't understand the workflow for which it was designed and 
are changing it to suit a different workflow.)

The repository compromise issue also applies to stgit.

Other things darning adds are:

1. tracking of copies and renames (not in quilt),
2. tracking changes to files' modes (not in quilt),
3. binary diffs (using git binary diff format for import/export), and
4. help managing addition of trailing whitespace by patches.

> it would be great it if you could provide
> a quick start guide (probably easier to show this with some commands
> in the CLI rather than GUI screenshots).

At this stage, the CLI is really only there to allow me to do script 
based testing of darning's internals and is not a fully capable 
interface.  However, if you look in the directory test-cli for files 
with a ".test" suffix you will find examples of their use.

>
> Have a look at StGit's tutorial
> http://www.procode.org/stgit/doc/tutorial.html (very similar to quilt
> and mq too) to see what I mean.

OK

Peter
