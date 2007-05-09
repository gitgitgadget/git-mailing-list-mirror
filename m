From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Do not use absolute font sizes
Date: Tue, 08 May 2007 22:54:43 -0700
Message-ID: <7vvef2y21o.fsf@assigned-by-dhcp.cox.net>
References: <6efbd9b70705071613p23017509qaf9af12c1d14f9cb@mail.gmail.com>
	<20070509014150.7477.48489.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Wed May 09 07:54:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlf8U-0001E0-Uy
	for gcvg-git@gmane.org; Wed, 09 May 2007 07:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933223AbXEIFyq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 01:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933482AbXEIFyp
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 01:54:45 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:62738 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933223AbXEIFyp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 01:54:45 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070509055444.TARG13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 01:54:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id wtuj1W00T1kojtg0000000; Wed, 09 May 2007 01:54:44 -0400
In-Reply-To: <20070509014150.7477.48489.stgit@rover> (Petr Baudis's message of
	"Wed, 09 May 2007 03:41:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46664>

Petr Baudis <pasky@ucw.cz> writes:

> Avoid specifying font sizes in pixels, since that is just pure evil.
> Pointed out by Chris Riddoch.
>
> Note that this is pretty much just a proposal; I didn't test if everything
> fits perfectly right, but things seem to be pretty much okay. repo.or.cz
> uses it now as a test drive - if you find any visual quirks, please point
> them out, with a patch if possible since I'm total CSS noob and debugging
> CSS is an extremely painful experience for me.

This looks like going in the right direction, but...

>  gitweb/gitweb.css |   19 +++++++++----------
>  1 files changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
> index 6c662a1..df12d78 100644
> --- a/gitweb/gitweb.css
> +++ b/gitweb/gitweb.css
> @@ -1,6 +1,5 @@
>  body {
>  	font-family: sans-serif;
> -	font-size: 12px;
>  	border: solid #d9d8d1;
>  	border-width: 1px;
>  	margin: 10px;
> @@ -31,7 +30,7 @@ img.logo {
>  div.page_header {
>  	height: 25px;
>  	padding: 8px;
> -	font-size: 18px;
> +	font-size: 150%;
>  	font-weight: bold;
>  	background-color: #d9d8d1;
>  }
> @@ -113,7 +112,7 @@ span.signoff {
>  
>  div.log_link {
>  	padding: 0px 8px;
> -	font-size: 10px;
> +	font-size: 70%;
>  	font-family: sans-serif;
>  	font-style: normal;
>  	position: relative;

	[12, 18, 10] / 12 * 100 = [100, 150, 83.33]

why not use 83% for what were originally 10px?
