From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/3] Set cmdline globally, not in stop_here_user_resolve
Date: Tue, 01 Jun 2010 11:27:04 +0200
Message-ID: <4C04D268.6070908@viscovery.net>
References: <1275384022-12131-1-git-send-email-artagnon@gmail.com> <1275384022-12131-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 11:27:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJNkk-0007Ml-9q
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 11:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755570Ab0FAJ1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 05:27:12 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:33371 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212Ab0FAJ1L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 05:27:11 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OJNkZ-0007V5-2V; Tue, 01 Jun 2010 11:27:07 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 0FB9E1660F;
	Tue,  1 Jun 2010 11:27:04 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <1275384022-12131-2-git-send-email-artagnon@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148099>

Am 6/1/2010 11:20, schrieb Ramkumar Ramachandra:
> Set the $cmdline variable globally, so it can be used in other code
> fragments as well. Also, instead of hardcoding the string "git am",
> use the command line argument "$0".

Did you test this? "$0" prints the full path to git-am. This does not
count as user-friendly in my book!

-- Hannes
