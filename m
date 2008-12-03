From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Ad: fast-import problem importing dos format files under cygwin
Date: Wed, 03 Dec 2008 13:18:17 +0100
Message-ID: <49367909.8070605@viscovery.net>
References: <43827.194.138.12.144.1228290700.squirrel@artax.karlin.mff.cuni.cz> <43270.194.138.12.144.1228295417.squirrel@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Dec 03 13:19:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7qhd-0002aE-FJ
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 13:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbYLCMSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 07:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbYLCMSU
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 07:18:20 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:54123 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbYLCMSU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 07:18:20 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1L7qgL-0001iz-RY; Wed, 03 Dec 2008 13:18:18 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 9D5E2A865; Wed,  3 Dec 2008 13:18:17 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <43270.194.138.12.144.1228295417.squirrel@artax.karlin.mff.cuni.cz>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "lilzmailsa03.liwest.at", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Jan Hudec schrieb: > On 3 December 2008, 08:51, Jan Hudec
	wrote: >> Hello folks, >> >> I have been playing with fast-import in cygwin
	and I have problems >> importing files with CR/LF line-endings. The size
	in data command is >> calculated including the CRs and than the file is copied
	binary to the >> fast-import input stream. However fast-import skips the
	CRs when reading, >> overreads by that number of bytes and fails when it tries
	to read the >> next command from the middle. > > One addition: > > I have
	tried with MSYS version 1.5.6.1.1071.g76fb and it imported the > test, as
	it was, except it didn't like 'refs/heads/master' as branchname > (and accepted
	bare 'master', but that created '.git/master'). [...] 
	Content analysis details:   (-1.4 points, 7.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102246>

Jan Hudec schrieb:
> On 3 December 2008, 08:51, Jan Hudec wrote:
>> Hello folks,
>>
>> I have been playing with fast-import in cygwin and I have problems
>> importing files with CR/LF line-endings. The size in data command is
>> calculated including the CRs and than the file is copied binary to the
>> fast-import input stream. However fast-import skips the CRs when reading,
>> overreads by that number of bytes and fails when it tries to read the
>> next command from the middle.
> 
> One addition:
> 
> I have tried with MSYS version 1.5.6.1.1071.g76fb and it imported the
> test, as it was, except it didn't like 'refs/heads/master' as branchname
> (and accepted bare 'master', but that created '.git/master').

With my current version of MinGW git the import is successful after I
edited test1.gfi to match your description (it had CR on all lines; I
removed all except on lines 15 and 16). The repository content is as one
would it expect given the input. master is
b8ad21c3dc271d43a6e43c261909d6be725fa5b8.

Do you happen to have core.autocrlf set in some way and could it make a
difference for fast-import? I have it unset.

-- Hannes
