From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git bisect code 125 - "WFT?"
Date: Thu, 17 Mar 2011 07:55:06 +0100
Message-ID: <4D81B04A.1010802@viscovery.net>
References: <AANLkTikZ3Po-YdhO-qCn5usVkt4J196eFF6YdbAeMG_X@mail.gmail.com>	<7v1v267no9.fsf@alter.siamese.dyndns.org> <AANLkTikRttGnxex1CYSQnSg4PgctFj0-qNjf5un+fL0W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 07:55:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q077L-00042z-2f
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 07:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846Ab1CQGzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 02:55:16 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:10271 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544Ab1CQGzO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 02:55:14 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Q076x-0005Fo-Dh; Thu, 17 Mar 2011 07:55:08 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 134F61660F;
	Thu, 17 Mar 2011 07:55:06 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <AANLkTikRttGnxex1CYSQnSg4PgctFj0-qNjf5un+fL0W@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169213>

Am 3/16/2011 23:06, schrieb Piotr Krukowiecki:
> On Wed, Mar 16, 2011 at 10:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
>>
>>> Opinions? Would it be possible to change the meaning of the codes now
>>> (in 1.8.0)?
>>
>> How about just documenting why it is a bad idea to use 126 or 127 as you
>> found out somewhere, and stopping there, iow, without changing the code to
>> use 126/127 that we consider it is a bad idea to use and avoided using so
>> far?
> 
> Documenting it won't help. If you get 126 code, you won't know if user
> returned it to mark the code as bad, or if bash returned it to say
> that it can't
> execute a command.

Huh? Why should the user's script return 126 or 127, particularly if the
documentation says "don't do that"? Moreover, any decent (shell)
programmer will know that these two values are reserved by POSIX for
particular purposes (they are _not_ specific to bash):

http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_01_01

-- Hannes
