From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 01/02] ident.c: Use const qualifier when possible
Date: Sun, 15 Apr 2007 13:14:57 -0700
Message-ID: <7vslb12y4e.fsf@assigned-by-dhcp.cox.net>
References: <20070415155110.365070d8@gnut>
	<200704152106.51082.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 22:15:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdB7n-0001Ig-Hp
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 22:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651AbXDOUO7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 16:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753653AbXDOUO7
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 16:14:59 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:48885 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643AbXDOUO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 16:14:58 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070415201458.IUDI1266.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 15 Apr 2007 16:14:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id nYEy1W0011kojtg0000000; Sun, 15 Apr 2007 16:14:58 -0400
In-Reply-To: <200704152106.51082.andyparkins@gmail.com> (Andy Parkins's
	message of "Sun, 15 Apr 2007 21:06:49 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44513>

Andy Parkins <andyparkins@gmail.com> writes:

> On Sunday 2007, April 15, Luiz Fernando N. Capitulino wrote:
>
>> -static const char *env_hint =
>> +static const char const *env_hint =
>
> You can see then that
>
>  const char const *env_hint
>
> is redundant, it's simply saying twice that (*env_hint) is const.

I think he wanted to say

	static const char *const env_hint = ...
