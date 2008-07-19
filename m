From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 19 Jul 2008 09:55:09 -0700
Message-ID: <7v4p6l3jbm.fsf@gitster.siamese.dyndns.org>
References: <7vr69r8sqk.fsf@gitster.siamese.dyndns.org>
 <7vlk01hqzz.fsf@gitster.siamese.dyndns.org>
 <20080718175040.6117@nanako3.lavabit.com>
 <20080718182010.6117@nanako3.lavabit.com>
 <7v63r38r4r.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807181351370.3932@eeepc-johanness>
 <7vabge30dh.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807191311220.3305@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 19 18:56:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKFjF-0000WP-V3
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 18:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069AbYGSQzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 12:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753958AbYGSQzR
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 12:55:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41461 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950AbYGSQzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 12:55:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3FA8A334C6;
	Sat, 19 Jul 2008 12:55:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 905A0334C5; Sat, 19 Jul 2008 12:55:11 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807191311220.3305@eeepc-johanness> (Johannes
 Schindelin's message of "Sat, 19 Jul 2008 13:19:46 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 75A89442-55B3-11DD-A1F4-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89113>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Yes, I agree, if all strategies fail, it is dubitable that we find a 
> metric that will always find the "best" one.  But if one fails and the 
> next one does not, it is obvious what is correct.

Not at all.  Imagine the case where one of them is either ours or theirs.
