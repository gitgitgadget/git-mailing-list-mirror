From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] builtin/describe.c: ignore untracked changes in
 submodules
Date: Mon, 13 Sep 2010 20:18:11 +0200 (CEST)
Message-ID: <150763691.8130046.1284401891268.JavaMail.fmail@mwmweb048>
References: <CC-1wlyJRzGfkPwn1Ra8d4Ot7mMnUGxYChGZHdqp-lQ5URlUFhNp4Ilyrh4bGk1dWF6drZXvim0@cipher.nrlssc.navy.mil>
 <7vy6bajvnd.fsf@alter.siamese.dyndns.org>
 <1094265482.7527324.1284144028114.JavaMail.fmail@mwmweb047>,
 <AANLkTinMf-_vk2-gRazf-8FNykZoNbVwmu_+c+5ht8rY@mail.gmail.com>,
 <1258122337.8606899.1284400767503.JavaMail.fmail@mwmweb047>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 13 20:20:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvDdm-0002ll-3b
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 20:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653Ab0IMSUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 14:20:14 -0400
Received: from fmmailgate06.web.de ([217.72.192.247]:37796 "EHLO
	fmmailgate06.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618Ab0IMSUN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 14:20:13 -0400
Received: from mwmweb048  ( [172.20.18.57])
	by fmmailgate06.web.de (Postfix) with ESMTP id 451C75764CC;
	Mon, 13 Sep 2010 20:18:11 +0200 (CEST)
Received: from [92.104.70.131]  by  mwmweb048  with HTTP; Mon
 Sep 13 20:18:11 CEST 2010
In-Reply-To: <1258122337.8606899.1284400767503.JavaMail.fmail@mwmweb047>
X-UI-Message-Type: mail
X-UI-ATTACHMENT-ID-POSTFIX: e352626d-4080-4878-a9c2-5329ba2f5ea7
X-Priority: 3
Importance: normal
Sensitivity: Normal
X-Provags-ID: V01U2FsdGVkX18K9NRXDajnTIihFgw+vdQn8eBlIH6WMEBzpYKQJpzmq9hjfYjs8vWO
 lCFNmsDECyaufC5psVMaWtH3SbgFFpQQSwsghMa+zEU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156106>

>>Perhaps the default setting of submodule.<name>.ignore should be 'untracked'?
>
>I still vote for none. I think the default should be to not have untracked files in
>your projects (like you should not have warnings when compiling your project).
>If that is not wanted, just use the configuration options git provides to change it.

I forgot to mention: I think untracked files should mark a submodule as modified
because otherwise it is too easy to forget adding new files inside submodules,
as they won't show up when the 'ignore' setting is 'untracked' .
