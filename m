From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] builtin/describe.c: ignore untracked changes in
 submodules
Date: Sat, 11 Sep 2010 22:23:11 +0200 (CEST)
Message-ID: <1982035721.2791029.1284236591083.JavaMail.fmail@mwmweb045>
References: <CC-1wlyJRzGfkPwn1Ra8d4Ot7mMnUGxYChGZHdqp-lQ5URlUFhNp4Ilyrh4bGk1dWF6drZXvim0@cipher.nrlssc.navy.mil>
 <7vy6bajvnd.fsf@alter.siamese.dyndns.org>
 <1464835923.7527323.1284144028047.JavaMail.fmail@mwmweb047>
 <1529126586.2758911.1284228699341.JavaMail.fmail@mwmweb045>,
 <7v39tgf5zw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	johannes.schindelin@gmx.de, Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 11 22:23:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuWba-0004MN-1W
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 22:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060Ab0IKUXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Sep 2010 16:23:13 -0400
Received: from fmmailgate07.web.de ([217.72.192.248]:59295 "EHLO
	fmmailgate07.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785Ab0IKUXM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Sep 2010 16:23:12 -0400
Received: from mwmweb045  ( [172.20.18.54])
	by fmmailgate07.web.de (Postfix) with ESMTP id 172974C91BF;
	Sat, 11 Sep 2010 22:23:11 +0200 (CEST)
Received: from [92.104.70.131]  by  mwmweb045  with HTTP; Sat
 Sep 11 22:23:11 CEST 2010
In-Reply-To: <7v39tgf5zw.fsf@alter.siamese.dyndns.org>
X-UI-Message-Type: mail
X-UI-ATTACHMENT-ID-POSTFIX: 14b070c3-6009-43f7-8e2b-fc1303fd40e8
X-Priority: 3
Importance: normal
Sensitivity: Normal
X-Provags-ID: V01U2FsdGVkX19Zn4r9yztDmaQt7KJmPN2mN45aqK8duxOBX1q++l6hCwRo9OR+Ui0d
 l7ILAKoP4oWNM5IUrUUpoxU6AmpWlhuEErI0QyIwtko=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156010>

>Jens Lehmann <Jens.Lehmann@web.de> writes:
>> And maybe we should teach "git describe" the "--ignore-submodules" option, then
>> you could tell describe what to pass to the diff-index command. Thoughts?
>
>It is sensible to add the option, and handle_ignore_submodules_arg() call
>to grab "diff.ignoresubmodules" configuration) to the command, perhaps.

Ok, I'll look into that and prepare a patch.
