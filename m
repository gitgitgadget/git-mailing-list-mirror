From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RESEND] git-submodule: add support for --rebase.
Date: Fri, 24 Apr 2009 09:19:21 -0700
Message-ID: <7vskjydnxy.fsf@gitster.siamese.dyndns.org>
References: <20090419233051.GA17946@dingo.bne.redhat.com>
 <alpine.DEB.1.00.0904201152360.6955@intel-tinevez-2-302>
 <20090421074540.GA7885@dingo.redhat.com>
 <alpine.DEB.1.00.0904211047311.10279@pacific.mpi-cbg.de>
 <20090423034709.GA22244@dingo.bne.redhat.com>
 <alpine.DEB.1.00.0904231119160.10279@pacific.mpi-cbg.de>
 <20090423230637.GE2282@dingo.bne.redhat.com>
 <alpine.DEB.1.00.0904240839400.7393@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Hutterer <peter.hutterer@who-t.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 24 18:21:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxO93-00084u-ND
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 18:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758761AbZDXQT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 12:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757967AbZDXQT2
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 12:19:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57815 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757873AbZDXQT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 12:19:27 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 35AADAD828;
	Fri, 24 Apr 2009 12:19:27 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C8BD1AD827; Fri,
 24 Apr 2009 12:19:22 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AE924078-30EB-11DE-9332-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117463>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Yes, I hereby give my sign-off ;-)
>
>> ---
>> 
>> > With this squashed in, I actually would not be too opposed to put this 
>> > into 1.6.3, as it _is_ an improvement.

I am afraid it is a bit too late for "improvements" after -rc1.  People
survived without the new feature until now, and they can wait a bit longer
for the next one.  I would welcome "fixes" til -rc2 but after that I'd
like people to focus only on regressions and fixes to new features.
Again, people lived with known breakages that weren't fixed before -rc2,
and fixes to them can wait.
