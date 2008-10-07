From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Files with colons under Cygwin
Date: Tue, 07 Oct 2008 08:13:20 +0200
Message-ID: <48EAFE00.3040907@viscovery.net>
References: <c475e2e60810020702q573570dcp31a5dc18bf98ef30@mail.gmail.com> <20081004233945.GM21650@dpotapov.dyndns.org> <48E9B634.6040909@viscovery.net> <20081007005327.GT21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Giovanni Funchal <gafunchal@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 08:14:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn5q4-0000qg-Tg
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 08:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbYJGGNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 02:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbYJGGNX
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 02:13:23 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:59352 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbYJGGNW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 02:13:22 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Kn5ou-0006h7-PH; Tue, 07 Oct 2008 08:13:21 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 88AB754D; Tue,  7 Oct 2008 08:13:20 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20081007005327.GT21650@dpotapov.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97670>

Dmitry Potapov schrieb:
> On Mon, Oct 06, 2008 at 08:54:44AM +0200, Johannes Sixt wrote:
>> [*] I say "meaningful" and not "necessary" because the situation is just
>> like when you grab some random SoftwarePackage.tar.gz, and run ./configure
>> without looking first what it is going to do.
> 
> When I grab any tar, I can look at its context without myself of any
> risk that some files can be overwritten on my file system. And when
> I want to look at some remote git repository, I usually do:
> 
>    git clone URL
> 
> If it can overwrite some files behind my back, it is security a hole.

Fair enough.

> On Linux (or other sane file systems), we have all required checks to
> prevent that from happening, and they are places in verify_path, which
> prevents malicious names entering into the index and thus to the file
> system too. So, we should do all required checks on Windows too.

I don't object the intention of your patch. But I cannot judge whether
verify_path() is the correct location to put the checks because I don't
know this part of the code. I leave the final word to others.

-- Hannes
