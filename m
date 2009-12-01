From: Thomas Singer <thomas.singer@syntevo.com>
Subject: Re: non-US-ASCII file names (e.g. Hiragana) on Windows
Date: Tue, 01 Dec 2009 16:41:16 +0100
Message-ID: <4B15391C.5090302@syntevo.com>
References: <4B1168D4.5010902@syntevo.com> <4B11AD43.3070307@gmail.com> <4B123C80.30607@syntevo.com> <4B14CA79.6040408@syntevo.com> <4B14D381.3010706@viscovery.net> <4B14DA1A.4060505@syntevo.com> <4B14E934.9090304@viscovery.net> <4B150747.2030900@syntevo.com> <4B151782.8050309@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Dec 01 16:41:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFUqO-0004pc-Ly
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 16:40:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753662AbZLAPkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 10:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753573AbZLAPkg
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 10:40:36 -0500
Received: from syntevo.com ([85.214.39.145]:53974 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752827AbZLAPkf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 10:40:35 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTP id CB44E37C7B0
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4B151782.8050309@viscovery.net>
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134213>

Johannes Sixt wrote:
> Thomas Singer schrieb:
>> I'm quite surprised, that -- as I
>> understand you -- msys-Git (or Git at all?) is not able to handle all
>> characters (aka unicode) at the same time. I expected it would be better
>> than older tools, e.g. SVN.
> 
> This has been discussed at length here and in the msysgit mailing list.
> Git expects that the file system returns file names with the same byte
> sequence that git used to create a file. On Windows, this works only as
> long as you do not switch the codepage.

Now you confuse me: is this a problem of Windows, Git using a less capable
Windows-API call or is there no unicode-capable API call to list file names
on Windows? I ask myself how Java does it in its internals, finally it
(also) consists of a C-base, I guess.

-- 
Tom
