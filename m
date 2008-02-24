From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parse-opt: bring PARSE_OPT_HIDDEN to git-rev-parse
 --parseopt
Date: Sun, 24 Feb 2008 00:42:26 -0800
Message-ID: <7vbq66ycct.fsf@gitster.siamese.dyndns.org>
References: <20080221230101.27644.49229.stgit@gandelf.nowhere.earth>
 <20080222093558.GC29114@artemis.madism.org>
 <7vbq68ap1c.fsf@gitster.siamese.dyndns.org>
 <20080222181927.GA4555@artemis.madism.org>
 <20080223140926.GD10967@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 09:43:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTCSM-0001Zp-7h
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 09:43:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbYBXImh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 03:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752076AbYBXImg
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 03:42:36 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33164 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbYBXImg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 03:42:36 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AF60A1AD3;
	Sun, 24 Feb 2008 03:42:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id F34F81AD1; Sun, 24 Feb 2008 03:42:30 -0500 (EST)
In-Reply-To: <20080223140926.GD10967@artemis.madism.org> (Pierre Habouzit's
 message of "Sat, 23 Feb 2008 15:09:26 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74912>

Pierre Habouzit <madcoder@debian.org> writes:

>       I also made the parsing more extensible wrt new flags if needed.
>
>       We should definitely write tests too.
> ...
> +			case '*':
> +				o->flags &= PARSE_OPT_HIDDEN;
> +				break;

I have a slight suspicion that this is not what you meant.
You probably meant either |= or perhaps ^=.
