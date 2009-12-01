From: Thomas Singer <thomas.singer@syntevo.com>
Subject: Re: non-US-ASCII file names (e.g. Hiragana) on Windows
Date: Tue, 01 Dec 2009 09:55:54 +0100
Message-ID: <4B14DA1A.4060505@syntevo.com>
References: <4B1168D4.5010902@syntevo.com> <4B11AD43.3070307@gmail.com> <4B123C80.30607@syntevo.com> <4B14CA79.6040408@syntevo.com> <4B14D381.3010706@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Dec 01 09:55:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFOWG-0002da-T6
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 09:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753602AbZLAIzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 03:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753570AbZLAIzW
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 03:55:22 -0500
Received: from syntevo.com ([85.214.39.145]:40484 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753071AbZLAIzW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 03:55:22 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTP id 46AFF37C7B0
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4B14D381.3010706@viscovery.net>
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134180>

Johannes Sixt wrote:
> Thomas Singer schrieb:
>> Thomas Singer wrote:
>>> Reece Dunn wrote:
>>>> This is a bug in git's character encoding/conversion logic. It looks
>>>> like git is taking the source string and converting it to ascii to be
>>>> displayed on the console output (e.g. by using the WideCharToMultiByte
>>>> conversion API) -- these APIs will use a '?' character for characters
>>>> that it cannot map to the target character encoding (like the Hiragana
>>>> characters that you are using).
>>> I have a screenshot from a SmartGit user where 1) the console can show the
>>> far-east-characters and 2) Git *can* show the characters escaped. Are there
>>> two versions of Git available or does Gits behaviour depends somehow on the
>>> system locale?
>> Does no Git expert know what to do to get it working?
> 
> http://article.gmane.org/gmane.comp.version-control.git/133980 [*]
> 
> The possible reason why some one else is seeing correct glyphs with
> SmartGit is because it is a Unicode application and the Windows box has
> suitable fonts installed and the console is configured with a suitable
> font as well.

I wasn't talking about SmartGit, but msysgit on the Windows console. Sorry,
if that wasn't clear.

Is it a German Windows limitation, that far-east characters are not
supported on it (but work fine on a Japanese Windows), are there different
(mysys)Git versions available or is this a configuration issue?

-- 
Tom
