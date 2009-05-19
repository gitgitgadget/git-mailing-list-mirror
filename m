From: Robert Haines <rhaines@manchester.ac.uk>
Subject: Re: problems getting uptodate from a remote repository
Date: Tue, 19 May 2009 18:03:55 +0100
Message-ID: <ADB06DB0-9198-4AB4-8BE8-6472B943C872@manchester.ac.uk>
References: <33710F9891EA4BFD8ACD60798E354138@HPLAPTOP> <9719867c0905190908n2364da92s88ad646e8667298c@mail.gmail.com> <9719867c0905190909q74e4a6b9r4857fb6f32ff394@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Aaron Gray <aaronngray.lists@googlemail.com>
X-From: git-owner@vger.kernel.org Tue May 19 19:28:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6T7H-0000DD-S2
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 19:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856AbZESR2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 13:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbZESR2X
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 13:28:23 -0400
Received: from tranquility.mcc.ac.uk ([130.88.200.145]:49876 "EHLO
	tranquility.mcc.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177AbZESR2X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 13:28:23 -0400
X-Greylist: delayed 1467 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 May 2009 13:28:22 EDT
Received: from kelvin.its.manchester.ac.uk ([130.88.25.195])
	by tranquility.mcc.ac.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <rhaines@manchester.ac.uk>)
	id 1M6SjM-0004eI-I6; Tue, 19 May 2009 18:03:56 +0100
Received: from 94-192-243-24.zone6.bethere.co.uk ([94.192.243.24]:57941 helo=leela.config)
	by kelvin.its.manchester.ac.uk with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <rhaines@manchester.ac.uk>)
	id 1M6SjM-0003CY-D7; Tue, 19 May 2009 18:03:56 +0100
In-Reply-To: <9719867c0905190909q74e4a6b9r4857fb6f32ff394@mail.gmail.com>
X-Mailer: Apple Mail (2.930.3)
X-Authenticated-Sender: Robert Haines from 94-192-243-24.zone6.bethere.co.uk (leela.config) [94.192.243.24]:57941
X-Authenticated-From: Robert.Haines@manchester.ac.uk
X-UoM: Scanned by the University Mail System. See http://www.itservices.manchester.ac.uk/email/filtering/information/ for details.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119554>

Hi Aaron,

On 19 May 2009, at 17:09, Aaron Gray wrote:

> I have done a 'git fetch' but the repo is not being updated to  
> latest changes.
>
> I am getting the message :-
>
>    "Your branch is behind 'origin/master' by 53 commits, and can be
> fast-forwarded.
>
> when I do a 'git checkout master'
>
> What is going on here and what can I do about it ?


<snip config>

A fetch just updates your remote tracking branches in your local  
repository, it doesn't merge them as well. To update your local master  
you would then do (while on branch master):

$ git merge origin/master

This extra step allows you to create a new branch with origin/master  
as its start point to check that you're happy with the updates before  
you update your local master should you wish to do so.

Cheers,
Rob
