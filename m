From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t3404: extra checks and s/! git/test_must_fail git/
Date: Sat, 21 Jun 2008 02:46:08 -0700
Message-ID: <7v4p7nazof.fsf@gitster.siamese.dyndns.org>
References: <20080620190037.GE7369@leksak.fem-net>
 <alpine.DEB.1.00.0806201407230.6439@racer>
 <1213986614-19536-1-git-send-email-s-beyer@gmx.net>
 <X-0hXtX7hZGzbL_zS7e4VUMsiMfWiIfABUCFp28XZx0@cipher.nrlssc.navy.mil>
 <20080620190037.GE7369@leksak.fem-net>
 <20080621071812.6117@nanako3.lavabit.com>
 <20080621014636.GG7369@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nanako3@lavabit.com, Brandon Casey <casey@nrlssc.navy.mil>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Jun 21 11:47:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9zgn-0006Lz-EN
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 11:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbYFUJqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 05:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752659AbYFUJqY
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 05:46:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38887 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbYFUJqX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 05:46:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0BB84A70E;
	Sat, 21 Jun 2008 05:46:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 176BFA70D; Sat, 21 Jun 2008 05:46:13 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E7E723DC-3F76-11DD-89CF-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85700>

Stephan Beyer <s-beyer@gmx.net> writes:

>> > Perhaps I'm not consequent, but I thought that it's not worth it ;-)
>> 
>> Doesn't that logic make the other s/!/test_must_fail/ changes
>> also not worth it?  What is the reason behind the change?
>
> The s/!/test_must_fail/ is just an "extra" like
>  "Hey, you're currently standing, can you bring me some tea?"

Counting the places that were affected, I would not call which one is primary
change and which one is extra.  The later half of your patch is all about
test_must_fail isn't it?

I am all for making tests more careful, and I think more use of
test_must_fail makes quite a lot of sense.  Please don't do a half-ass job if
you are doing the conversion anyway.

About the commit log message, I tend to agree that your original subject
looked ugly and it would have been nicer to just say "t3404: more strict
tests for git-rebase" or something like that, but probably an empty commit
message body would have been Ok.
