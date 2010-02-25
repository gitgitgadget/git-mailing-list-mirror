From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH jh/notes] t3301-notes: insert a shbang line in ./fake_editor.sh
Date: Thu, 25 Feb 2010 21:17:44 +0100
Message-ID: <4B86DAE8.2060107@viscovery.net>
References: <4B865376.9030209@viscovery.net> <7v3a0pcln4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 21:17:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkk9f-0004YQ-Sg
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 21:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933606Ab0BYURr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 15:17:47 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:59087 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933299Ab0BYURr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 15:17:47 -0500
Received: from [192.168.0.202] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 824ECCDF9E;
	Thu, 25 Feb 2010 21:17:42 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7v3a0pcln4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141067>

Junio C Hamano schrieb:
> Shouldn't that be "#!$SHELL_PATH", though?

It doesn't matter, but the change would be larger because we do not
want to expand $MSG.

-- Hannes
