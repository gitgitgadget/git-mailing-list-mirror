From: Abhijit Menon-Sen <ams@toroid.org>
Subject: Re: [PATCH] Make it clear that push can take multiple refspecs
Date: Wed, 30 Jul 2008 11:47:27 +0530
Message-ID: <20080730061727.GA1912@toroid.org>
References: <1217362159-25440-1-git-send-email-ams@toroid.org> <7vbq0gcsxg.fsf@gitster.siamese.dyndns.org> <20080729212808.GA27076@toroid.org> <7viquobb0e.fsf@gitster.siamese.dyndns.org> <20080729231338.GA30717@toroid.org> <7vwsj49t27.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 08:18:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO515-0004jR-06
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 08:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719AbYG3GRb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 02:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752669AbYG3GRa
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 02:17:30 -0400
Received: from fugue.toroid.org ([85.10.196.113]:55366 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752040AbYG3GRa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 02:17:30 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id 0A9FC5582B7;
	Wed, 30 Jul 2008 08:17:28 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id E3C4BADC369; Wed, 30 Jul 2008 11:47:27 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <7vwsj49t27.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90752>

At 2008-07-29 16:20:00 -0700, gitster@pobox.com wrote:
>
> The synopsis talks about the ability for you to specify zero or more
> of whatever is called <refspec>, and here we define what _A_ refspec
> is.

Yes. The thing is, many places say "<refspec>..." both in the synopsis
and in the description (e.g. add, am, apply, commit...), and doing it
differently in some places seems more likely to be confusing than not.

I think it's nice if items in the description exactly match something
in the synopsis. It gives me more confidence that someone didn't just
forget to update one or the other.

(If you've queued the original git-push.txt patch, I'm happy to leave
the others alone, or change them one way or another, as you wish.)

-- ams
