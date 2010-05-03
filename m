From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [patch 00/16] Portability Patches for git-1.7.1 (v4)
Date: Mon, 3 May 2010 01:48:34 +0000
Message-ID: <20100503014834.GC1550@thor.il.thewrittenword.com>
References: <20100427135708.258636000@mlists.thewrittenword.com>
 <4BD7032D.9050508@drmicha.warpmail.net>
 <4BDC744E.4050006@drmicha.warpmail.net>
 <7vk4rn2oiv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 03 03:54:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8kr8-0008Iv-9C
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 03:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754859Ab0ECBsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 21:48:41 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:65342 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403Ab0ECBsk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 21:48:40 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 198075CBE;
	Mon,  3 May 2010 02:05:04 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 198075CBE
Received: from thor.il.thewrittenword.com (thor.il.thewrittenword.com [10.191.57.1])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id D62DEA84;
	Mon,  3 May 2010 01:48:10 +0000 (UTC)
Received: by thor.il.thewrittenword.com (Postfix, from userid 1048)
	id 46099BAAE; Mon,  3 May 2010 01:48:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vk4rn2oiv.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146211>

Hi Michael,

Thanks for putting up a public repo of those patches; much
appreciated.

On Sat, May 01, 2010 at 04:25:12PM -0700, Junio C Hamano wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> > Gary V. Vaughan venit, vidit, dixit 27.04.2010 15:57:
> > > Here are the portability patches we needed at TWW to enable git-1.7.1
> > > to compile and run on all of the wide range of Unix machines we
> > > support. [[...]]
> >
> > OK, unsurprsingly, tests still pass on Linux (Fedora 12 x86_64).
> > If anyone wants to try, the series can be found at
> >
> > git://repo.or.cz/git/mjg.git
> >
> > in branch
> >
> > gvv/platform-compatibility
> >
> > applied cleanly on current master.
> 
> Thanks.  

Hi Junio,

> Like everybody else, I like the s/diff/test_cmp/ one in general.  On
> platforms without "diff -u", test_cmp may want to use "diff -c" instead
> for readability, but that can be fixed/enhanced independently.
> 
> I agree with your general remark and also noticed that the titles are way
> suboptimal.

I think this is my first patch series submission to the git list, but
in any case I just used used the patch file-names as is my habit for
locally maintained patchsets.

Thanks for suggesting better title, which I've already adopted into my
local tree.  If upstream integration stalls, or if it will help smooth
integration, I'll make the merging and reordering adjustments you
request and resubmit the whole queue.

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
