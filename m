From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Wrap inflateInit to retry allocation after releasing
 pack memory
Date: Thu, 08 Jan 2009 17:43:46 -0800
Message-ID: <7vtz892qzx.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain>
 <1231314099.8870.415.camel@starfruit>
 <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain>
 <1231368935.8870.584.camel@starfruit>
 <alpine.LFD.2.00.0901071520330.3057@localhost.localdomain>
 <1231374514.8870.621.camel@starfruit>
 <alpine.LFD.2.00.0901071836290.3283@localhost.localdomain>
 <20090108030115.GF10790@spearce.org>
 <alpine.LFD.2.00.0901071904380.3283@localhost.localdomain>
 <20090108031314.GG10790@spearce.org> <20090108031655.GH10790@spearce.org>
 <alpine.LFD.2.00.0901071941210.3283@localhost.localdomain>
 <1231438552.8870.645.camel@starfruit>
 <alpine.LFD.2.00.0901081216060.3283@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "R. Tyler Ballance" <tyler@slide.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>,
	Jan =?utf-8?Q?Kr?= =?utf-8?Q?=C3=BCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>, kb@slide.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 09 02:45:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL6RC-00034S-PT
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 02:45:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbZAIBoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 20:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbZAIBoB
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 20:44:01 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbZAIBoA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 20:44:00 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3E01D8EC51;
	Thu,  8 Jan 2009 20:43:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3F4318EC50; Thu,
  8 Jan 2009 20:43:48 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0901081216060.3283@localhost.localdomain>
 (Linus Torvalds's message of "Thu, 8 Jan 2009 12:22:22 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FC18B3E0-DDEE-11DD-B06C-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104979>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Junio - I think we should apply this, and likely to the stable branch too. 

Yeah, I didn't lose the patch.

> Add the re-trying the inflateInit() after shrinking pack windows on top of 
> it.

That too.
