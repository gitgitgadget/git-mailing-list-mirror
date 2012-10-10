From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 3/3] grep: stop looking at random places for .gitattributes
Date: Wed, 10 Oct 2012 14:43:14 +0200
Message-ID: <50756D62.5030008@viscovery.net>
References: <7vk3uzfp3p.fsf@alter.siamese.dyndns.org> <1349868894-3579-1-git-send-email-pclouds@gmail.com> <1349868894-3579-4-git-send-email-pclouds@gmail.com> <5075615B.8020702@viscovery.net> <CACsJy8BG0HJNePG-j27SrfEenEkZ5a5nCdMEuDGn=qXxq=VzhA@mail.gmail.com> <50756646.5060505@viscovery.net> <CACsJy8CznUShZVdmvGz1bfHHpZ1ZEX3PRUPb0+NNq2ZnvZEzZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 14:43:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLvdK-00027A-UP
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 14:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755412Ab2JJMnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 08:43:20 -0400
Received: from so.liwest.at ([212.33.55.24]:25489 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754562Ab2JJMnT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 08:43:19 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TLvd5-0001nz-7u; Wed, 10 Oct 2012 14:43:15 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 020BA1660F;
	Wed, 10 Oct 2012 14:43:14 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <CACsJy8CznUShZVdmvGz1bfHHpZ1ZEX3PRUPb0+NNq2ZnvZEzZg@mail.gmail.com>
X-Enigmail-Version: 1.4.4
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207408>

Am 10/10/2012 14:32, schrieb Nguyen Thai Ngoc Duy:
> git-archive has --worktree-attributes to specify where attributes come
> from. Sparse checkout can choose to read index version first then
> worktree's or the other way around. All normal operations read
> worktree version, if not found index version.

So, even if I run 'git diff master~2000 master~1999', it uses the
attributes from the worktree, and if not found from the index? (I would
not mind, BTW.)

-- Hannes
