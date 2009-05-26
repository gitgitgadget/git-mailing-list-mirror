From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t8005: convert CP1251 character set to ISO8859-5
Date: Tue, 26 May 2009 15:56:39 -0700
Message-ID: <7v3aaro4m0.fsf@alter.siamese.dyndns.org>
References: <7vhbzd85ux.fsf@alter.siamese.dyndns.org>
	<p2A1PR1KFf_G_uMMwQZtVeaDE_VcBr8lFjs9Jsg_OIkeypNbwPPRHP32EUHJ4leCZsycUOhFjHc@cipher.nrlssc.navy.mil>
	<p2A1PR1KFf_G_uMMwQZtVXPPBSNcQqEAV1ZnkoQLMJaPzWwJrkH_HCs5Kbt70yQlltZJxs4WxXo@cipher.nrlssc.navy.mil>
	<7vskiw4ooe.fsf@alter.siamese.dyndns.org>
	<7vhbzc4oht.fsf@alter.siamese.dyndns.org>
	<20090525092027.GA22382@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 27 00:57:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M95a0-0007Gz-0c
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 00:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194AbZEZW4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2009 18:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754876AbZEZW4j
	(ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 18:56:39 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:54581 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754845AbZEZW4j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2009 18:56:39 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090526225640.KVFJ17670.fed1rmmtao101.cox.net@fed1rmimpo03.cox.net>;
          Tue, 26 May 2009 18:56:40 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id wNwf1b00G4aMwMQ04Nwf4B; Tue, 26 May 2009 18:56:40 -0400
X-Authority-Analysis: v=1.0 c=1 a=4ueMqUMRleoA:10 a=_0s4GiiSMUIA:10
 a=PKzvZo6CAAAA:8 a=ybZZDoGAAAAA:8 a=cknCivPPAAAA:8 a=GPE_amUcK6MDR3ljIOAA:9
 a=9u-gDNqZixH0gs78SAQA:7 a=Zc9pO2IaGJbZJZFGaLNJcFetmecA:4 a=OdWmie4EkE0A:10
 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <20090525092027.GA22382@coredump.intra.peff.net> (Jeff King's message of "Mon\, 25 May 2009 05\:20\:27 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120016>

Jeff King <peff@peff.net> writes:

>   t3900 - still problems in the eucJP test. I haven't looked closely,
>           but my understanding is that this might need extra language
>           packs installed (I know virtually nothing about Solaris
>           administration and the box is not mine).

I think I know about this one.

    From:	Junio C Hamano <gitster@pobox.com>
    Subject: [PATCH] t3900: ISO-2022-JP has more than one popular variants
    Date:	Tue, 12 May 2009 02:29:10 -0700
    Message-ID: <7vljp28yah.fsf@alter.siamese.dyndns.org>

   I had to "pkg install lang-support-japanese" to pass this test.

>   t8005 - git produces incorrect (or at least not expected) results for
>           the iso8859-5 to sjis conversion. It all looks like control
>           characters to me, so I'm not sure how to diagnose (and it may
>           just be an installation issue again).

I haven't looked at this myself, but I've seen this consistently fail.

>   t4116,t5000,t5001 - Solaris tar doesn't like pax headers that
>                       git-archive generates

I think I force it to use gtar.
