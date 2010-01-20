From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC/PATCHv8 00/10] git notes
Date: Wed, 20 Jan 2010 09:17:38 +0100
Message-ID: <4B56BC22.1040702@viscovery.net>
References: <1258681154-2167-1-git-send-email-johan@herland.net> <7vk4xl5y3z.fsf@alter.siamese.dyndns.org> <20091120192800.6117@nanako3.lavabit.com> <7vk4xl1nkl.fsf@alter.siamese.dyndns.org> <81b0412b1001190754m37ed01b0nd93b318d77d88a75@mail.gmail.com> <7vk4ve9dad.fsf@alter.siamese.dyndns.org> <7vska15u92.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 09:17:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXVlD-0000V6-I3
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 09:17:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948Ab0ATIRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 03:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751645Ab0ATIRq
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 03:17:46 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:57106 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751056Ab0ATIRp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 03:17:45 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NXVkx-00074a-DI; Wed, 20 Jan 2010 09:17:39 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 1C5E51660F;
	Wed, 20 Jan 2010 09:17:39 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7vska15u92.fsf@alter.siamese.dyndns.org>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137524>

Junio C Hamano schrieb:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Alex Riesen <raa.lkml@gmail.com> writes:
>>> This breaks "checkout to merge base" on Windows and t2012 in particular.
> 
> I think the attached patch would help.  If this fix is Ok with Windows
> people (J6t CC'ed), I'd like to apply this to 'master' so that we can ship
> 1.7.0-rc0 without breakage.
> 
> -- >8 --
> Subject: Fix "checkout A..." synonym for "checkout A...HEAD" on Windows
> ...
> Work this issue around by first calling check_ref_format(new.path) to see
> if the string can possibly be a valid ref under "refs/heads/", before
> asking resolve_ref().

Your patch fixes the failure very nicely, thank you very much.

BTW, calling 'git pack-refs --all' before 'git checkout master...'
helps as well :-P

-- Hannes
