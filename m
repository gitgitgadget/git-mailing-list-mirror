From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] perl/Makefile: update NO_PERL_MAKEMAKER section
Date: Wed, 23 Jul 2008 18:56:12 -0500
Message-ID: <LHJnvFqIyGXzSlPztg__TuZRmqu7aghMJ_WDZo7xhwLqjYt7RfqtMQ@cipher.nrlssc.navy.mil>
References: <0GfECozN3g0ZvAESKMi76RyOVHEb2OhhwET9GWmEm7pbzYQJub50UlWpZtBa7MGn1UGb-7mzbzE@cipher.nrlssc.navy.mil> <XKT02T_QW2tKLHpR7e3VuZjLXv3RP2E0GD54gXKrdIFm8xQsKvAyjg@cipher.nrlssc.navy.mil> <7vy73s89hv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 01:57:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLoCt-00046N-31
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 01:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097AbYGWX4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 19:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754058AbYGWX4S
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 19:56:18 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:45017 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbYGWX4R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 19:56:17 -0400
Received: by mail.nrlssc.navy.mil id m6NNuDI4002440; Wed, 23 Jul 2008 18:56:13 -0500
In-Reply-To: <7vy73s89hv.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 23 Jul 2008 23:56:13.0479 (UTC) FILETIME=[B0212370:01C8ED1F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89812>

Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> The perl modules must be copied to blib/lib so they are available for
>> testing.
> 
> True, but private-Error needs to be handled a bit more carefully, I
> think.
> 
> How about this on top of your patch?

That works. Error.pm is not available on my system and the statements
to copy private-Error.pm to Error.pm are correctly placed in perl.mak.

I should have gotten a clue when a file named _private_-Error.pm was
being copied to Error.pm and taken a look at Makefile.PL.

Thanks.

-brandon
