From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/5] NUL hack to create_file()
Date: Thu, 29 May 2008 11:26:22 -0700
Message-ID: <7v8wxtotkh.fsf@gitster.siamese.dyndns.org>
References: <1212020246-26480-1-git-send-email-gitster@pobox.com>
 <1212020246-26480-2-git-send-email-gitster@pobox.com>
 <1212020246-26480-3-git-send-email-gitster@pobox.com>
 <1212020246-26480-4-git-send-email-gitster@pobox.com>
 <1212020246-26480-5-git-send-email-gitster@pobox.com>
 <1212020246-26480-6-git-send-email-gitster@pobox.com>
 <1212020246-26480-7-git-send-email-gitster@pobox.com>
 <alpine.LNX.1.00.0805291145230.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu May 29 20:27:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1mqn-0007sA-Av
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 20:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756253AbYE2S0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 14:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754872AbYE2S0d
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 14:26:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56421 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753859AbYE2S0c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 14:26:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 25C5D56FB;
	Thu, 29 May 2008 14:26:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 86AE756F7; Thu, 29 May 2008 14:26:24 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0805291145230.19665@iabervon.org> (Daniel
 Barkalow's message of "Thu, 29 May 2008 11:55:56 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C148A9B6-2DAC-11DD-8860-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83231>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Wed, 28 May 2008, Junio C Hamano wrote:
>
>> This is not meant for application to the mainline.  It allows your git to
>> refuse to create a blob whose name is "nul".
>
> I assume this is so you can test git's response to a defective filesystem 
> without actually having a defective filesystem?

Exactly.  I should have mentioned it so that people did not have to waste
their brain cycles pointing out prn and other stuff.  Sorry.
