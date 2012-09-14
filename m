From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Using Format/export-subst Howto.
Date: Fri, 14 Sep 2012 17:39:50 +0200
Message-ID: <50534FC6.2040207@viscovery.net>
References: <84EA18831601B6429E578236AE239B01A54807F242@EAGNMNSXMB07.usa.dce.usps.gov> <50532B35.9050607@drmicha.warpmail.net> <5053480E.2010002@viscovery.net> <84EA18831601B6429E578236AE239B01A54807F376@EAGNMNSXMB07.usa.dce.usps.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Mestnik, Michael J - Eagan, MN - Contractor" 
	<Michael.J.Mestnik@usps.gov>
X-From: git-owner@vger.kernel.org Fri Sep 14 17:40:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCXzx-0002Ku-9R
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 17:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758558Ab2INPjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 11:39:55 -0400
Received: from lilzmailso03.liwest.at ([212.33.55.24]:57667 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757859Ab2INPjy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 11:39:54 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TCXzj-0003ol-7t; Fri, 14 Sep 2012 17:39:51 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 014961660F;
	Fri, 14 Sep 2012 17:39:50 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <84EA18831601B6429E578236AE239B01A54807F376@EAGNMNSXMB07.usa.dce.usps.gov>
X-Enigmail-Version: 1.4.4
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205494>

Am 9/14/2012 17:27, schrieb Mestnik, Michael J - Eagan, MN - Contractor:
> 
>> -----Original Message----- From: Johannes Sixt
>> If EOL conversion or a clean filter was applied during 'git add
>> file', is the version in the worktree suddenly wrong? Of course,
>> not.
>> 
>> I would place $Id$ treatment in the same ball park and declare it as
>> a mistake of the editor that it did not remove the now "wrong" SHA1
>> from $Id:$.
> 
> I think the difference here is that git does not *currently change the
> OS's LEF.  In this case each commit alters the Id and git is the one
> altering the Id.

Maybe you misunderstood $Id$? The value you get there is the blob's SHA1,
not the commit's. That is, it does not change on every commit, but only
when the file changes.

You are right that the value itself is something that is dictated by git's
database model, but the change logically happens when the editor modifies
the file.

(My contribution to this thread should be regarded as food for thought.
Personally, I don't mind whether or not and when $Id$ is updated.)

-- Hannes
