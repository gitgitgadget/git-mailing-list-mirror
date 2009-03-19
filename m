From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 02/10] test suite: Use 'say' to say something instead
 of   'test_expect_success'
Date: Thu, 19 Mar 2009 08:48:38 +0100
Message-ID: <49C1F8D6.1060309@viscovery.net>
References: <cover.1237410682.git.j6t@kdbg.org> <199f6a5e20f857a53af50872927a8086ce221345.1237410682.git.j6t@kdbg.org> <alpine.DEB.1.00.0903182306020.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 19 08:50:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkD12-0001yu-Qd
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 08:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086AbZCSHsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 03:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752477AbZCSHsn
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 03:48:43 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:43261 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970AbZCSHsn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 03:48:43 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LkCzX-0006yj-31; Thu, 19 Mar 2009 08:48:39 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E47C8543; Thu, 19 Mar 2009 08:48:38 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <alpine.DEB.1.00.0903182306020.10279@pacific.mpi-cbg.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113729>

Johannes Schindelin schrieb:
> Hi,
> 
> On Wed, 18 Mar 2009, Johannes Sixt wrote:
> 
>> Some tests report that some tests will be skipped.  They used
>> 'test_exect_success' with a trivially successful test.  Nowadays we have
> 
> s/exect/expect/.
> 
>> the helper function 'say' for this purpose.
>>
>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> 
> I see that you exchanged one "say_color" by "say".  What is the 
> difference?

The color. It's a change towards consistency. I figured that the command
to use by the tests is "say", while "say_color" is an implementation
detail of test-lib.sh.

-- Hannes
