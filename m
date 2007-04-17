From: Rene Herman <rene.herman@gmail.com>
Subject: Re: git branch --switch?
Date: Tue, 17 Apr 2007 16:29:52 +0200
Message-ID: <4624D9E0.7080303@gmail.com>
References: <4624CD58.90103@gmail.com> <81b0412b0704170721i2b64999aqbd0d7489074454d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 16:32:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdoiv-0005Qi-CE
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 16:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbXDQOb5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 10:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbXDQOb5
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 10:31:57 -0400
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:56776 "EHLO
	smtpq2.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030224AbXDQOb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 10:31:57 -0400
Received: from [213.51.130.188] (port=33972 helo=smtp3.groni1.gr.home.nl)
	by smtpq2.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1Hdoip-00012U-CE; Tue, 17 Apr 2007 16:31:55 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:51888 helo=[192.168.0.3])
	by smtp3.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1Hdoij-00061D-Ce; Tue, 17 Apr 2007 16:31:49 +0200
User-Agent: Thunderbird 1.5.0.10 (X11/20070221)
In-Reply-To: <81b0412b0704170721i2b64999aqbd0d7489074454d6@mail.gmail.com>
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44771>

On 04/17/2007 04:21 PM, Alex Riesen wrote:

> On 4/17/07, Rene Herman <rene.herman@gmail.com> wrote:

>> Is it possible to switch the current branch without checking it out?

[ ... ]

> Kind of. It can be done with git-read-tree. I.e.:
> 
>  $ git-read-tree --index-output=.git/tmp-index <branch-name> && \
>     mv tmp-index .git/index && \
>     git update-ref HEAD <branch-name>

Eew. Thank you. Maybe...

Rene.
