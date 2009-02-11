From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Wed, 11 Feb 2009 09:03:10 -0500
Message-ID: <4992DA9E.4040107@tedpavlic.com>
References: <20090205204436.GA6072@diku.dk> <4991814A.6050803@tedpavlic.com> <2c6b72b30902101029s72628a88n16473ee30f853198@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Wed Feb 11 15:06:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXFhn-00039z-7d
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 15:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181AbZBKODV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 09:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755080AbZBKODU
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 09:03:20 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:58865 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755014AbZBKODT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2009 09:03:19 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id EC17880D8036;
	Wed, 11 Feb 2009 08:56:47 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wRCHOObBp5Kb; Wed, 11 Feb 2009 08:56:47 -0500 (EST)
Received: from tedbook.mshome.net (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id D11EE80D8005;
	Wed, 11 Feb 2009 08:56:47 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <2c6b72b30902101029s72628a88n16473ee30f853198@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109416>

> No upgrade should be necessary. Could you give me some information
> about what terminal application you are using. Also, have you added
> any specific color settings to ~/.tigrc?

OS X 10.4.11
iTerm 0.9.6.1201
TERM=xterm-color

I have no ~/.tigrc

>> If I hit<CR>  a few more times (to move the screen) and then hit "j" more
>> (to move the highlighted line), I get this same bug randomly on different
>> lines.
>
> This is a good hint. Does it happen a mostly when you hit "j" and it
> causes the view to be scrolled down?

The problem only occurs with "j" and "k" when viewing multi-line 
displays. I do /not/ see the problem when viewing the one-line changeset 
history. It only causes a problem when I view the multi-line displays 
(e.g., when actually viewing a changeset).

For example, in git.git, if I "tig" and then scroll through the 
changesets, I don't see the problem. If I <CR> on a changeset so that it 
opens in the bottom half of the screen, I see the problem when I start 
"j" and "k"'ing there.

Thanks --
Ted



-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.
