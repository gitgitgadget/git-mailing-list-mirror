From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: warning: unable to rmdir my/module: Directory not empty
Date: Thu, 04 Nov 2010 21:49:17 +0100
Message-ID: <4CD31C4D.9050301@web.de>
References: <AANLkTi=UpQTzfC39rqW48mqoL0J4Sj6=vA1cJtpfBABV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mathieu Malaterre <mathieu.malaterre@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 21:49:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE6kO-0004rT-6D
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 21:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983Ab0KDUtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 16:49:19 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:40962 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797Ab0KDUtT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 16:49:19 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate01.web.de (Postfix) with ESMTP id 11A01174801EB;
	Thu,  4 Nov 2010 21:49:18 +0100 (CET)
Received: from [93.246.52.145] (helo=[192.168.178.29])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PE6kI-0002S3-00; Thu, 04 Nov 2010 21:49:18 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <AANLkTi=UpQTzfC39rqW48mqoL0J4Sj6=vA1cJtpfBABV@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/R3l3YsknJ9+dsEWl7VPqFMbxMcj1uzXofZbvd
	fIpVSGYVMSXo6b/4zPGsE2LARvipExDLQuuqjrpzkcfTWvc+27
	PX84MJEer+wz/KUatXCQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160764>

Am 04.11.2010 10:55, schrieb Mathieu Malaterre:
>   Does anyone knows where is this warning is coming from:
> 
> warning: unable to rmdir my/module: Directory not empty
> 
>   I have a git master, an empty branch and a submodule on master.
> Switching from master to my 'empty' branch always trigger this
> warning. ...

This is because submodule deletion is not well supported at the
moment. There has been a lot of discussion how to make git handle
that better but no one implemented it so far. But it's on my ToDo
list, so stay tuned ...
