From: Jun Hao <achilles.hao@gmail.com>
Subject: Re: [PATCH 4/7] commit: fix patch hunk editing with
Date: Tue, 11 Mar 2014 18:40:55 +0000 (UTC)
Message-ID: <loom.20140311T194024-418@post.gmane.org>
References: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com> <1394477377-10994-5-git-send-email-benoit.pierre@gmail.com> <20140310200756.GC24568@sigill.intra.peff.net> <CA+SSzV04KCGyTkFTtSx_9sYAZyh=UzHOPV6tf9JT82w_DsSLHg@mail.gmail.com> <20140311180020.GA28154@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 19:41:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNRcF-0003oZ-AK
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 19:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755037AbaCKSlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 14:41:23 -0400
Received: from plane.gmane.org ([80.91.229.3]:47347 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753892AbaCKSlW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 14:41:22 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WNRc8-0003jT-9L
	for git@vger.kernel.org; Tue, 11 Mar 2014 19:41:20 +0100
Received: from proxy-nj2.bloomberg.com ([69.191.241.48])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 19:41:20 +0100
Received: from achilles.hao by proxy-nj2.bloomberg.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 19:41:20 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 69.191.241.48 (Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243878>

Jeff King <peff <at> peff.net> writes:

> 
> Ah, you're right. I was thinking that our invocation of launch_editor
> also respected it. It does, but we never get there at all because
> use_editor is set to 0. So yeah, it really is just needed for the hook.
> 
> Your patch, even though it is a bigger change, keeps the setting to the
> minimal area, which is cleaner and more maintainable in the long run.
> 
> -Peff
> 

Oh, didn't realize GIT_EDITOR change is only for hooks. Good catch. I agree 
Benoit's patch is better for the long term.

Thanks - Jun
