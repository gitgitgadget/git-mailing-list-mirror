From: chris <jugg@hotmail.com>
Subject: Re: [PATCH/RFC 2/2] receive-pack: hint that the user can stop
Date: Fri, 7 Feb 2014 16:47:24 +0000 (UTC)
Message-ID: <loom.20140207T174346-134@post.gmane.org>
References: <CACsJy8B0WKfxSYBSgRZQYz6_h+S9pGd03A=rrWM0_twRdKvyZw@mail.gmail.com> <1391496765-29564-1-git-send-email-pclouds@gmail.com> <1391496765-29564-2-git-send-email-pclouds@gmail.com> <xmqqha8eag6c.fsf@gitster.dls.corp.google.com> <xmqqd2j2afup.fsf@gitster.dls.corp.google.com> <loom.20140207T133319-524@post.gmane.org> <CACsJy8CksVA609ksj5BkiOmAzOJ0aoKnHrZfeUSAKzxNy2qO7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 07 17:50:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBod8-0005gG-7s
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 17:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277AbaBGQuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 11:50:08 -0500
Received: from plane.gmane.org ([80.91.229.3]:35745 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752232AbaBGQuE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 11:50:04 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WBoct-0005Tv-QX
	for git@vger.kernel.org; Fri, 07 Feb 2014 17:50:03 +0100
Received: from 125-224-243-140.dynamic.hinet.net ([125.224.243.140])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Feb 2014 17:50:03 +0100
Received: from jugg by 125-224-243-140.dynamic.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Feb 2014 17:50:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 125.224.243.140 (Mozilla/5.0 (X11; Linux i686; rv:27.0) Gecko/20100101 Firefox/27.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241775>

Duy Nguyen <pclouds <at> gmail.com> writes:
> On Fri, Feb 7, 2014 at 7:36 PM, chris <jugg <at> hotmail.com> wrote:
> > Junio C Hamano <gitster <at> pobox.com> writes:
> >> Instead of adding a boolean --break-ok that is hidden, why not
> >> adding an exposed boolean --daemonize, and let auto-gc run in the
> >> background?  With the recent "do not let more than one gc run at the
> >> same time", that should give a lot more pleasant end user
> >> experience, no?
> >
> > That sounds quite useful to me.  Duy, are you up for generating such a
patch?
> 
> It would not be so hard for that patch. I'm still thinking whether it
> should be done if auto-gc is started on the client side too (sometimes
> it does, which is equally annoying)..

That could be nice, but I'd be less concerned about that, as the client has
the ability to disable gc for itself.  Still pushing it into the background,
if considered acceptable behavior, seems reasonable.  Perhaps two separate
patches?

Chris
