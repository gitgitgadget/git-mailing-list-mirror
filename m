From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Object Permissions
Date: Thu, 21 Feb 2008 12:58:50 -0800
Message-ID: <7vir0it4ad.fsf@gitster.siamese.dyndns.org>
References: <47BDDF27.2030603@bluelane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, piet.delaney@gmail.piet.net
To: pete@bluelane.com
X-From: git-owner@vger.kernel.org Thu Feb 21 22:00:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSIWB-0000sL-Bx
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 21:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933988AbYBUU7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 15:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765849AbYBUU7F
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 15:59:05 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50433 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933925AbYBUU7D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 15:59:03 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1351026AF;
	Thu, 21 Feb 2008 15:59:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5BCE926AD; Thu, 21 Feb 2008 15:58:57 -0500 (EST)
In-Reply-To: <47BDDF27.2030603@bluelane.com> (pete@bluelane.com's message of
 "Thu, 21 Feb 2008 12:29:27 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74658>

Pete/Piet Delaney <pete@bluelane.com> writes:

> I've been trying to us the git repo in a
> centralize pull, push model where the
> developers pull the repo, checkout a
> branch, commit and then push back to the
> common repo.
>
> Problem is that the objects get set with
> the ownership of the user (at least when
> pulling with this format:
>
> ~    git clone git:/home/git/blux
>
> Amy suggestions on how to do this?

"man git-config" and look for core.sharedrepository, perhaps?
