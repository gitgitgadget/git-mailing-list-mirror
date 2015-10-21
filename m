From: Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v3 1/1] Makefile: link libcurl before libssl
Date: Wed, 21 Oct 2015 18:44:06 +0200
Message-ID: <20151021164406.GC13308@cruxbox>
References: <1444073043-24618-1-git-send-email-repk@triplefau.lt>
 <20151005194134.GD11993@google.com>
 <20151005201619.GA386@cruxbox>
 <xmqqsi5570n1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 18:44:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZowUf-00024V-HR
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 18:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700AbbJUQoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 12:44:00 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:46538 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbbJUQn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 12:43:59 -0400
Received: from mfilter31-d.gandi.net (mfilter31-d.gandi.net [217.70.178.162])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id 829D7A80B9;
	Wed, 21 Oct 2015 18:43:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter31-d.gandi.net
Received: from relay3-d.mail.gandi.net ([IPv6:::ffff:217.70.183.195])
	by mfilter31-d.gandi.net (mfilter31-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id mYcZkhPfCgCs; Wed, 21 Oct 2015 18:43:56 +0200 (CEST)
X-Originating-IP: 81.57.43.44
Received: from localhost (mon75-1-81-57-43-44.fbx.proxad.net [81.57.43.44])
	(Authenticated sender: repk@triplefau.lt)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 490C3A80AD;
	Wed, 21 Oct 2015 18:43:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqqsi5570n1.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279989>

On Tue, Oct 20, 2015 at 01:20:18PM -0700, Junio C Hamano wrote:
> Remi Pommarel <repk@triplefau.lt> writes:
> 
> > On Mon, Oct 05, 2015 at 12:41:34PM -0700, Jonathan Nieder wrote:
> > ...
> >> To protect against a value that might leak in from the environment, this
> >> should say
> >> 
> >> 	IMAP_SEND_LDFLAGS =
> >> 
> >> [...]
> >
> > Oups my bad.
> > ...
> 
> So, what's the status of this patch and other two patches (I
> consider them as a three-patch series)?

So I have to fix the non initialized variable and to rephrase a litle
bit the description for this patch. Taking libssl as an example is
misleading, zlib is more appropriate. I'll resend another version shortly.

For patch "[PATCH v3 1/1] Makefile: make curl-config path configurable"
it has been reviewed by Jonathan Nieder with a litle modification to be
squashed in. I can resend a squashed in version if it is easier for you.

Sorry for the delay.

Thanks
