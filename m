From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2 v4] Git.pm: add test suite
Date: Wed, 18 Jun 2008 12:40:51 -0700
Message-ID: <7vve06y1j0.fsf@gitster.siamese.dyndns.org>
References: <d94c2a62edfdec22c32ef5d9649078430b30ecfd.1213685306.git.LeWiemann@gmail.com>
 <4db23d5b625de1aa026cf4630d49b57fd3a09d07.1213685306.git.LeWiemann@gmail.com>
 <7v63s7301m.fsf@gitster.siamese.dyndns.org> <48594E42.2050402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 21:42:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K93Xb-0008Ir-Tw
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 21:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121AbYFRTlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 15:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753105AbYFRTlE
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 15:41:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58368 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855AbYFRTlC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 15:41:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A82E916B37;
	Wed, 18 Jun 2008 15:41:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A334F16B35; Wed, 18 Jun 2008 15:40:55 -0400 (EDT)
In-Reply-To: <48594E42.2050402@gmail.com> (Lea Wiemann's message of "Wed, 18
 Jun 2008 20:04:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7ACA6052-3D6E-11DD-8528-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85404>

Lea Wiemann <lewiemann@gmail.com> writes:

> Junio C Hamano wrote:
>> The system I first tried this did not have IO::String installed.
>
> My bad, I should've checked this before sending it off.  I guess we'll
> solve this in Michael's patch thread; don't expect a reply from me in
> the next 12h though, I'm way tired and utterly unproductive right now.
>
>> [test_external:] Can it become a bit easier to tell such a basic
>> problem apart from real test errors?  I needed to look into
>> /tmp/* to see where it is failing
>
> Hm, is your test output somehow different from the following?  It
> states the error quite clearly at the bottom.
> ...
> * expecting no stderr from previous command
> * FAIL 3: no stderr: Perl API
> 	perl ../t9700/test.pl
> 	Stderr is:
> 	Can't locate IO/String.pm in @INC (@INC contains:
> /home/lea/G/t/../perl/blib/lib
> /home/lea/G/t/../perl/blib/arch/auto/Git /home/lea/.perl/lib /etc/perl
> /usr/local/lib/perl/5.10.0 /usr/local/share/perl/5.10.0 /usr/lib/perl5
> /usr/share/perl5 /usr/lib/perl/5.10 /usr/share/perl/5.10
> /usr/local/lib/site_perl .) at ../t9700/test.pl line 12.
> 	BEGIN failed--compilation aborted at ../t9700/test.pl line 12.
> 	# Looks like your test died before it could output anything.
> * failed 2 among 3 test(s)

Yeah, I do see "Can't locate IO/String.pm".  Thanks.
