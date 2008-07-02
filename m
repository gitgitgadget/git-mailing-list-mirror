From: "Adam Brewster" <adambrewster@gmail.com>
Subject: Re: [PATCH/v2] git-basis, a script to manage bases for git-bundle
Date: Tue, 1 Jul 2008 22:16:21 -0400
Message-ID: <c376da900807011916j5a3032een4587619535061b72@mail.gmail.com>
References: <1214272713-7808-1-git-send-email-adambrewster@gmail.com>
	 <c376da900806301549r6044cd35r5a23baa405570808@mail.gmail.com>
	 <20080701095117.GC5853@sigill.intra.peff.net>
	 <c376da900807011836i76363d74n7f1b87d66ba34cd6@mail.gmail.com>
	 <76718490807011910p37ac9bcbjf9fa9748a2eb2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org,
	"Jakub Narebski" <jnareb@gmail.com>
To: "Jay Soffian" <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 04:17:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDruQ-0005Ka-Av
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 04:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758868AbYGBCQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 22:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758862AbYGBCQ3
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 22:16:29 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:45941 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756179AbYGBCQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 22:16:28 -0400
Received: by yw-out-2324.google.com with SMTP id 9so80090ywe.1
        for <git@vger.kernel.org>; Tue, 01 Jul 2008 19:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ARBuSY6NXWRqy2QnaE+dneirr7zfwpOJzRvkDJYAAzI=;
        b=OkYTOWVVZXSLEZg9YIPrhJNS8U5Wku0IYGHDRtTlxmNAbfPdV8jIFS+8Fs4LzX0MbQ
         ZgRVH2QMO6lPJT/YiSMzanWhnjgvWWfkHzDgMzMetBJeIzXGm2RMgWY59KQvl7L9AYZk
         qEsKA8XWNHDa95HCm6/DVjhUwAWhfohHcYqVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=kcXjzlJXVE8ABrK/p9ZbeeUBcUcEcN+T9mESR7WOArHESuaQ0GLCGjIfOlA0bFPT4n
         3a2GYgYHDuQAcQcxtJAhZbawrAz0nDK5O6ekS0sfV+Gu53Pbii1EwqOmbVglCOFU7Uek
         328WDaZIZTok7LupglrKFibNGRnp6aWv/Rr98=
Received: by 10.151.109.11 with SMTP id l11mr11721610ybm.138.1214964981598;
        Tue, 01 Jul 2008 19:16:21 -0700 (PDT)
Received: by 10.150.205.18 with HTTP; Tue, 1 Jul 2008 19:16:21 -0700 (PDT)
In-Reply-To: <76718490807011910p37ac9bcbjf9fa9748a2eb2e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87079>

On Tue, Jul 1, 2008 at 10:10 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> On Tue, Jul 1, 2008 at 9:36 PM, Adam Brewster <adambrewster@gmail.com> wrote:
>> Maybe I'm a idiot, but I can't find any built-in date to string
>> functions that do nice things like print the date the way the user
>> says he likes to look at dates.
>
> perldoc -f localtime
>

But of course one function returns two very different things depending
on what's on the left side of the equals sign.  That makes perfect
sense.

> j.
>

Thank you.
Adam
