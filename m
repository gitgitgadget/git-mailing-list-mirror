From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Bug in Git-Gui - Creates corrupt patch
Date: Mon, 02 Mar 2009 15:39:28 +0100
Message-ID: <49ABEFA0.9090808@viscovery.net>
References: <20090225090322.301cdb77@family.dyweni.com> <49A567C9.5050203@viscovery.net> <49ABEE6C.3000500@tuffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: 4jxDQ6FQee2H@dyweni.com, spearce@spearce.org, git@vger.kernel.org
To: Grzegorz Kossakowski <grek@tuffmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 15:41:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le9KJ-00057y-7k
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 15:41:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbZCBOje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 09:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbZCBOje
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 09:39:34 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:18813 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777AbZCBOjd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 09:39:33 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Le9Io-0004Bn-75; Mon, 02 Mar 2009 15:39:30 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 6F7A24E4; Mon,  2 Mar 2009 15:39:29 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <49ABEE6C.3000500@tuffmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111943>

Grzegorz Kossakowski schrieb:
> Johannes Sixt pisze:
>> 4jxDQ6FQee2H@dyweni.com schrieb:
>>> 3. Using git-gui, try to stage *only* the last line marked for removal
>>> (should be '-	}').
>>>
>>> I get 'fatal: corrupt patch at line 22'.
>> "Stage/Unstage line" does not work for files that have
>>
>> \ No newline at end of file
> 
> I've just stumpled across this problem. Does above imply that reported problem is not considered as a bug?

No, it means that I was too lazy to implement it. I tried to do that after
this report came in, but gave up because it is not trivial and I have too
little time to think it through. :-(

-- Hannes
