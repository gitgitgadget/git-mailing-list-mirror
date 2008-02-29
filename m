From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Suggestion: make --left-right work with --merge
Date: Thu, 28 Feb 2008 23:49:41 -0800
Message-ID: <7vbq60dwx6.fsf@gitster.siamese.dyndns.org>
References: <18372.53155.854763.12637@cargo.ozlabs.ibm.com>
 <7v7igqyii9.fsf@gitster.siamese.dyndns.org>
 <18373.58839.636432.448970@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Feb 29 08:50:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV00q-0006uj-H9
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 08:50:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbYB2Ht6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 02:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbYB2Ht6
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 02:49:58 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60209 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbYB2Ht6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 02:49:58 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8B1B513EE;
	Fri, 29 Feb 2008 02:49:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id BBC7A13EB; Fri, 29 Feb 2008 02:49:50 -0500 (EST)
In-Reply-To: <18373.58839.636432.448970@cargo.ozlabs.ibm.com> (Paul
 Mackerras's message of "Thu, 28 Feb 2008 09:36:07 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75510>

Paul Mackerras <paulus@samba.org> writes:

> Junio C Hamano writes:
>
>> Like this?
>> 
>> A trivial feature that can be implemented in -4 lines ;-)
>
> Cool!  Yes, that works nicely.

I did not check this myself, but do arrows point in the right
direction?  I just randomly painted HEAD side left (and other
side right) in the patch.
