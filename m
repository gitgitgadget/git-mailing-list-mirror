From: Nico Williams <nico@cryptonector.com>
Subject: Re: "Branch objects" (was: Re: cherry picking and merge)
Date: Thu, 7 Aug 2014 17:54:28 -0500
Message-ID: <CAK3OfOiEMm3FiP_1Ho12pvccsyWvC13BRJH+FpMRTNObM3j0iw@mail.gmail.com>
References: <CANQwDwcHSO+KwhZbo4BTcWnAWGWbJzNQ7CY2m3nq+p0t9uDeqg@mail.gmail.com>
	<20140806200726.GE23449@localhost>
	<alpine.LSU.2.00.1408071222510.13901@hermes-1.csi.cam.ac.uk>
	<20140807155828.GM23449@localhost>
	<alpine.LSU.2.00.1408071735410.23775@hermes-1.csi.cam.ac.uk>
	<20140807172207.GP23449@localhost>
	<alpine.LSU.2.00.1408071829470.13901@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Mike Stump <mikestump@comcast.net>,
	git discussion list <git@vger.kernel.org>
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Fri Aug 08 00:54:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFWZz-0006Nj-0C
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 00:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbaHGWyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 18:54:31 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:54100 "EHLO
	homiemail-a36.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751399AbaHGWya (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Aug 2014 18:54:30 -0400
Received: from homiemail-a36.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a36.g.dreamhost.com (Postfix) with ESMTP id A1B2477805B
	for <git@vger.kernel.org>; Thu,  7 Aug 2014 15:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=
	mime-version:in-reply-to:references:date:message-id:subject:from
	:to:cc:content-type; s=cryptonector.com; bh=oVz5ZLpwjphs5BGel28s
	XaEqvWg=; b=QxQRdoyQ4VYIJuzlJ8WVUgtj4QNwoMatAvC0h5DeYvGWnxy6dnkU
	TZ9hYvpGxIO7kUC6UtGSwo3z3m08Js0Mtd4Aj2y1WYcD3eXcc1/GzMl53xOQJBGj
	BYTQ0u+AnX6bNrQk63wDWRL0N4M/2a/NJXbSaSOmVGu+xJJxepfUkHQ=
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com [209.85.212.181])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a36.g.dreamhost.com (Postfix) with ESMTPSA id 52845778057
	for <git@vger.kernel.org>; Thu,  7 Aug 2014 15:54:30 -0700 (PDT)
Received: by mail-wi0-f181.google.com with SMTP id bs8so133127wib.2
        for <git@vger.kernel.org>; Thu, 07 Aug 2014 15:54:28 -0700 (PDT)
X-Received: by 10.180.75.17 with SMTP id y17mr508933wiv.3.1407452068969; Thu,
 07 Aug 2014 15:54:28 -0700 (PDT)
Received: by 10.216.231.131 with HTTP; Thu, 7 Aug 2014 15:54:28 -0700 (PDT)
In-Reply-To: <alpine.LSU.2.00.1408071829470.13901@hermes-1.csi.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254999>

On Thu, Aug 7, 2014 at 12:47 PM, Tony Finch <dot@dotat.at> wrote:
> Nico Williams <nico@cryptonector.com> wrote:
>> Either way I retain the old HEAD with some name.
>
> Hmm, yes, I can see that would work. However my previous workflow was
> rather branch-heavy and I found the accumulation of names annoying. I have
> not yet had enough usage out of git-repub to see if it goes too far in the
> direction of lack-of-names. A big omission is no opportunity to edit its
> commit messages.

Oh, I just read your script more carefully and looked at your example
history again.  You're using parent metadata in the commits to keep
the history alive without the extra names, correct?  *That* is
_clever_.  Hats off.  I may have to steal this script :)

Nico
--
