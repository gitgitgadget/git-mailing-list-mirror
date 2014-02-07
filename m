From: chris <jugg@hotmail.com>
Subject: Re: [PATCH/RFC 2/2] receive-pack: hint that the user can stop
Date: Fri, 7 Feb 2014 12:36:22 +0000 (UTC)
Message-ID: <loom.20140207T133319-524@post.gmane.org>
References: <CACsJy8B0WKfxSYBSgRZQYz6_h+S9pGd03A=rrWM0_twRdKvyZw@mail.gmail.com> <1391496765-29564-1-git-send-email-pclouds@gmail.com> <1391496765-29564-2-git-send-email-pclouds@gmail.com> <xmqqha8eag6c.fsf@gitster.dls.corp.google.com> <xmqqd2j2afup.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 07 13:36:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBkfu-00074d-6D
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 13:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891AbaBGMgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 07:36:50 -0500
Received: from plane.gmane.org ([80.91.229.3]:39468 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753749AbaBGMgt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 07:36:49 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WBkfm-0006yG-QT
	for git@vger.kernel.org; Fri, 07 Feb 2014 13:36:47 +0100
Received: from 125-224-243-140.dynamic.hinet.net ([125.224.243.140])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Feb 2014 13:36:46 +0100
Received: from jugg by 125-224-243-140.dynamic.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Feb 2014 13:36:46 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 125.224.243.140 (Mozilla/5.0 (X11; Linux i686; rv:26.0) Gecko/20100101 Firefox/26.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241769>

Junio C Hamano <gitster <at> pobox.com> writes:
> Instead of adding a boolean --break-ok that is hidden, why not
> adding an exposed boolean --daemonize, and let auto-gc run in the
> background?  With the recent "do not let more than one gc run at the
> same time", that should give a lot more pleasant end user
> experience, no?

That sounds quite useful to me.  Duy, are you up for generating such a patch?

Thanks,

Chris
