From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: diff attribute ignored by show and log -p
Date: Thu, 17 Dec 2009 11:44:16 -0500
Message-ID: <76718490912170844i7d5f25d1hc32590b877dbf295@mail.gmail.com>
References: <76718490912162046k36e2a275gaf7672b38c7a63e4@mail.gmail.com>
	 <76718490912162123r49f9bd90n8e032c144d0cdbac@mail.gmail.com>
	 <20091217221740.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 17:44:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLJSk-0004yn-Aq
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 17:44:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764637AbZLQQoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 11:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764572AbZLQQoS
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 11:44:18 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:60948 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759493AbZLQQoS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 11:44:18 -0500
Received: by iwn1 with SMTP id 1so1558777iwn.33
        for <git@vger.kernel.org>; Thu, 17 Dec 2009 08:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=JNt50L/zOs5sB23SBjeq+jmOF9IiFI9uYWLQgZH0oU8=;
        b=LmQ/vIr1VGRg8rtgYUsKMEa7tZDn4kQ2c548NalbopCUi2RBUEIqH4bG3779eQyxtJ
         ytiqMEE8EUJ7BC2j/FpUB27rZz5hsoGZBNHWP9blxFQSngfczd98fYxYfwAjT9BQFony
         4HBfSZWcaG6n18GM70MgH5MDHUOflZ4T+5mVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=L8kF7drbWST4NgL/Tb4O/m3Mc7gWYZ12SRRd+WP8V7c8jCYOwPexw1X/grKlAd7G+D
         eVK9d4tZkrRUEYBtmX3i3QmGnnGJt9B5kNuxdu2z6CCWWWaA90eLMIyQCB+FcLOViS3B
         kIsKdC52xLtxLSX4vzPPy9JpkDuSkDGStvxO8=
Received: by 10.231.153.69 with SMTP id j5mr203814ibw.33.1261068256133; Thu, 
	17 Dec 2009 08:44:16 -0800 (PST)
In-Reply-To: <20091217221740.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135376>

On Thu, Dec 17, 2009 at 8:17 AM, Nanako Shiraishi <nanako3@lavabit.com> wrote:
> Quoting Jay Soffian <jaysoffian@gmail.com>
>
>>> But is apparently ignored by "git log -p" and "git show" which just
>>> use internal diff. Is this behavior intentional?
>>
>> Ah, --ext-diff, and the reasoning behind requiring it for log/show is
>> explained in 72909be.
>
> The need to give --ext-diff is mentioned in 72909be (Add diff-option
> --ext-diff, 2007-06-30) but its log message doesn't 'explain' why external
> diff isn't used by default and you need to pass that extra option.

"To prevent funky games with external diff engines, git-log and
friends prevent external diff engines from being called."

Seemed reason enough to me.

> Probably --ext-diff should be the default?

Or available via a config option anyway.

j.
