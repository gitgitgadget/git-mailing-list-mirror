From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH 2/2] Documentation: bisect: add a few "git bisect run" examples
Date: Wed, 07 May 2008 08:29:03 +0200
Message-ID: <vpqlk2mbpao.fsf@bauges.imag.fr>
References: <20080507062931.dd72d7e1.chriscool@tuxfamily.org>
	<7vwsm6g14i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Jakub Narebski <jnareb@gmail.com>,
	Manoj Srivastava <srivasta@ieee.org>,
	"Thomas Adam" <thomas.adam22@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 07 08:33:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtdCy-0003Dn-Fy
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 08:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756664AbYEGGcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 02:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755680AbYEGGcG
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 02:32:06 -0400
Received: from imag.imag.fr ([129.88.30.1]:51782 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754106AbYEGGcE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 02:32:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m476TrVc016175
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 7 May 2008 08:29:54 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Jtd9D-0004tP-6Q; Wed, 07 May 2008 08:29:03 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Jtd9D-0007ea-2g; Wed, 07 May 2008 08:29:03 +0200
In-Reply-To: <7vwsm6g14i.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Tue\, 06 May 2008 21\:59\:57 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 07 May 2008 08:29:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81408>

Junio C Hamano <gitster@pobox.com> writes:

>> +------------
>> +echo "#"\!"/bin/sh" > ~/test.sh
>> +echo "make install || exit 125" >> ~/test.sh
>> +echo "~/check_test_case.sh" >> ~/test.sh
>> +chmod u+x ~/test.sh
>
> s/install//; let's not set a bad example of installing first and then
> testing.

Perhaps also s/~/./g, since it's not a good idea to put temporary
files in $HOME IMHO.

Also, using simple quotes instead of double would simplify the
"#"\!"/bin/sh".

-- 
Matthieu
