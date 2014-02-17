From: Ingo Rohloff <lundril@gmx.de>
Subject: Re: error: src refspec refs/heads/master matches more than one.
Date: Mon, 17 Feb 2014 14:25:53 +0000 (UTC)
Message-ID: <loom.20140217T152313-730@post.gmane.org>
References: <20140214113136.GA17817@raven.inka.de> <87a9dt981o.fsf@igel.home> <CACsJy8BevKQaRLYMMv7bTjf_ZAOnkrimws519OyhGZz6_Vr_-A@mail.gmail.com> <xmqqy51dirjs.fsf@gitster.dls.corp.google.com> <20140215085355.GA15461@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 17 21:35:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFUuH-0007iJ-Gt
	for gcvg-git-2@plane.gmane.org; Mon, 17 Feb 2014 21:35:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688AbaBQUfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Feb 2014 15:35:07 -0500
Received: from plane.gmane.org ([80.91.229.3]:50521 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751847AbaBQUfG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Feb 2014 15:35:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WFUu7-0007YK-V0
	for git@vger.kernel.org; Mon, 17 Feb 2014 21:35:04 +0100
Received: from fw-hk.lauterbach.com ([194.25.174.98])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Feb 2014 21:35:03 +0100
Received: from lundril by fw-hk.lauterbach.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Feb 2014 21:35:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 194.25.174.98 (Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:27.0) Gecko/20100101 Firefox/27.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242267>

Duy Nguyen <pclouds <at> gmail.com> writes:
> Prevent is a strong word. I meant we only do it if they force
> it. Something like this..
> 

I would propose to make this even stronger:
Forbid to create any branches which start with any of:
- "refs/"
- "heads/"
- "remotes/"
- "tags/"

as long as you do not use the "force" option.

The idea here is that you also will not get ambiguities later when you pull
new branches into your repository.

so long
  Ingo
