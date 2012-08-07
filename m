From: John 'Warthog9' Hawley <warthog9@kernel.org>
Subject: Re: Android Replies to Git List getting rejected
Date: Tue, 07 Aug 2012 13:33:23 -0600
Message-ID: <50216D83.6080707@kernel.org>
References: <CAM9Z-nmEDTEN0Em-nY+y5g0kRMsNuy-pn8Lzr_mWSU7engj6JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 21:33:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SypX0-0004ZT-Uf
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 21:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756059Ab2HGTdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 15:33:25 -0400
Received: from shards.monkeyblade.net ([149.20.54.216]:56805 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639Ab2HGTdY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 15:33:24 -0400
Received: from voot-cruiser.eaglescrag.net (50-77-41-5-static.hfc.comcastbusiness.net [50.77.41.5])
	by shards.monkeyblade.net (Postfix) with ESMTPSA id 7DE0D5842A8;
	Tue,  7 Aug 2012 12:33:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120605 Thunderbird/13.0
In-Reply-To: <CAM9Z-nmEDTEN0Em-nY+y5g0kRMsNuy-pn8Lzr_mWSU7engj6JQ@mail.gmail.com>
X-Enigmail-Version: 1.4.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203040>

It's pretty simple: you sent HTML mail to vger.kernel.org, and it
explicitly rejects all HTML e-mail.  GMail, particularly from Android,
apparently doesn't have a way to bypass sending HTML mail (it's been a
much maligned bug).

Before you ask, no I very much doubt vger will change it's policy with
regards to HTML mail, and honestly it's a policy I fully support.

Your only bet is to use a mail client that won't send HTML, K-9 or
Kaiten should work.

- John 'Warthog9' Hawley

On 08/07/2012 01:24 PM, Drew Northup wrote:
> I am not 100% sure of the root cause of this, but I have gotten the
> following error message back from vger via GMail at least twice now:
> 
> "Delivery to the following recipient failed permanently:
> 
>       git@vger.kernel.org
> 
>  Technical details of permanent failure:
>  Google tried to deliver your message, but it was rejected by the
> recipient domain. We recommend contacting the other email provider for
> further information about the cause of this error. The error that the
> other server returned was: 550 550 5.7.1 Content-Policy reject msg:
> The message contains HTML subpart, therefore we consider it SPAM or
> Outlook Virus.  TEXT/PLAIN is accepted.! BF:<H 0.0255687>;
> S1755748Ab2HGTHS (state 17)."
> 
> I was replying to 20120806223113.GA16298@sigill.intra.peff.net
> (Subject: Re: [PATCH] Avoid crippled getpass function on Solaris).
> Hopefully all of the direct replies went through, but the list denied
> it. Some other replies have worked just fine.
> 
> Before the usual raft of "you configured your mail client incorrectly"
> I would like to note that such things are not configurable in the
> Android GMail App. If this is an app issue I'll (attempt to) take it
> up with them (and expect zero results). (I am writing this from the
> webmail interface in the hopes that it goes through.)
> 
> Am I the ONLY ONE seeing this?
> 
