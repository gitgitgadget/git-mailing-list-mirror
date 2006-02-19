From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: contrib/ area
Date: Sun, 19 Feb 2006 22:56:10 +0100
Message-ID: <87lkw7dnd1.fsf@wine.dyndns.org>
References: <7vmzgq451m.fsf@assigned-by-dhcp.cox.net>
	<873biikx6k.fsf@wine.dyndns.org> <43F8E0B8.20508@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 19 22:56:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAwXW-0005eg-VS
	for gcvg-git@gmane.org; Sun, 19 Feb 2006 22:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWBSV4T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Feb 2006 16:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWBSV4T
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 16:56:19 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:28826 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S932166AbWBSV4R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2006 16:56:17 -0500
Received: from adsl-84-227-24-172.adslplus.ch ([84.227.24.172] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FAwXN-0000yK-4n; Sun, 19 Feb 2006 15:56:16 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 66F0D4FAC2; Sun, 19 Feb 2006 22:56:10 +0100 (CET)
To: Sam Vilain <sam@vilain.net>
In-Reply-To: <43F8E0B8.20508@vilain.net> (Sam Vilain's message of "Mon, 20 Feb
	2006 10:18:48 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
X-SA-Exim-Connect-IP: 84.227.24.172
X-SA-Exim-Mail-From: julliard@winehq.org
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mail
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=AWL,BAYES_00,
	SPF_HELO_SOFTFAIL autolearn=no version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16453>

Sam Vilain <sam@vilain.net> writes:

> Alexandre Julliard wrote:
>> Is there interest in an emacs interface for git?  I posted a first
>> version (http://marc.theaimsgroup.com/?l=git&m=113313040724346&w=2)
>> some time ago, I'd be happy to send you a patch with my latest version
>> if you want to include it.
>
> Out of interest, why did you choose not to make this a vc- plug-in?

For the same reason that there are both vc-cvs and pcl-cvs modes, they
are completely different approaches to the user interface. The VC mode
is purely file-oriented, and is very limited in its ability to handle
project-wide changes. It has its uses, but IMO there's no way to
exploit the full capabilities of a tool like git (or even CVS) with
the VC interface.

-- 
Alexandre Julliard
julliard@winehq.org
