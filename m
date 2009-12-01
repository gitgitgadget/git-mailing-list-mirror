From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: non-US-ASCII file names (e.g. Hiragana) on Windows
Date: Tue, 01 Dec 2009 09:27:45 +0100
Message-ID: <4B14D381.3010706@viscovery.net>
References: <4B1168D4.5010902@syntevo.com> <4B11AD43.3070307@gmail.com> <4B123C80.30607@syntevo.com> <4B14CA79.6040408@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 09:28:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFO5a-0000eE-AZ
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 09:28:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbZLAI1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 03:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752997AbZLAI1u
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 03:27:50 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:24436 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752932AbZLAI1u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 03:27:50 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NFO5K-00051t-Ga; Tue, 01 Dec 2009 09:27:53 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 448361660F;
	Tue,  1 Dec 2009 09:27:46 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4B14CA79.6040408@syntevo.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134177>

Thomas Singer schrieb:
> Thomas Singer wrote:
>> Reece Dunn wrote:
>>> This is a bug in git's character encoding/conversion logic. It looks
>>> like git is taking the source string and converting it to ascii to be
>>> displayed on the console output (e.g. by using the WideCharToMultiByte
>>> conversion API) -- these APIs will use a '?' character for characters
>>> that it cannot map to the target character encoding (like the Hiragana
>>> characters that you are using).
>> I have a screenshot from a SmartGit user where 1) the console can show the
>> far-east-characters and 2) Git *can* show the characters escaped. Are there
>> two versions of Git available or does Gits behaviour depends somehow on the
>> system locale?
> 
> Does no Git expert know what to do to get it working?

http://article.gmane.org/gmane.comp.version-control.git/133980 [*]

The possible reason why some one else is seeing correct glyphs with
SmartGit is because it is a Unicode application and the Windows box has
suitable fonts installed and the console is configured with a suitable
font as well.

-- Hannes

[*] I had a botch email infrastructure when I sent this message, and the
copy intended for you went to the waste bin, but I thought I had re-sent
to you in a private mail.
