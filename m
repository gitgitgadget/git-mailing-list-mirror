From: Paul Gardiner <lists@glidos.net>
Subject: Re: How do I stop git enumerating my working directory
Date: Wed, 02 Jul 2008 15:51:04 +0100
Message-ID: <486B95D8.9030106@glidos.net>
References: <486A53CC.4020803@glidos.net> <vpqr6ad5zms.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, lists@glidos.net
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jul 02 16:52:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE3gm-0007iD-QK
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 16:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754693AbYGBOvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 10:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754275AbYGBOvJ
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 10:51:09 -0400
Received: from mk-outboundfilter-1.mail.uk.tiscali.com ([212.74.114.37]:19178
	"EHLO mk-outboundfilter-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753304AbYGBOvI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jul 2008 10:51:08 -0400
X-Trace: 139742495/mk-outboundfilter-1.mail.uk.tiscali.com/PIPEX/$PIPEX-ACCEPTED/pipex-customers/81.86.57.226
X-SBRS: None
X-RemoteIP: 81.86.57.226
X-IP-MAIL-FROM: lists@glidos.net
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhEBAEBvV0hRVjni/2dsb2JhbAAIrnyBYw
X-IronPort-AV: E=Sophos;i="4.27,737,1204502400"; 
   d="scan'208";a="139742495"
X-IP-Direction: IN
Received: from 81-86-57-226.dsl.pipex.com (HELO [10.0.0.24]) ([81.86.57.226])
  by smtp.pipex.tiscali.co.uk with ESMTP; 02 Jul 2008 15:51:06 +0100
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <vpqr6ad5zms.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87149>

Matthieu Moy wrote:
> Paul Gardiner <lists@glidos.net> writes:
> 
>> I don't think I can make .gitignore files do the job, because
>> it seems that you can set up to ignore a whole directory,
>> and then partially countermand that by placing a .gitignore
>> file (containing ! commands) inside the directory.
> 
> To me, it seems the opposite ;-).
> 
> I just tried to "git init" my $HOME, then "git status" takes forever,
> but "echo '*' > .gitignore; git status" completes immediately.

Ok, I was confusing myself because of having added files inside
subdirectories of the ignored directory.  I'm glad it works the
way it does. Makes much more sense than what I'd thought it was
doing.

P.
