From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git ls-files handles paths differently in Windows and Mac (probably
 Linux)
Date: Tue, 12 Oct 2010 15:28:19 +0200
Message-ID: <4CB46273.1010601@viscovery.net>
References: <3C33A244-2449-4A3C-A8B5-2060CE61EE04@jetbrains.com> <4CB45E86.2030703@viscovery.net> <60B60680-78BD-4FFF-8472-8C853956CB1A@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 15:28:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5eu2-00048N-2P
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 15:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424Ab0JLN2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 09:28:22 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:2307 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932313Ab0JLN2V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 09:28:21 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1P5etw-0005hE-98; Tue, 12 Oct 2010 15:28:20 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 0B90C1660F;
	Tue, 12 Oct 2010 15:28:19 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <60B60680-78BD-4FFF-8472-8C853956CB1A@jetbrains.com>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158836>

Please don't top-post.

Am 10/12/2010 15:24, schrieb Kirill Likhodedov:
> how did you figure that? I mean - which tool did you use to see which
> files are accessed in Linux?

strace -e stat,lstat -o /tmp/ls-files.strace git ls-files ...

Could work on MacOS as well.

-- Hannes
