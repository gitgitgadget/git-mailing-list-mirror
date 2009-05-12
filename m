From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/2] completion: complete config variables for --get/getall/unset/unset-all
Date: Tue, 12 May 2009 01:12:14 -0700
Message-ID: <7vtz3q91up.fsf@alter.siamese.dyndns.org>
References: <1241832213-23070-1-git-send-email-bebarino@gmail.com>
	<1241832213-23070-2-git-send-email-bebarino@gmail.com>
	<1241832213-23070-3-git-send-email-bebarino@gmail.com>
	<20090509034438.GZ30527@spearce.org> <4A09071A.1030107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 10:13:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3n6w-0007Ca-8s
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 10:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756085AbZELINK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 04:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755855AbZELINI
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 04:13:08 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:61875 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754741AbZELING (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 04:13:06 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090512081214.SPKY2915.fed1rmmtao103.cox.net@fed1rmimpo03.cox.net>;
          Tue, 12 May 2009 04:12:14 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id qYCE1b0014aMwMQ04YCEje; Tue, 12 May 2009 04:12:14 -0400
X-Authority-Analysis: v=1.0 c=1 a=LjsILeEzNVMA:10 a=aikODBtY-mwA:10
 a=pGLkceISAAAA:8 a=PTHE8zbD4hxTqYNHOfwA:9 a=bpTVZpYIDxhAI9BB6ofJEv9vpMoA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <4A09071A.1030107@gmail.com> (Stephen Boyd's message of "Mon\, 11 May 2009 22\:20\:26 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118880>

Stephen Boyd <bebarino@gmail.com> writes:

> Shawn O. Pearce wrote:
>> These probably could have been one patch, since the function
>> is introduced only to support this one usage, and this patch
>> is only 4 lines larger than the function definition anyway...
>
> Seeing that this hasn't been picked up yet, I'm fine with this being
> squashed into one commit. Could you use this combination of the two
> messages for the commit?
>
> ---8<----
>
> Subject: completion: complete config variables for
> --get/getall/unset/unset-all

Hmm, shouldn't this just be

    Subject: completion: complete variable names for "git config" command

?
