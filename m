From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-quiltimport: better parser to  grok "enhanced"
 series files.
Date: Sat, 08 Mar 2008 19:39:21 -0800
Message-ID: <7vk5kcsh06.fsf@gitster.siamese.dyndns.org>
References: <20080308182709.GA3109@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Mar 09 04:40:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYCP0-0003gZ-7p
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 04:40:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbYCIDji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 22:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbYCIDji
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 22:39:38 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64094 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbYCIDjh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 22:39:37 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C88EC1A1E;
	Sat,  8 Mar 2008 22:39:33 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 10F1F1A1D; Sat,  8 Mar 2008 22:39:30 -0500 (EST)
In-Reply-To: <20080308182709.GA3109@artemis.madism.org> (Pierre Habouzit's
 message of "Sat, 08 Mar 2008 19:27:09 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76631>

Pierre Habouzit <madcoder@debian.org> writes:

>   I'd even argue that it's maint material btw :)

I don't know.

You made the loop a subshell but I think you can redirect into the while
loop without an extra "cat" process.

Can a patch name contain $IFS whitespace characters?  If so, this patch
would regress them.  Otherwise it looks fine.
