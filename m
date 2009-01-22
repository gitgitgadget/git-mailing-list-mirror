From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [PATCH] contrib: A script to show diff in new window while editing
 commit message.
Date: Wed, 21 Jan 2009 22:39:55 -0500
Message-ID: <4977EA8B.8000403@tedpavlic.com>
References: <4977A2C9.1070502@tedpavlic.com> <1232577906-868-1-git-send-email-ted@tedpavlic.com> <7vy6x4b48e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 04:41:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPqRd-0004Hf-R1
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 04:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756367AbZAVDkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 22:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756358AbZAVDkA
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 22:40:00 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:43938 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756312AbZAVDj7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jan 2009 22:39:59 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id BE8D080D8029;
	Wed, 21 Jan 2009 22:34:01 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AHxqOYUMVFpF; Wed, 21 Jan 2009 22:34:01 -0500 (EST)
Received: from TedBook.local (cpe-76-181-62-78.columbus.res.rr.com [76.181.62.78])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 7C2D480D8021;
	Wed, 21 Jan 2009 22:34:01 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <7vy6x4b48e.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106713>

>   * Some people would like two-buffer operation and they may use this
>     script as their core.editor.

That's what I do, and evidently that's what enough Mercurial users do to 
warrant them putting "hgeditor" in their main distro (not even in the 
"contrib" directory). I just figured there must be at least a few other 
people out there like me, but maybe I'm wrong. <?>

>   * Other people (including me) would find it very natural to use "\C-x 2"
>     if they need to look at two places of the same buffer, because that is
>     what they are used to do when editing a long file every day.  They just
>     use "commit -v" without bothering with this script.

As I mention in the script, splitting windows (which is easy to do in 
Vim) is another very natural way to go. That being said, not all editors 
have terrific split window support. Plus, if you're going to do it 
often, it makes sense to wire up your editor to do it for you each time.

>   * Yet other people (like Dscho) would find it too late to have a chance
>     for final review when writing a commit log message anyway, and won't
>     use either.

I'm not using the diff as a code review. I'm using it to help me make 
sure my commit message is complete.

> Having said that, if the lack of "final chance to review the diff" in some
> StGIT subcommand is the real problem you are trying to solve, I think it
...

Having the "stg edit" support is just a bonus (for me). The main point 
was showing how to use GIT_EDITOR to bring up a split window. As with 
Mercurial's hgeditor, part of the point of the script is to demonstrate 
how to customize the commit process.

Thanks --
--Ted

-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.
