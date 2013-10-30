From: Nicolas Cornu <ncornu@aldebaran-robotics.com>
Subject: Re: [PATCH v2] gitk: Add a horizontal scrollbar for commit history
Date: Wed, 30 Oct 2013 15:49:52 +0100
Message-ID: <CAMXp-VMOpBu1iUi4iQ008KyBJ5nKOpRntSSFyK+C0X8y0-J8tg@mail.gmail.com>
References: <1383130702-4966-1-git-send-email-ncornu@aldebaran-robotics.com>
	<5270F4FC.60900@viscovery.net>
	<CAMXp-VMku0eSQmmbdy-NQDedH4VSgZN5XmpTeBHvN8qX1=ersg@mail.gmail.com>
	<52711BB3.9040004@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	paulus@samba.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 15:49:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbX5o-0003LZ-SD
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 15:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754230Ab3J3Otx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 10:49:53 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:63581 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738Ab3J3Otw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 10:49:52 -0400
Received: by mail-ie0-f173.google.com with SMTP id u16so2414224iet.4
        for <git@vger.kernel.org>; Wed, 30 Oct 2013 07:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aldebaran-robotics.com; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FOi5elb9ZVEuF0+KcPoHqbyeMZ5nyKmtLPWrPMYe2rc=;
        b=AqU7it8IMiag3U4d5jHFgToEBQ19VeDhhoXoX+nA/9+2uQxw+VJ8XdoZUoLjZyRtfJ
         U04BCQyH2+w25yG+vXP9mRlu4vVFC+4oyzIjoe1UiM/ERzvTu0HGUqzAobU+mymjz+zj
         bbel+yEWmdYSBTYS7b8BKLhVdLBdxLV34eY14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=FOi5elb9ZVEuF0+KcPoHqbyeMZ5nyKmtLPWrPMYe2rc=;
        b=XxcFyb7qbZyg6p2CQuQWcqVVZvfMvHZuJjku9Kt7zVEVzIIo2qjkysLM8izwK7QHeo
         t4kyeoKyQdZZsyQej2JkWOAXCkly1Bgips6TERzNo08MckXBouGTO27+UWBXgCtKhYmf
         IGlqHCHi3HYtTOzRRxJ3WKF8fpM6SIpqhTiK7+TVEJUFOnT8YdN0gaI8NAiG/P4ZF/MW
         XyOONBraMDmLp4FzCza8q/ulsVNrvIldgtu6HyU6Qzt9gsYWh7oR+eM7Zns9xBV+rlKZ
         QKVIJvOLUr9UpbWYN78qUszCtD3mbpdgEFbk+UNz1aZKKanh2nCcQZmlHlsp8BLirHiz
         dqDA==
X-Gm-Message-State: ALoCoQmLbbtfJoPM+aM2PDNUwVoDS6OVGijFotRYF/yg+G7eEztGNWJKMAgek6lQcsor14gsmVO9
X-Received: by 10.50.103.6 with SMTP id fs6mr2773880igb.16.1383144592131; Wed,
 30 Oct 2013 07:49:52 -0700 (PDT)
Received: by 10.64.25.165 with HTTP; Wed, 30 Oct 2013 07:49:52 -0700 (PDT)
In-Reply-To: <52711BB3.9040004@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237020>

2013/10/30 Marc Branchaud <marcnarc@xiplink.com>:
> On 13-10-30 08:47 AM, Nicolas Cornu wrote:
>> This is useful on all our repos, every times, as we put a tag per day.
>> If the HEAD didn't move during 150 days, we got 150 tags.
>> So, it depends, maybe can I put it as an option in Edit > Preferences?
>
> Eek, even with a scrollbar, 150 tags seems like a lot to pan over.
Now, it works pretty well and is easier than mouse middle-click which
acts strangely for me.
>
> I've often thought it would be good for gitk to combine multiple ref names
> into some kind of dropdown or view-on-hover list.  (I don't know anything
> about Tcl/Tk, so I don't know what's feasible.)  So if a commit has more than
> a couple of branches (and/or tags), only show the first branch name along
> with a glyph indicating that there are more, and let the user click on (or
> hover over) that glyph to see all the branches (or tags -- that is, still
> keep the tags and branches displayed separately).
It doesn't change that if you got 150 tags, when you will show them
up, you will need to scroll.
>
>                 M.
>
