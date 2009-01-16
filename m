From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [BUG] assertion failure in builtin-mv.c with "git mv -k"
Date: Fri, 16 Jan 2009 13:57:05 +0100
Message-ID: <vpqwscvjtni.fsf@bauges.imag.fr>
References: <vpqwscy81o8.fsf@bauges.imag.fr>
	<496DFC75.2000904@drmicha.warpmail.net>
	<alpine.DEB.1.00.0901141653540.3586@pacific.mpi-cbg.de>
	<496E0D1C.20807@drmicha.warpmail.net>
	<7vbpu91zjf.fsf@gitster.siamese.dyndns.org>
	<496F15B4.2040104@drmicha.warpmail.net>
	<7vr634qkjn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 14:33:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNop6-0004e0-Tp
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 14:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764360AbZAPNb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 08:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763912AbZAPNb4
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 08:31:56 -0500
Received: from imag.imag.fr ([129.88.30.1]:56824 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763797AbZAPNbz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 08:31:55 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n0GCv6A5018828
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 16 Jan 2009 13:57:06 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LNoG1-0003UU-T1; Fri, 16 Jan 2009 13:57:05 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LNoG1-0003aT-Qa; Fri, 16 Jan 2009 13:57:05 +0100
In-Reply-To: <7vr634qkjn.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 15 Jan 2009 14\:19\:40 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 16 Jan 2009 13:57:06 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105959>

Junio C Hamano <gitster@pobox.com> writes:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> I'm happy to follow any variant ("1+2+3", "1 2+3", "1 2 3", in
>> increasing order of preference) so there's no need to discuss or explain
>> this further, just tell me "do x" ;)
>
> Do nothing ;-) Your 1=3772923 and 2+3=be17262d are already in and we can
> include the fix in the next 1.6.1.X maintenance release.

Thanks!

-- 
Matthieu
