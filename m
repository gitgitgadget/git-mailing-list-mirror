From: Wink Saville <wink@saville.com>
Subject: Re: Using git with Eclipse
Date: Mon, 10 Dec 2007 21:55:41 -0800
Message-ID: <475E265D.5090106@saville.com>
References: <475DC0CE.9070109@saville.com> <20071211024442.GJ14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 06:56:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1y6A-00033A-JX
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 06:56:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbXLKFzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 00:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbXLKFzp
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 00:55:45 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:21999 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266AbXLKFzo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 00:55:44 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1911074rvb
        for <git@vger.kernel.org>; Mon, 10 Dec 2007 21:55:44 -0800 (PST)
Received: by 10.140.199.19 with SMTP id w19mr2952286rvf.1197352543502;
        Mon, 10 Dec 2007 21:55:43 -0800 (PST)
Received: from ?192.168.0.133? ( [70.91.206.233])
        by mx.google.com with ESMTPS id l38sm7534099rvb.2007.12.10.21.55.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Dec 2007 21:55:43 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <20071211024442.GJ14735@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67794>

Shawn O. Pearce wrote:
> Wink Saville <wink@saville.com> wrote:
>   
>> I'm trying to use git on an Eclipse workspace and the .metadata 
>> directory is chock full of files and was wondering what, if anything, 
>> should be ignored. At the moment .history looks like a candidate for 
>> ignoring there are probably others.
>>     
>
> Ignore all of .metadata; its Eclipse private state that you don't
> want to version.  I'd add it to .git/info/exclude so its ignored only
> in the repository that is using Eclipse, rather than in .gitignore
> (which is published).
>
>   
Shawn,

I added .metadata to exclude then used git rm to remove
.metadata from the repository. I then cloned that
repository to see how Eclipse would work. (As part of  my
workflow I use git as a backup so I wanted to see what would
happen when I "restored".)

As I'm sure you know with the metadata gone my existing projects
in the Ui were gone and they have to be recreated as well as
some Eclipse and plugin specific configuration.
I understand you and others are working on an Eclipse plugin
for git, will it also ignore . metadata?

Do you need any testing done or is it too early? I'd be glad to
test if you feel its solid enough that I won't lose data or if it
uses a separate different repo then I could use both.

Regards,

Wink Saville
