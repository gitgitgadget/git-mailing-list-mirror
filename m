From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: [PATCH] user-manual: add advanced topic "bisecting merges"
Date: Sun, 4 Nov 2007 12:23:02 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071104112302.GA2119@ins.uni-bonn.de>
References: <11941677732664-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Nov 04 12:23:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IodZZ-0003sS-GV
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 12:23:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756848AbXKDLXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 06:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756637AbXKDLXH
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 06:23:07 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:45154 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755847AbXKDLXF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 06:23:05 -0500
Received: from ins.uni-bonn.de (gibraltar [192.168.193.254])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id DEDA7400004AE;
	Sun,  4 Nov 2007 12:23:03 +0100 (CET)
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <11941677732664-git-send-email-prohaska@zib.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63380>

Hello Steffen,

A couple of language nits:

* Steffen Prohaska wrote on Sun, Nov 04, 2007 at 10:16:13AM CET:
> +Suppose that on the upper development line, the meaning of one
> +of the functions existed at Z was changed at commit X.  The

s/functions/& that/

> +commits from Z leading to A change both the function's
> +implementation and all calling sites that existed at Z, as well
> +as new calling sites they add, to be consistent.  There is no
> +bug at A.
[...]
> +You merge to create C.  There is no textual conflict with this
> +three way merge, and the result merges cleanly.  You bisect
> +this, because you found D is bad and you know Z was good.  Your
> +bisect will find that C (merge) is broken.  Understandably so,
> +as at C, the new calling site of the function added by the lower
> +branch is not converted to the new semantics, while all the
> +other calling sites that already existed at Z would have been
> +converted by the merge.  The new calling site has semantic
> +adjustment needed, but you do not know that yet.  You need to
> +find out that is the cause of the breakage by looking at the

s/that/that that/

> +merge commit C and the history leading to it.
[...]
> +If you linearlize the history by rebasing the lower branch on
> +top of upper, instead of merging, the bug becomes much easier to

s/upper/the &/

> +find and understand.  Your history would instead be:
[...]

Cheers,
Ralf
