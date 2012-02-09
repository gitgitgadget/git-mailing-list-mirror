From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2 1/2] submodules: always use a relative path to gitdir
Date: Thu, 09 Feb 2012 21:13:13 +0100
Message-ID: <4F3428D9.7080906@web.de>
References: <4F32F252.7050105@web.de> <4F32F2F6.6040006@web.de> <4F33814E.7050404@web.de> <7vd39nx0br.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Antony Male <antony.male@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 21:13:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvaNA-00060j-B4
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 21:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758004Ab2BIUNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 15:13:24 -0500
Received: from fmmailgate04.web.de ([217.72.192.242]:35417 "EHLO
	fmmailgate04.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162Ab2BIUNV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 15:13:21 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate04.web.de (Postfix) with ESMTP id D33327141455
	for <git@vger.kernel.org>; Thu,  9 Feb 2012 21:13:19 +0100 (CET)
Received: from [192.168.178.20] ([91.3.191.199]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MMFFF-1RsZgh20bt-008Gwi; Thu, 09 Feb 2012 21:13:18
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0) Gecko/20120129 Thunderbird/10.0
In-Reply-To: <7vd39nx0br.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:Gad355I1elocbDYsfsHC/9egeMJRU+JUAxVqTqRbq65
 wJn3Ta81gp4E4CR0+Mhh7C2bdNAjxceoYc/q5yHe5ViOxLtSno
 ZrWOevkFaUvb+NjVh74o+VlVFEL94v1NB1B5zM454qR9J4mzBk
 +REgzxYDoQvdxj88ZMrDnhfHKGgiXMuSENIDo0q/zG+PUB/j2e
 o+or+wo426IKVMnZT0XAw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190317>

Am 09.02.2012 20:40, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Since recently a submodule with name <name> has its git directory in the
> 
> I understand that "recently" refers to efc5fb6a77 and this is potentially
> a maint material for v1.7.8.X; am I correct?

That's correct.

>> The first version was whitespace damaged, please use this one instead.
> 
> Thanks. 
> 
> When applied to v1.7.8.x maintenance track, this failed the first step in
> t5526, but with the earlier jl/submodule-re-add topic everything seems to
> pass just fine.

Ah, I only tested these patches on current master. But you are right,
this belongs on top of jl/submodule-re-add for maint.
