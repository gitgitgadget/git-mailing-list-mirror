From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: gitk: Removing Stacked Git branches from the --all view
Date: Wed, 18 Aug 2010 10:07:31 -0600
Message-ID: <4C6C0543.7070203@workspacewhiz.com>
References: <4C6A25E5.5050707@workspacewhiz.com> <AANLkTi=4Jr6KknLyBUe_+bQ4zue2KGNjxJtY8Ja6LmAT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 18:07:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OllB0-0001u1-Oh
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 18:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005Ab0HRQHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 12:07:34 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:41137 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753558Ab0HRQHd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 12:07:33 -0400
Received: (qmail 7801 invoked by uid 399); 18 Aug 2010 10:07:32 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@75.220.58.13)
  by hsmail.qwknetllc.com with ESMTPAM; 18 Aug 2010 10:07:32 -0600
X-Originating-IP: 75.220.58.13
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.8) Gecko/20100802 Lightning/1.0b2 Thunderbird/3.1.2
In-Reply-To: <AANLkTi=4Jr6KknLyBUe_+bQ4zue2KGNjxJtY8Ja6LmAT@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153866>

  ----- Original Message -----
From: Sverre Rabbelier
Date: 8/17/2010 11:42 AM
> On Tue, Aug 17, 2010 at 01:02, Joshua Jensen<jjensen@workspacewhiz.com>  wrote:
>> I've been playing around with various 'git log' options, but I'm not finding
>> one that gives me the gitk --all view as if StGit were never attached to the
>> repository.  (Speaking of StGit and apps that store metadata in branches...
>> it would be awesome to have a filter that knocks those branches out of ALL
>> views of the data.)
> It would be easier if StGit DTRT and stored its metadata in a stgit/
> namespace. That way you could just do `gitk --branches=refs/heads/`.
> There's (afaik) no way to specify what refs not to show, you'd need to
> teach 'git rev-list' a way to ignore a ref space. You'd have to teach
> it how to interpret something like `git rev-list --all --not
> --branches=refs/heads/*.stgit`.
Sure, I agree StGit should the metadata in an stgit/ namespace.

In any case, it sounds like there is no way to pull this off right now.  :(

Thanks for the help!

Josh
