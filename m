From: Thomas Singer <thomas.singer@syntevo.com>
Subject: Re: non-US-ASCII file names (e.g. Hiragana) on Windows
Date: Tue, 01 Dec 2009 08:49:13 +0100
Message-ID: <4B14CA79.6040408@syntevo.com>
References: <4B1168D4.5010902@syntevo.com> <4B11AD43.3070307@gmail.com> <4B123C80.30607@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 08:48:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFNTi-0003g0-IC
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 08:48:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479AbZLAHsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 02:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753390AbZLAHsm
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 02:48:42 -0500
Received: from syntevo.com ([85.214.39.145]:49607 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753155AbZLAHsm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 02:48:42 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTP id 134FE37C7B0
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4B123C80.30607@syntevo.com>
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134173>

Thomas Singer wrote:
> Reece Dunn wrote:
>> This is a bug in git's character encoding/conversion logic. It looks
>> like git is taking the source string and converting it to ascii to be
>> displayed on the console output (e.g. by using the WideCharToMultiByte
>> conversion API) -- these APIs will use a '?' character for characters
>> that it cannot map to the target character encoding (like the Hiragana
>> characters that you are using).
> 
> I have a screenshot from a SmartGit user where 1) the console can show the
> far-east-characters and 2) Git *can* show the characters escaped. Are there
> two versions of Git available or does Gits behaviour depends somehow on the
> system locale?

Does no Git expert know what to do to get it working?

-- 
Tom
