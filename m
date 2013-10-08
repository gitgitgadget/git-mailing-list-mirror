From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: gitk next/prev buttons
Date: Tue, 08 Oct 2013 13:50:51 -0400
Message-ID: <525445FB.6000806@xiplink.com>
References: <524A33E5.7090001@threeamdesign.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Lucas Sandery [three am design]" <lucas@threeamdesign.com.au>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 08 19:50:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTbQv-0007VQ-4z
	for gcvg-git-2@plane.gmane.org; Tue, 08 Oct 2013 19:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755278Ab3JHRux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Oct 2013 13:50:53 -0400
Received: from smtp106.ord1c.emailsrvr.com ([108.166.43.106]:51536 "EHLO
	smtp106.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751775Ab3JHRuw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Oct 2013 13:50:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp6.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id B40129811F;
	Tue,  8 Oct 2013 13:50:51 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp6.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 7777298163;
	Tue,  8 Oct 2013 13:50:51 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <524A33E5.7090001@threeamdesign.com.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235782>

On 13-09-30 10:31 PM, Lucas Sandery [three am design] wrote:
> The "next" and "prev" buttons are lacking consistency and logic. For RTL
> languages previous is almost always on the left, and next on the right. The
> words are contradictory, "next" actually goes to backwards chronologically,
> and "prev" goes forward. Could the positions of the buttons be switched and
> the text be replaced with "earlier" and "later"? This would make the
> reference time not just order, and would mean the updated UI would not be
> confused with the previous one.

I agree with you here (I like "older" and "newer" myself).

In theory gitk accepts the same arguments as "git rev-list", and in theory
you should be able to use things like --reverse to get the commits in a
different order.

However, in practice I don't think anyone futzes with the ordering much with
gitk.  gitk even ignores the --reverse and --timestamp options, and I've had
a hard time getting gitk to display commits in an order where "older" and
"newer" would not make sense.

> Also, the arrow-only next/previous buttons (beside the commit ID) should
> really point up and down. Horizontal directions are ambiguous for navigation
> of a vertical list.

Here I don't agree.  These arrows are purely about history navigation.  They
don't have anything to do with "up" or "down" in the list.  In that sense
they're more like the arrows in your web browser.

		M.
