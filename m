From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Outdated and broken online versions of user-manual.html
Date: Mon, 20 May 2013 00:24:39 -0700
Message-ID: <20130520072439.GF2919@elie.Belkin>
References: <20130510190229.GA31708@odin.tremily.us>
 <loom.20130511T092853-808@post.gmane.org>
 <BE32A698F2774BD5B5235264B13A46C8@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Ackermann <th.acker@arcor.de>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon May 20 09:24:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeKSe-0007V4-Kc
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 09:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483Ab3ETHYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 03:24:44 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:46806 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab3ETHYo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 03:24:44 -0400
Received: by mail-pd0-f174.google.com with SMTP id 14so745524pdj.5
        for <git@vger.kernel.org>; Mon, 20 May 2013 00:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=VKxMFmI7ZY+J3e1WI54bbLIGnpPVIsiGKZ8o7irwfbE=;
        b=tTfR8225+D5dxf8jI9YW2CMBeZtuyBknmR/Wjp8cSe4aFUA/9B+RTkmSlUtHydNc96
         A7zuhtqKvph/OuXhBXJc1jWo4xOiamfo9erZMpduKp4H4pkpoNarzKo3ComfIbwIO+HW
         NZS/xlAMQxVKQfzEvN4Tojm/UQtq3/dFOaFsu25CRf9CmubPl5pjTyPMvKqFiF2ZlbJV
         vDJSvlc6DxXd+BNbPXuyL8RjyjnHqLU1HzeFGs1hWQRjJV83ZVBFQ1VvtnSG2fhFh7lx
         X4uBKwueWlJy+SPkog+VGwRYbhEs75R7zsKVSMq7wEmhe0n8ixcERP+oJuit7qBh6cGR
         x2aA==
X-Received: by 10.66.193.136 with SMTP id ho8mr18579953pac.27.1369034683670;
        Mon, 20 May 2013 00:24:43 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id fn9sm24637587pab.2.2013.05.20.00.24.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 May 2013 00:24:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BE32A698F2774BD5B5235264B13A46C8@PhilipOakley>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224942>

Philip Oakley wrote:
> From: "Thomas Ackermann" <th.acker@arcor.de>

>> (5) Large overlapping with the tutorials. IMHO all of the
>> tutorials should be blended into user-manual
[...]
> I would be a little cautious of your point 5 if it squoze everything into
> one overlong document at the expense of losing the shorter documents - one
> can't eat a whole melon in one bite ;-)

Yes.

Once there was a lovely file at

	Documentation/howto/isolate-bugs-with-bisect.txt

explaining how to use "git bisect" to find which commit caused a
kernel regression.  That it was a small independent file that didn't
assume the reader had read much before was very helpful, since it
meant people could easily point novices to that page and say "It's
easy!" when asking them to track down a bug.

Nowadays that content is gracefully included in the user-manual under
the heading [[using-bisect]].  But I never point people to it any more;
I just write out the steps by hand, to avoid intimidating them.

Ideally this content would be in an EXAMPLE or TUTORIAL section of the
git-bisect(1) manpage for easier reference.

Thanks,
Jonathan
