From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Small script to patch .spec for Suse
Date: Tue, 15 Nov 2005 13:47:22 -0800
Message-ID: <7vfypxinx1.fsf@assigned-by-dhcp.cox.net>
References: <200511151230.30030.Josef.Weidendorfer@gmx.de>
	<7vfypxlp8k.fsf@assigned-by-dhcp.cox.net> <437A46E4.5010909@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 22:48:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec8eF-0001dB-S9
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 22:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbVKOVrZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 16:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbVKOVrZ
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 16:47:25 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:14741 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751075AbVKOVrY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 16:47:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051115214658.RVNE15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 15 Nov 2005 16:46:58 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <437A46E4.5010909@zytor.com> (H. Peter Anvin's message of "Tue,
	15 Nov 2005 12:36:52 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11949>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Junio C Hamano wrote:
>> I've applied the patch from HPA to update it to git.spec already
>> in my tree, so your script would not work any more ;-)
>> But seriously, I suspect we should take a hint from the fact
>> that "git.spec.in" has ".in" in its name already.
>>
>
> I'd prefer to have just @@OPENSSH_PACKAGE@@ and @@EXPAT_PACKAGE@@ 
> instead of completely virtualizing the dependencies.  Less flexible to 
> be sure, but it makes it less confusing to read and fix.

Sounds good.
