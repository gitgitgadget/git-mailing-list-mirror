From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Intricacies of submodules
Date: Thu, 17 Apr 2008 13:04:34 -0700
Message-ID: <7vmynsnt7x.fsf@gitster.siamese.dyndns.org>
References: <47F15094.5050808@et.gatech.edu>
 <8FE3B7A7-4C2D-4202-A5FC-EBC4F4670273@sun.com>
 <32541b130804082033q55c795b5ieaa4e120956ff030@mail.gmail.com>
 <49E9DCEC-8A9E-4AD7-BA58-5A40F475F2EA@sun.com>
 <32541b130804082334s604b62b0j82b510c331f48213@mail.gmail.com>
 <7vhcebcyty.fsf@gitster.siamese.dyndns.org>
 <6CFA8EC2-FEE0-4746-A4F6-45082734FEEC@sun.com>
 <7v63uqz265.fsf@gitster.siamese.dyndns.org>
 <1207859579.13123.306.camel@work.sfbay.sun.com>
 <7vd4oxufwf.fsf@gitster.siamese.dyndns.org>
 <46dff0320804110904w531035f4w79c1889bc90c09ee@mail.gmail.com>
 <7vmyo0owep.fsf@gitster.siamese.dyndns.org> <1207970038.10408.8.camel@ginkgo>
 <7vlk3jlkrr.fsf@gitster.siamese.dyndns.org>
 <1208202740.25663.69.camel@work.sfbay.sun.com>
 <7vd4or7wdt.fsf@gitster.siamese.dyndns.org>
 <1208317795.26863.91.camel@goose.sun.com> <87lk3c4ali.fsf@jeremyms.com>
 <alpine.LFD.1.00.0804171158360.2879@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeremy Maitin-Shepard <jbms@cmu.edu>,
	"Roman V. Shaposhnik" <rvs@sun.com>,
	Ping Yin <pkufranky@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 17 22:20:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmaMl-0001q0-Jz
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 22:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbYDQUEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 16:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752883AbYDQUEy
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 16:04:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46733 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624AbYDQUEx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 16:04:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4743C3506;
	Thu, 17 Apr 2008 16:04:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 51AE43500; Thu, 17 Apr 2008 16:04:42 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.00.0804171158360.2879@woody.linux-foundation.org>
 (Linus Torvalds's message of "Thu, 17 Apr 2008 12:06:06 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79816>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So if we do end up doing a "tracked config file", I'd personally very much 
> prefer it be limited in some way. For example, we obviously track the 
> .gitignore and .gitattributes files, but they are much more limited in 
> their effects. Maybe we could have a "limited config file" that allows for 
> *some* config options to be set?

Yes, that's all what I have been trying to say ;-)
