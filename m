From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/9] Re-roll rr/revert-cherry-pick v2
Date: Fri, 9 Dec 2011 14:34:42 -0600
Message-ID: <20111209203442.GK20913@elie.hsd1.il.comcast.net>
References: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 21:34:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ79f-000581-Pl
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 21:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660Ab1LIUer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 15:34:47 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63624 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954Ab1LIUer (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 15:34:47 -0500
Received: by yenm11 with SMTP id m11so2408654yen.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 12:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+mkyZz5XHpXPNJH8zLAyl3Dx7eDsO8uD7DQAMpkShQE=;
        b=Z/Q+E47ukbdluhUUl0zSwrDTV9nJAydtI7c27Wp4pZcDyJGbYFP+AoTwO51kUw8Keh
         MDBjnUkznBNJzsWr7Je9SHyhxeIUs383XQCsdRyc/dDgzGNX1FBD9Qdc7ICPMmH+HH86
         FN6NQs8tb3XfNwKIrlDXAikYqNISpaYYuD0xc=
Received: by 10.236.136.38 with SMTP id v26mr14701128yhi.69.1323462886378;
        Fri, 09 Dec 2011 12:34:46 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id q5sm16841034yhm.7.2011.12.09.12.34.45
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 12:34:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186690>

Ramkumar Ramachandra wrote:

> - "revert: report fine-grained error messages from insn parser" arises
>   from Jonathan's request to split "revert: allow mixed pick and
>   revert instructions".

Just to be clear: I wasn't directly requesting that you do anything.
If I were, then you could carefully read my requirements, fulfill
them, and you would be done.

Instead, I was reviewing the patch and giving my reaction.  After
receiving that information, one has plenty of choices:

 - add documentation to avoid the confusion the reaction was based on
 - rework to fix the underlying problem that caused the reaction
 - think carefully about it, conclude that the reviewer is crazy, and
   ignore it
 - drop the patch
 - send out a call for help to get others to help work on the
   underlying problem
 - ask for clarification
 ...

>From my point of view as a reviewer, I am happiest when someone
figures out how I missed the point and comes up with some fix that
addresses the underlying problem instead (and, incidentally, gets rid
of the symptom that provoked my reaction on the way).

Well, you get the idea.
