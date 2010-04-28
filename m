From: gary@thewrittenword.com (Gary V. Vaughan)
Subject: Re: [patch 00/16] Portability Patches for git-1.7.1 (v4)
Date: Wed, 28 Apr 2010 09:27:35 +0000
Message-ID: <20100428092735.GG36271@thor.il.thewrittenword.com>
References: <20100427135708.258636000@mlists.thewrittenword.com>
 <4BD7032D.9050508@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 28 11:34:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O73ed-00022G-K6
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 11:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496Ab0D1Jd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 05:33:58 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:50441 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370Ab0D1Jd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 05:33:58 -0400
X-Greylist: delayed 382 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Apr 2010 05:33:58 EDT
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id AF97B5CC7;
	Wed, 28 Apr 2010 09:48:45 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com AF97B5CC7
Received: from thor.il.thewrittenword.com (thor.il.thewrittenword.com [10.191.57.1])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id E32F3AEB;
	Wed, 28 Apr 2010 09:27:35 +0000 (UTC)
Received: by thor.il.thewrittenword.com (Postfix, from userid 1048)
	id DC765BAB4; Wed, 28 Apr 2010 09:27:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4BD7032D.9050508@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145983>

Hi Michael,

On Tue, Apr 27, 2010 at 05:30:53PM +0200, Michael J Gruber wrote:
> Gary V. Vaughan venit, vidit, dixit 27.04.2010 15:57:
> > Here are the portability patches we needed at TWW to enable git-1.7.1
> > to compile and run on all of the wide range of Unix machines we
> > support.  These patches apply to the git-1.7.1 release,  and address
> > all of the feedback from the previous three times I posted them to
> > this list, including fixing the massive testsuite failures I was
> > experiencing and taking into account that the ss_family fixes and
> > partial GMT_CMP_TEST fixes that have been pushed since my last post of
> > this patch queue.
> 
> General remark: None of your patches have a s-o-b line. If you want to
> have your patches in git you are required to sign-off on them (commit
> -s) in order to certify that you can submit them under the license terms
> of the project.

I didn't read SubmittingPatches carefully enough, sorry.  If
necessary, I can resubmit with the additional line?

> Your diff -> test_cmp are certainly something we want to have in any
> case. The code changes look ugly, honestly, making the code much less
> readable, but it seems to be the only way to make those older platforms
> and compilers happy. (Erik pointed out some good ways to reduce the
> uglyness somewhat.)

I think only the const-expr.patch changes are seriously ugly... but
then I'm perhaps used to staring at portable code all day.

> I can't test your target platform, but I would test the impact of the
> code and test changes on mine. Do you have your series somewhere to pull
> from?

I'm afraid not, though I can send you (off-list) a zip of the patch
series and a quiltrc to apply using quilt or repeated calls to gnu
potch, or if you prefer, a sumo-patch containing all the changes in
one file for gnu patch?

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
