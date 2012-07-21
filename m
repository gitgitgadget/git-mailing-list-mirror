From: David Aguilar <davvid@gmail.com>
Subject: Re: git with large files...
Date: Fri, 20 Jul 2012 20:47:44 -0700
Message-ID: <CAJDDKr5vZz_DepYKvdu34G60fmm8V_Sv8FU+J6O-DLoum07+jA@mail.gmail.com>
References: <A18A933F-5627-4844-A4A6-B3AF244FD211@me.com>
	<86fw8mf3gp.fsf@red.stonehenge.com>
	<CACPiFC+a=46n-igTUBSDdpgDQyL4cz5vrcpurNBSsb+D1c0UnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Darek Bridges <darek.bridges@me.com>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 05:47:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsQfX-0002ga-Sh
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 05:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832Ab2GUDrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 23:47:46 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:38461 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816Ab2GUDrp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 23:47:45 -0400
Received: by vcbfk26 with SMTP id fk26so3525366vcb.19
        for <git@vger.kernel.org>; Fri, 20 Jul 2012 20:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+INLNzUYq5jE8GuEY0IRam7ltF0eib64Tm9byeLuLQU=;
        b=VO7fW83+22JVdAXzV9pon8jCC1M6kpz7NHYDwhyW3LxxTPlkWHK5Nps3SJyR6IdF4A
         zaaUNpkOb+cxYG1JBX4gRcWQVH/HQqx1E/KxZNEyc4nr9w1l59csJHNp+uGol0UK3j5E
         8Unimn/ywWH39DaiDlCJc0apSIH8zj9ZC3HKrNQgRgLbrbN7xPAneAI/BFFTFdjKhTTd
         zxagXYszN1113TN1PrZCwjMIRXKzrInW7+xGiJgWLhwAC517q7h9DWmI8eV+yUSD1I92
         LWRuJoVnGEOXbz5G1/Ll42bxFmJCE8tHkjMwedu19i77FqLABrlkWFwC3NNiYMK9Rw3t
         ZqWw==
Received: by 10.221.11.197 with SMTP id pf5mr6343242vcb.29.1342842464382; Fri,
 20 Jul 2012 20:47:44 -0700 (PDT)
Received: by 10.52.114.67 with HTTP; Fri, 20 Jul 2012 20:47:44 -0700 (PDT)
In-Reply-To: <CACPiFC+a=46n-igTUBSDdpgDQyL4cz5vrcpurNBSsb+D1c0UnA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201802>

On Fri, Jul 20, 2012 at 4:28 PM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> On Fri, Jul 20, 2012 at 6:54 PM, Randal L. Schwartz
> <merlyn@stonehenge.com> wrote:
>>>>>>> "Darek" == Darek Bridges <darek.bridges@me.com> writes:
>>
>> Darek> I use git for many things, but I am trying to work out the
>> Darek> workflow to use git for deployment.
>>
>> Don't.
>
> Heh. Best to keep in mind that it just doesn't work very well.
> git-bigfiles, git-annex might help you, but look at the docs and
> caveats carefully.
>
> Perhaps use rsync, unison work better for you.

I'm not sure if it was the "big files" part that Randal was responding
to.  IIUC it was the "using git for deployment" part.

Packaging tools (Makefiles, .rpm, .deb, etc) are a better suited for
deploying software.
-- 
David
