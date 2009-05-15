From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <poststelle@suesserott.de>
Subject: Re: [PATCH] gitk: Added option 'Simple history' to the options menu
Date: Fri, 15 May 2009 21:59:19 +0200
Message-ID: <4A0DC997.9040604@suesserott.de>
References: <12417222593716-git-send-email-newsletter@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Dirk Suesserott <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Fri May 15 21:59:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M53ZD-0001Aj-Ia
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 21:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417AbZEOT7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 15:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757637AbZEOT7X
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 15:59:23 -0400
Received: from smtprelay10.ispgateway.de ([80.67.29.24]:58175 "EHLO
	smtprelay10.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757558AbZEOT7W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 15:59:22 -0400
Received: from [84.176.112.206] (helo=[192.168.2.100])
	by smtprelay10.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <poststelle@suesserott.de>)
	id 1M53Yu-0000oG-JN; Fri, 15 May 2009 21:59:20 +0200
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <12417222593716-git-send-email-newsletter@dirk.my1.cc>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119289>

Hi Junio,

some days ago I supplied a patch that adds the 
'--simplify-by-decoration' switch to gitk's options menu. This was 
inspired by Jakub Narebski's answer to 'How to restrict gitk to show 
only branch/merge commits?'.

Have you just missed it or didn't it qualify for inclusion? I didn't 
know that option and found it really helpful to get an overview about 
the history of my projects.

What do the others think?

Cheers,
     Dirk


Am 07.05.2009 20:50 schrieb Dirk Suesserott:
> When clicked, the option --simplify-by-decoration is added to gitk/git log.
> This yields to a simplified history where only decorated commits are shown,
> i.e. those with a yellow tag or a green branch flag.
> 
> Signed-off-by: Dirk Suesserott <newsletter@dirk.my1.cc>
> ---
>  gitk-git/gitk |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 1a7887b..f65cf2c 100644
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -3676,6 +3676,7 @@ set known_view_options {
>      {all     b    * "--all"          {mc "Use all refs"}}
>      {dorder  b    . {"--date-order" "-d"}      {mc "Strictly sort by date"}}
>      {lright  b    . "--left-right"   {mc "Mark branch sides"}}
> +    {smplhst b    . "--simplify-by-decoration"   {mc "Simple history"}}
>      {since   t15  + {"--since=*" "--after=*"}  {mc "Since date:"}}
>      {until   t15  . {"--until=*" "--before=*"} {mc "Until date:"}}
>      {limit   t10  + "--max-count=*"  {mc "Max count:"}}
