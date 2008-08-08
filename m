From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: add a target which will abort compilation with
 ancient shells
Date: Fri, 08 Aug 2008 13:19:00 -0700
Message-ID: <7vwsirb6q3.fsf@gitster.siamese.dyndns.org>
References: <BUkcoxp99ASidQD8sGQ9PR7w1MT6DXx-6v_djYMHRBKTs_wNXEO3hw@cipher.nrlssc.navy.mil> <S1hQNVU9hvkXWOErhlMRjqFKaCUFasuIfMwjO4N7QOvu1ddz9cU6_w@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Aug 08 22:20:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRYRY-0002Lx-Ua
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 22:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753786AbYHHUTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 16:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753751AbYHHUTJ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 16:19:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61190 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692AbYHHUTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 16:19:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 242C64EBAB;
	Fri,  8 Aug 2008 16:19:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7A2124EB7E; Fri,  8 Aug 2008 16:19:03 -0400 (EDT)
In-Reply-To: <S1hQNVU9hvkXWOErhlMRjqFKaCUFasuIfMwjO4N7QOvu1ddz9cU6_w@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Thu, 07 Aug 2008 14:06:26 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 40B1830A-6587-11DD-9105-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91709>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> This adds a make target which can be used to try to execute certain shell
> constructs which are required for compiling and running git.
>
> This patch provides a test for the $() notation for command substition
> which is used in the Makefile and extensively in the git scripts.
>
> The make target is named in such a way as to be a hint to the user that
> SHELL_PATH should be set to an appropriate shell. If the shell command
> fails, the user should receive a message similar to the following:
>
> make: *** [please_set_SHELL_PATH_to_a_more_modern_shell] Error 2
>
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
>
>
> Johannes Schindelin wrote:
>> Maybe we can even have some sanity check that tests if SHELL_PATH groks 
>> $()?
>
> how about this?

Thanks, both.  I think this is cute and at the same time the right thing
to do ;-).
