From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Git describe finding wrong tag
Date: Tue, 08 Feb 2011 08:19:36 +0100
Message-ID: <4D50EE88.8070005@viscovery.net>
References: <A76F5A9B-6E22-40D5-A8C9-C471A22DF1BE@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Feb 08 08:23:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pmhv7-0000Z6-Ko
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 08:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880Ab1BHHTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 02:19:40 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:6826 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108Ab1BHHTj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 02:19:39 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PmhrM-0005Rw-St; Tue, 08 Feb 2011 08:19:37 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 749291660F;
	Tue,  8 Feb 2011 08:19:36 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <A76F5A9B-6E22-40D5-A8C9-C471A22DF1BE@sb.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166336>

Am 2/8/2011 5:46, schrieb Kevin Ballard:
> I just encountered an odd situation where `git describe` insists on finding the
> wrong tag. In my case, I tagged a branch, then merged it into another branch,
> and now `git describe` in that other branch decides that it should emit a tag
> name that's over 200 commits old rather than the one that's a single commit
> away.
> 
> % git --version
> git version 1.7.4.31.g3f8c4
> % git describe
> build_1.2.2_applestore_1-203-g742967b
> % git describe HEAD^2
> build_1.2.2
> 
> Is there any rational for why git-describe is opting for the much older
> commit?

Most likely, the situation outlined in this commit message applies to your
case:

http://git.kernel.org/?p=git/git.git;a=commit;h=80dbae03

Then what you observe is by design.

-- Hannes
