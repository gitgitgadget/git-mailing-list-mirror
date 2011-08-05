From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] rebase -i: fix has_action
Date: Fri, 05 Aug 2011 14:46:54 +0200
Message-ID: <4E3BE63E.8030509@viscovery.net>
References: <1312450780-5021-1-git-send-email-nrubinstein@proformatique.com> <7vliv93r9g.fsf@alter.siamese.dyndns.org> <CAGdFq_j2wRw-gB109VypZkG1u=fm7yynkn2-Gu8AzNpVOrun8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Noe Rubinstein <nrubinstein@proformatique.com>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 05 14:47:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpJnw-0003dc-Bz
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 14:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755977Ab1HEMrD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Aug 2011 08:47:03 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:18261 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753469Ab1HEMrB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 08:47:01 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QpJnj-0001L2-19; Fri, 05 Aug 2011 14:46:55 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id BE08D1660F;
	Fri,  5 Aug 2011 14:46:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <CAGdFq_j2wRw-gB109VypZkG1u=fm7yynkn2-Gu8AzNpVOrun8w@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178793>

Am 8/5/2011 14:36, schrieb Sverre Rabbelier:
> On Thu, Aug 4, 2011 at 21:34, Junio C Hamano <gitster@pobox.com> wrote:
>>        has_action () {
>>          test -s "$1"
>>        }
> 
>>        has_action () {
>>          sane_grep -v -e '^#' -e '^[   ]*$' "$1" >/dev/null
>>        }
> 
> I think the former more correctly checks what the function name
> implies, is there any downside to that which makes you suggest this
> second approach?

Yes. There might be editors where it is difficult to edit a non-empty file
so that it becomes empty. I recall this was a problem for me with vi
before I got intimately acquainted with it.

-- Hannes
