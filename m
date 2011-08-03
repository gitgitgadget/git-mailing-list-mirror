From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Skip archive --remote tests on Windows
Date: Wed, 03 Aug 2011 12:40:04 +0200
Message-ID: <4E392584.6060509@viscovery.net>
References: <4E3904B8.7080208@viscovery.net> <m3hb5yrhfw.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-4
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 12:40:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoYs7-00011M-2z
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 12:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754405Ab1HCKkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 06:40:14 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:2024 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753687Ab1HCKkN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 06:40:13 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QoYrt-0000Dp-9F; Wed, 03 Aug 2011 12:40:05 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 021571660F;
	Wed,  3 Aug 2011 12:40:04 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <m3hb5yrhfw.fsf@localhost.localdomain>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178557>

Am 8/3/2011 11:09, schrieb Jakub Narebski:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>> -test_expect_success 'archive --list shows only enabled remote filters' '
>> +test_expect_success NOT_MINGW 'archive --list shows only enabled remote filters' '
> 
> Shouldn't the prerequisite be called FORK rather than NON_MINGW?

Yes, it should. But we already have one instance of NOT_MINGW in
connection with archive --remote in this file before this patch, and with
Erik's efforts, these particular prerequisites should go away anyway RSN.

-- Hannes
