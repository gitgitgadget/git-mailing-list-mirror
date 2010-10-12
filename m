From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git ls-files handles paths differently in Windows and Mac (probably
 Linux)
Date: Tue, 12 Oct 2010 15:11:34 +0200
Message-ID: <4CB45E86.2030703@viscovery.net>
References: <3C33A244-2449-4A3C-A8B5-2060CE61EE04@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 15:11:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5edt-0005Bu-Cs
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 15:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757280Ab0JLNLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 09:11:38 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:50333 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860Ab0JLNLh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 09:11:37 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1P5edi-0004wn-KX; Tue, 12 Oct 2010 15:11:34 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 641381660F;
	Tue, 12 Oct 2010 15:11:34 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <3C33A244-2449-4A3C-A8B5-2060CE61EE04@jetbrains.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158834>

Am 10/12/2010 14:14, schrieb Kirill Likhodedov:
> I want to see which files were changed in the specific directory of my
> working tree, so I call ls-files:
>> git ls-files -douvm --exclude-standard -- MYDIR
> 
> On Mac (and probably on Linux) git inspects the content of MYDIR and
> gives me the status of not-indexed changes in this directory. On
> Windows git gives the same result (only changes in MYDIR), but it scans
> the whole repository!

On Linux, this scans the whole repository, too. Therefore, at least the
Windows version should not be *that* wrong. ;-)

-- Hannes
