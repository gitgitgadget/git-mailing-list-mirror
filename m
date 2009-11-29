From: Thomas Singer <thomas.singer@syntevo.com>
Subject: Re: non-US-ASCII file names (e.g. Hiragana) on Windows
Date: Sun, 29 Nov 2009 10:18:56 +0100
Message-ID: <4B123C80.30607@syntevo.com>
References: <4B1168D4.5010902@syntevo.com> <4B11AD43.3070307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Maximilien Noal <noal.maximilien@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 29 10:19:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEfvp-0008RR-Lf
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 10:19:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754266AbZK2JSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 04:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754223AbZK2JSt
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 04:18:49 -0500
Received: from syntevo.com ([85.214.39.145]:60117 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754216AbZK2JSr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 04:18:47 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTP id D980D37C7B4
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4B11AD43.3070307@gmail.com>
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134006>

Maximilien Noal wrote:
> About the 'boxes' :
> 
> The thing is, Windows' files for Asian languages are _not_ installed by
> default.
> 
> They can be installed (even while installing Windows), by checking the
> two checkboxes under the "Supplemtal languages support" groupbox in the
> "Languages" tab of the "Regional and language options" control panel.
> *re-take some breath ;-) *
> 
> It will remove the "boxes" in Explorer and display nice Asian characters.

Thanks, now the characters are showing up fine in the Explorer.

Reece Dunn wrote:
> This is a bug in git's character encoding/conversion logic. It looks
> like git is taking the source string and converting it to ascii to be
> displayed on the console output (e.g. by using the WideCharToMultiByte
> conversion API) -- these APIs will use a '?' character for characters
> that it cannot map to the target character encoding (like the Hiragana
> characters that you are using).

I have a screenshot from a SmartGit user where 1) the console can show the
far-east-characters and 2) Git *can* show the characters escaped. Are there
two versions of Git available or does Gits behaviour depends somehow on the
system locale?

-- 
Tom
