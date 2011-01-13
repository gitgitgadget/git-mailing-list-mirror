From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Git unpack-objects on Windows
Date: Thu, 13 Jan 2011 13:30:03 +0100
Message-ID: <4D2EF04B.20108@viscovery.net>
References: <1294916875939-5917819.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kevin Sheedy <kevinsheedy@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 13 13:30:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdMJj-0007Lw-GH
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 13:30:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756671Ab1AMMaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jan 2011 07:30:09 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:56756 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756627Ab1AMMaH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jan 2011 07:30:07 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PdMJY-0005Dw-BS; Thu, 13 Jan 2011 13:30:04 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 1A0111660F;
	Thu, 13 Jan 2011 13:30:03 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <1294916875939-5917819.post@n2.nabble.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165050>

Am 1/13/2011 12:07, schrieb Kevin Sheedy:
> 
> I'm trying to import a cvs repository into git using cvs2git. After running
> cvs2git, I'm left with a git pack file. I'm now trying to unpack this file
> using:
> 
> git unpack-objects < myfile.pack
> 
> Or to be more exact:
> 
> $ git unpack-objects <
> "C:/dev/cvsToGitWorkingRepository/.git/objects/pack/pack-479ea920f4a7389f8a52eb6062.pack"
> Unpacking objects: 100% (66409/66409), done.
> 
> It looks like it worked except I'm not getting any unpacked files.

Only objects are unpacked that are not already in the object store. Since
you did not move the pack file (and its index) away from the object store,
none of its objects needed to be unpacked.

IOW, you observed expected behavior.

Why do you want to unpack some 66000 objects, I have to wonder?

-- Hannes
