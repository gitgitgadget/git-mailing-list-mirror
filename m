From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] receive-pack: make it a builtin
Date: Tue, 09 Sep 2008 07:24:03 -0700
Message-ID: <7v63p59z3w.fsf@gitster.siamese.dyndns.org>
References: <1220948830-3275-1-git-send-email-gitster@pobox.com>
 <1220948830-3275-2-git-send-email-gitster@pobox.com>
 <1220948830-3275-3-git-send-email-gitster@pobox.com>
 <48C64138.3020406@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Sep 09 16:26:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd49i-0007yc-R1
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 16:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbYIIOYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 10:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbYIIOYK
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 10:24:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39447 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbYIIOYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 10:24:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 349E556A00;
	Tue,  9 Sep 2008 10:24:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A2440569FC; Tue,  9 Sep 2008 10:24:05 -0400 (EDT)
In-Reply-To: <48C64138.3020406@gnu.org> (Paolo Bonzini's message of "Tue, 09
 Sep 2008 11:26:16 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F6C2537A-7E7A-11DD-AB0E-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95388>

Paolo Bonzini <bonzini@gnu.org> writes:

> Junio C Hamano wrote:
>> It is a good thing to do in general, but more importantly, transport
>> routines can only be used by built-ins, which is what I'll be adding next.
>
> So how do I
>
>         receive-pack = /home/bonzinip/bin/git-receive-pack
>
> now?  Using libexec or ".../bin/git receive-pack" is fine, I just would
> like to know it and see it in the release notes.

Please check your Makefile (I'm too lazy to double check); don't we
install these server side programs in $(bindir)?
