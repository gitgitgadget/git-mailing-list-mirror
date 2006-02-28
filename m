From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] git-apply --whitespace=nowarn
Date: Mon, 27 Feb 2006 21:08:49 -0800
Message-ID: <7vy7zwt6hq.fsf@assigned-by-dhcp.cox.net>
References: <20060225174047.0e9a6d29.akpm@osdl.org>
	<7v1wxq7psj.fsf@assigned-by-dhcp.cox.net>
	<20060225210712.29b30f59.akpm@osdl.org>
	<Pine.LNX.4.64.0602260925170.22647@g5.osdl.org>
	<20060226103604.2d97696c.akpm@osdl.org>
	<Pine.LNX.4.64.0602261213340.22647@g5.osdl.org>
	<20060226202617.GH7851@redhat.com> <1141008633.7593.13.camel@homer>
	<Pine.LNX.4.63.0602271004130.5937@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060227011832.78359f0a.akpm@osdl.org>
	<7vhd6kxuea.fsf@assigned-by-dhcp.cox.net>
	<7v4q2kuvxk.fsf@assigned-by-dhcp.cox.net> <4403C303.70602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andrew Morton <akpm@osdl.org>
X-From: git-owner@vger.kernel.org Tue Feb 28 06:09:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDx6Y-00085b-Pj
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 06:08:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWB1FIy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 00:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWB1FIy
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 00:08:54 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:7340 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750781AbWB1FIx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2006 00:08:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060228050705.OQMM20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Feb 2006 00:07:05 -0500
To: A Large Angry SCM <gitzilla@gmail.com>
In-Reply-To: <4403C303.70602@gmail.com> (A. Large Angry's message of "Mon, 27
	Feb 2006 19:26:59 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16913>

A Large Angry SCM <gitzilla@gmail.com> writes:

> Junio C Hamano wrote:
>> Andrew insists --whitespace=warn should be the default, and I
>> tend to agree.  This introduces --whitespace=warn, so if your
>> project policy is more lenient, you can squelch them by having
>> apply.whitespace=nowarn in your configuration file.
>> Signed-off-by: Junio C Hamano <junkio@cox.net>
>
> I think this is wrong. The default policy of, non-security, tools
> SHOULD be the least restrictive and most flexible.

The reason is that --whitespace=warn does not refuse to apply
but spits out some warning messages.  Admittedly, going from
zero, any amount of new warning message makes it infinitely more
chatty, but then people can squelch it by having the
configuration option "apply.whitespace = nowarn".
