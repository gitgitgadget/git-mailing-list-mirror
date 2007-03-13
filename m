From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: Re: [PATCH, fixed version] git-fetch, git-branch: Support local --track via a special remote `.'
Date: Tue, 13 Mar 2007 17:24:38 +0100
Message-ID: <87k5xlf6wp.fsf@gmail.com>
References: <45F58A84.2000503@lu.unisi.ch>
	<7v4poplceh.fsf@assigned-by-dhcp.cox.net>
	<45F69939.6070909@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: bonzini@gnu.org
X-From: git-owner@vger.kernel.org Tue Mar 13 17:24:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HR9na-0007Gc-Pb
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 17:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030751AbXCMQYZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 12:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030765AbXCMQYZ
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 12:24:25 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:37959 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030751AbXCMQYY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 12:24:24 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l2DGOJq15008;
	Tue, 13 Mar 2007 17:24:19 +0100
In-Reply-To: <45F69939.6070909@lu.unisi.ch> (Paolo Bonzini's message of "Tue,
	13 Mar 2007 13:29:45 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.95 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42129>

Paolo Bonzini <paolo.bonzini@lu.unisi.ch> writes:

I've done it different, please see the mail:

Subject: [PATCH 2/3] git-fetch: Support the local remote "."

I've done it only modifying git-parse-remote.

[...]

>
> 	The failure, which I didn't see because I didn't have svn-perl
> 	bindings installed, was caused by my usage of "git-show-ref --heads"
> 	where I should have used plain "git-show-ref".

But it should be test in t5515. I've added tests for this.

Thanks,

  Santi
