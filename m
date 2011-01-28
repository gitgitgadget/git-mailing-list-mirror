From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-gui: add config value gui.diffopts for passing additional
 diff options
Date: Fri, 28 Jan 2011 08:29:02 +0100
Message-ID: <4D42703E.5070202@viscovery.net>
References: <1295607585-15971-1-git-send-email-tilman.vogel@web.de> <87ipxdn81f.fsf@fox.patthoyts.tk> <4D420B95.2060509@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Git Mailing List <git@vger.kernel.org>
To: Tilman Vogel <tilman.vogel@web.de>
X-From: git-owner@vger.kernel.org Fri Jan 28 08:29:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Piilf-0004fv-8y
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 08:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969Ab1A1H3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jan 2011 02:29:08 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:48934 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752195Ab1A1H3H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 02:29:07 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PiilT-0006jq-0u; Fri, 28 Jan 2011 08:29:03 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 88C9B1660F;
	Fri, 28 Jan 2011 08:29:02 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <4D420B95.2060509@web.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165600>

Am 1/28/2011 1:19, schrieb Tilman Vogel:
> Am 25.01.2011 01:25, schrieb Pat Thoyts:
>> This seems ok but you don't say what it is for. Why do you want to be
>> able to pass additional options to git diff?
> 
> Sorry, forgot to copy the motivation from
> <https://github.com/git/git/pull/8>:
> 
> I want to be able to make diff ignore whitespace changes "-b". But maybe
> someone else wants "-w" or what not, so I think a generic option field
> is most versatile.

What do you expect to happen, when a user writes any of the following in
that edit box?

  --name-status
  -R
  --frotz
  origin master

Don't you want to diagnose bogus input?
Disable "Stage/Unstage hung/lines" (because they won't apply anymore)?
Etc.

I don't think this is a great improvement. At the least it is not thought
through.

-- Hannes
