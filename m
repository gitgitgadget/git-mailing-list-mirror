From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v2] git-cherry.txt: Change symbol marks in graph.
Date: Thu, 02 Dec 2010 16:26:16 +0100
Message-ID: <4CF7BA98.8030803@drmicha.warpmail.net>
References: <4CF7543B.6060900@drmicha.warpmail.net> <8762vcs6in.fsf_-_@picasso.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Thu Dec 02 16:28:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POB5L-0007mT-Nv
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 16:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168Ab0LBP2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 10:28:34 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:38517 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932123Ab0LBP2d (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Dec 2010 10:28:33 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 59586820;
	Thu,  2 Dec 2010 10:28:33 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 02 Dec 2010 10:28:33 -0500
X-Sasl-enc: jrtrlhdZ2R+5AtpJNfmEcYrT+168aL9EtB12RL1l4Jqf 1291303713
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C35A15E6B17;
	Thu,  2 Dec 2010 10:28:32 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <8762vcs6in.fsf_-_@picasso.cante.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162709>

Jari Aalto venit, vidit, dixit 02.12.2010 13:28:
> The common commit were marked with a minus sign (-), but that is
> usually interpreted as something less or substracted. Use natural
> equal sign (=). Commits that are not in upstream were marked with plus
> sign (+) but a question mark (?) is visually a litle more striking
> (erect) in context where all other signs are "flat". It also helps
> visually impared to see difference between (= ... ?).
> 
> Signed-off-by: Jari Aalto <jari.aalto@cante.net>
> ---
>  Documentation/git-cherry.txt |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
>     Revised:
> 
>     >> +in the <upstream> branch are prefixed with a equal (=) sign, and those
>     >
>     > "an equal"
> 
> 
> diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
> index fed115a..f49eded 100644
> --- a/Documentation/git-cherry.txt
> +++ b/Documentation/git-cherry.txt
> @@ -19,13 +19,13 @@ the 'git patch-id' program.
>  Every commit that doesn't exist in the <upstream> branch
>  has its id (sha1) reported, prefixed by a symbol.  The ones that have
>  equivalent change already
> -in the <upstream> branch are prefixed with a minus (-) sign, and those
> -that only exist in the <head> branch are prefixed with a plus (+) symbol:
> +in the <upstream> branch are prefixed with an equal sign (=), and those
> +that only exist in the <head> branch are prefixed with a question mark (?) symbol:
>  
> -               __*__*__*__*__> <upstream>
> +               _*__*__*__*__> <upstream>
>                /
>      fork-point
> -              \__+__+__-__+__+__-__+__> <head>
> +              \__?__?__=__?__?__=__?__> <head>
>  
>  
>  If a <limit> has been given then the commits along the <head> branch up
> @@ -34,7 +34,7 @@ to and including <limit> are not reported:
>                 __*__*__*__*__> <upstream>
>                /
>      fork-point
> -              \__*__*__<limit>__-__+__> <head>
> +              \__*__*__<limit>__=__?__> <head>
>  
>  
>  Because 'git cherry' compares the changeset rather than the commit id

Well, that plus the patch to git-cherry itself which I saw before
without being there .|

Michael
