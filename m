From: Sam Vilain <sam@vilain.net>
Subject: Re: [1.8.0] 't/' is standard name for directory with tests
Date: Thu, 03 Feb 2011 12:55:46 +1300
Message-ID: <4D49EF02.1050201@vilain.net>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1101311459000.8580@xanadu.home> <m3d3ncag7r.fsf_-_@localhost.localdomain> <alpine.LFD.2.00.1101311728180.8580@xanadu.home> <AANLkTi=uOhgnKxRpA0Vm2uSe+uznPwjRB-=2e81VTf-f@mail.gmail.com> <alpine.LFD.2.00.1101311930280.8580@xanadu.home> <7v4o8o4kt7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Alex Budovski <abudovski@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 03 00:56:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkmYG-0004vc-Rr
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 00:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755405Ab1BBXzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 18:55:51 -0500
Received: from mx6.orcon.net.nz ([219.88.242.56]:35975 "EHLO mx6.orcon.net.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754475Ab1BBXzu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 18:55:50 -0500
Received: from Debian-exim by mx6.orcon.net.nz with local (Exim 4.69)
	(envelope-from <sam@vilain.net>)
	id 1PkmY8-0007lA-UI
	for git@vger.kernel.org; Thu, 03 Feb 2011 12:55:49 +1300
Received: from [60.234.254.246] (helo=mail.utsl.gen.nz)
	by mx6.orcon.net.nz with esmtp (Exim 4.69)
	(envelope-from <sam@vilain.net>)
	id 1PkmY8-0007kp-Kd
	for git@vger.kernel.org; Thu, 03 Feb 2011 12:55:48 +1300
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 806BD2E023; Thu,  3 Feb 2011 12:55:48 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on naos.lan
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.1
Received: from [192.168.1.54] (arcturus.lan [192.168.1.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 7838A2E021;
	Thu,  3 Feb 2011 12:55:46 +1300 (NZDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <7v4o8o4kt7.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.2
X-DSPAM-Check: by mx6.orcon.net.nz on Thu, 03 Feb 2011 12:55:48 +1300
X-DSPAM-Result: Innocent
X-DSPAM-Processed: Thu Feb  3 12:55:48 2011
X-DSPAM-Confidence: 0.5406
X-DSPAM-Probability: 0.0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165942>

On 01/02/11 14:15, Junio C Hamano wrote:
> I am fine with "tests/", by the way.

FWIW, CCAN and Rubygems both use plain "test".

"t/" is a long standing convention for many projects, dating back to at
least 1987 with Perl 1.0.  As far as I know it was unusual at the time
for being a very test-driven development and inventing the TAP (Test
Anything Protocol).  It is something of a mark of respect to the
heritage of TDD to have it there, but that doesn't mean that "test"
might be better for the project now.

I'd also think about removing the "t" from the front of all the test
script names, those are a PITA :-).  And possibly allowing the scripts
to be broken into subdirectories.

Sam
