From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] stash: copy the index using --index-output instead of
 cp -p
Date: Wed, 16 Mar 2011 09:12:17 +0100
Message-ID: <4D8070E1.8000305@viscovery.net>
References: <4D7F3AA4.1080202@elegosoft.com>	<4D7F466A.4090508@viscovery.net>	<4D7F54C2.5060500@elegosoft.com>	<4D7F5DA0.3030608@viscovery.net>	<7vk4g09o9x.fsf@alter.siamese.dyndns.org> <AANLkTi=+-tDz6XSSUAyvzGZ6fJohSU+rY4GhRa5C-+oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakob Pfender <jpfender@elegosoft.com>, git@vger.kernel.org,
	casey@nrlssc.navy.mil, jon.seymour@gmail.com
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 09:12:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzlqV-0003hX-TD
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 09:12:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495Ab1CPIM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 04:12:28 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:25953 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435Ab1CPIMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 04:12:25 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Pzlq5-0004gl-Sa; Wed, 16 Mar 2011 09:12:19 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 9894D1660F;
	Wed, 16 Mar 2011 09:12:17 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <AANLkTi=+-tDz6XSSUAyvzGZ6fJohSU+rY4GhRa5C-+oA@mail.gmail.com>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169118>

Am 3/15/2011 20:53, schrieb Bert Wesarg:
> Please note that the file to the --index-output option needs to be on
> the same filesystem as GIT_INDEX_FILE, so that it can be renamed.

Good catch. Here follows a mini-series that address this and also fixes
some left-over temporary files.

-- Hannes
