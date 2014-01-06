From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: Re: Re: [Bug report] 'git status' always says "Your branch is
 up-to-date with 'origin/master'"
Date: Mon, 6 Jan 2014 10:08:48 +0100 (CET)
Message-ID: <1283978462.720554.1388999328222.JavaMail.ngmail@webmail15.arcor-online.net>
References: <CAGyf7-FX1sPjwvKdxeEXopffFPiftgDRqoe7NRWyM1Cm=5n6Sw@mail.gmail.com> <1963290835.719443.1388996669450.JavaMail.ngmail@webmail15.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: worldhello.net@gmail.com, git@vger.kernel.org, gitster@pobox.com
To: bturner@atlassian.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Mon Jan 06 10:08:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W06B5-0004aP-V2
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 10:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057AbaAFJIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 04:08:51 -0500
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:57846 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751218AbaAFJIu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jan 2014 04:08:50 -0500
Received: from mail-in-16-z2.arcor-online.net (mail-in-16-z2.arcor-online.net [151.189.8.33])
	by mx.arcor.de (Postfix) with ESMTP id 39EF02D6358;
	Mon,  6 Jan 2014 10:08:48 +0100 (CET)
Received: from mail-in-14.arcor-online.net (mail-in-14.arcor-online.net [151.189.21.54])
	by mail-in-16-z2.arcor-online.net (Postfix) with ESMTP id 370843FF5E2;
	Mon,  6 Jan 2014 10:08:48 +0100 (CET)
Received: from webmail15.arcor-online.net (webmail15.arcor-online.net [151.189.8.68])
	by mail-in-14.arcor-online.net (Postfix) with ESMTP id 341CA9BE40;
	Mon,  6 Jan 2014 10:08:48 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-14.arcor-online.net 341CA9BE40
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1388999328; bh=IzXOlQg0EONN0d27p7Q6ypAC5CNzuiwI1qsutb0ywlU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=ax8r+D8OMCHWp2sziEEoa3WvDpQYjA/5FnfWEB9fmcEUotTDuNhjWFHuNdCNchnli
	 80G78m2afPbsuxh8/IQbrKHHd0mFfGAC+LBNDa7Sl0cwhTXWB6PQqHsqI4NJvhgi2G
	 Zf/GNBWsuQxft+uOYfPLqinpMFJR7ync2aVCb7+s=
Received: from [178.7.31.225] by webmail15.arcor-online.net (151.189.8.68) with HTTP (Arcor Webmail); Mon, 6 Jan 2014 10:08:48 +0100 (CET)
In-Reply-To: <CAGyf7-FX1sPjwvKdxeEXopffFPiftgDRqoe7NRWyM1Cm=5n6Sw@mail.gmail.com>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.31.225
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239991>

 
> 
> Unfortunately that's not true. In repo_b your ref for origin/master
> has not moved. It has remotely (meaning refs/heads/master in repo_a
> has moved), but git status is not hitting the remote to find out; it
> only looks at the local state. To see what I mean, run git fetch in
> repo_b. Once you do that, you'll see that git status correctly reports
> you're behind.
> 

OK; my expectation was, that the remote is checked for this ...
I see that this feature is useful for all non-trivial use cases
where you have several branches beside master for which the
remotes will be updated by git fetch.
But for the simple use case where you only have a master
branch I consider it not really helpful and - at least for me -
misleading.

---
Thomas
