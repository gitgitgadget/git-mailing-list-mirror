From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fetch <repo> <branch>:<branch> fetches tags?
Date: Mon, 28 Jan 2008 18:47:51 -0800
Message-ID: <7v3ashs5yg.fsf@gitster.siamese.dyndns.org>
References: <479E9063.5000403@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Jan 29 03:48:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJgWf-0000wV-Sg
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 03:48:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081AbYA2CsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 21:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752556AbYA2CsK
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 21:48:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41042 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534AbYA2CsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 21:48:09 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 328BB1304;
	Mon, 28 Jan 2008 21:48:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A97121303;
	Mon, 28 Jan 2008 21:48:03 -0500 (EST)
In-Reply-To: <479E9063.5000403@nrlssc.navy.mil> (Brandon Casey's message of
	"Mon, 28 Jan 2008 20:33:07 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71922>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> I expect these to fetch tags automatically (and they do):
>
>    git fetch
>    git pull
>    git fetch <repo>
>    git pull <repo>
>
> I expect these to _not_ fetch tags (and they don't):
>
>    git fetch <repo> <branch>
>    git pull <repo> <branch>
>
> But, I did not expect these to fetch tags:
>
>    git fetch <repo> <branch>:<branch>
>    git pull <repo> <branch>:<branch>

Sigh... that matches my expectation.

Did we break it when we overhauled "git fetch", or was this an
independent "improvement" that happened long before that?
