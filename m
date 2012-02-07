From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] add -e: ignore dirty submodules
Date: Tue, 07 Feb 2012 21:43:33 +0100
Message-ID: <4F318CF5.6050302@web.de>
References: <alpine.DEB.1.00.1202070504340.24259@s15462909.onlinehome-server.info> <7vaa4v42fi.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1202070124020.4897@bonsai2> <7vk43z2gwc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 21:43:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RurtC-0002OA-7f
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 21:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756506Ab2BGUnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 15:43:41 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:60305 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756379Ab2BGUnk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 15:43:40 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate01.web.de (Postfix) with ESMTP id 4AFF51A9F3B62
	for <git@vger.kernel.org>; Tue,  7 Feb 2012 21:43:39 +0100 (CET)
Received: from [192.168.178.20] ([91.3.189.70]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MS1tK-1S6VuK0fus-00TOHB; Tue, 07 Feb 2012 21:43:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0) Gecko/20120129 Thunderbird/10.0
In-Reply-To: <7vk43z2gwc.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:qa2/EWKUyo0qs/GxHKeCUmvaqfVWztGB9g9eoI6cmW8
 x1sb9lU+x+iqP67nYLePvMNAROTc6Mg7tBv0pylpM6R74hMR9/
 6uM94vJgr42Xy5TvNVuKJw7ccBKYRImF17iPdX0T26Ns8xNarP
 H/s5kWStkSRR8kMihzuKUe7JDo3JVe7DrHTNPweiP/0M5hZcNn
 m74JVKL2RrLAw4cbk6z+A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190211>

Am 07.02.2012 09:21, schrieb Junio C Hamano:
> So after all, this is a noise reduction patch, and I think that it is a
> good change.

I agree. While my first thought was that it might make sense to honor
the diff.ignoreSubmodules setting here too to produce the same
information "git status" gives (so you notice you might have forgotten
to commit something in the submodule), I now agree that doesn't make
sense in the context of add -e.
