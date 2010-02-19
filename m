From: Fabien <fabien.ubuntu@gmail.com>
Subject: Re: Is git over http (git-http-push) ready for production ?
Date: Fri, 19 Feb 2010 16:08:50 +0100
Message-ID: <hlm9i0$ghd$1@ger.gmane.org>
References: <hllp07$o78$1@ger.gmane.org> <20100219140419.GB31796@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 16:09:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiUTt-0001zW-R5
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 16:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017Ab0BSPJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 10:09:20 -0500
Received: from lo.gmane.org ([80.91.229.12]:56593 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751687Ab0BSPJT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 10:09:19 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NiUTl-0001ve-Tx
	for git@vger.kernel.org; Fri, 19 Feb 2010 16:09:17 +0100
Received: from lamppc10.epfl.ch ([128.178.154.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 16:09:17 +0100
Received: from fabien.ubuntu by lamppc10.epfl.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 16:09:17 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: lamppc10.epfl.ch
User-Agent: Thunderbird 1.5.0.14ubu (X11/20090319)
In-Reply-To: <20100219140419.GB31796@Knoppix>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140455>

Ilari Liusvaara wrote:
> 1.6.6 introduced Smart HTTP. It is much more efficient, can run hooks and
> has same kind of atomicity guarantees as ssh://, but it has few shorcomings:
> 
> - Requires server support (CGI script & Git 1.6.6+)
> - Hook messages don't work (at least with 1.6.6.X/1.7.0.X)
> - Requires 1.6.6+ on client side
> - Authentication still sucks (no surprise, auth with HTTP just plain sucks).

Ok, thanks ! I wasn't aware of this new feature.
I'll give it a try.
What do you mean by "Hook messages don't work" ?

Thanks.

--
Fabien
