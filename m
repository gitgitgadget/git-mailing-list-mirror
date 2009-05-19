From: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: any way to apply tag across all branches in repository?
Date: Tue, 19 May 2009 11:48:29 -0600
Message-ID: <4A12F0ED.4070707@nortel.com>
References: <4A12DDB9.60608@nortel.com> <Y0WmOpNg_9ptwbJ3VHYrzAgFtDvPi5pn4Tz-0w5Phhlo9frjieUaeA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue May 19 19:48:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6TQa-0000cp-Ef
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 19:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752931AbZESRsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 13:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753006AbZESRsc
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 13:48:32 -0400
Received: from zcars04e.nortel.com ([47.129.242.56]:41808 "EHLO
	zcars04e.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903AbZESRsb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 13:48:31 -0400
Received: from zcarhxs1.corp.nortel.com (casmtp.ca.nortel.com [47.129.230.89])
	by zcars04e.nortel.com (Switch-2.2.0/Switch-2.2.0) with ESMTP id n4JHlRo23682;
	Tue, 19 May 2009 17:47:27 GMT
Received: from localhost.localdomain ([47.130.81.171] RDNS failed) by zcarhxs1.corp.nortel.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 19 May 2009 13:48:30 -0400
User-Agent: Thunderbird 2.0.0.21 (X11/20090302)
In-Reply-To: <Y0WmOpNg_9ptwbJ3VHYrzAgFtDvPi5pn4Tz-0w5Phhlo9frjieUaeA@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 19 May 2009 17:48:30.0439 (UTC) FILETIME=[05756770:01C9D8AA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119555>

Brandon Casey wrote:

> If I understand you correctly, you are doing your primary development on
> the "main" branch and then merging this into the architecture specific
> branches which contain additional architecture specific changes.

Correct.

> All you need to do is tag the "main" branch.  Actually, you are tagging
> the commit that the branch currently points at.  When this branch is
> merged into the other branches, they will also contain this commit, and
> 'git describe' will use the tag you created when generating the version
> string.

I think this would work if the most recent commit is on the main branch.

However, if I make a change on the arch-specific branch, then tag the
main branch and merge it into the arch-specific branch, git tells me
the arch-specific branch is already up-to-date and the tag doesn't
get propagated.

Chris
