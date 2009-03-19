From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 05/10] test-lib: Simplify test counting.
Date: Thu, 19 Mar 2009 08:44:33 +0100
Message-ID: <49C1F7E1.8090808@viscovery.net>
References: <cover.1237410682.git.j6t@kdbg.org> <26c0cd245694bed22d98850c8ac0a86f3c930789.1237410682.git.j6t@kdbg.org> <alpine.DEB.1.00.0903182331330.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 19 08:46:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkCxC-0000v5-2d
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 08:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbZCSHop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 03:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbZCSHoo
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 03:44:44 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:8619 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbZCSHoo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 03:44:44 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LkCvZ-0003Vl-Vy; Thu, 19 Mar 2009 08:44:41 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id CAE15543; Thu, 19 Mar 2009 08:44:33 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <alpine.DEB.1.00.0903182331330.10279@pacific.mpi-cbg.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113728>

Johannes Schindelin schrieb:
> Hi,
> 
> On Wed, 18 Mar 2009, Johannes Sixt wrote:
> 
>> Since the test case counter was incremented very late, there were a few
>> users of the counter had to do their own incrementing. Now we increment it
>> early and simplify these users.
>>
>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>> ---
>>  t/test-lib.sh |   10 +++-------
>>  1 files changed, 3 insertions(+), 7 deletions(-)
> 
> Do you not need to adjust t4013 and t5515, too?

Yes, indeed. That makes sense.

-- Hannes
