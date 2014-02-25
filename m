From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: `git stash pop` UX Problem
Date: Tue, 25 Feb 2014 13:14:53 +0100
Message-ID: <530C893D.7000108@ira.uka.de>
References: <530B0395.5030407@booking.com> <CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com> <vpqlhx0a3cb.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Brandon McCaig <bamccaig@gmail.com>,
	Omar Othman <omar.othman@booking.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Feb 25 13:30:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIH9b-0007GM-Mn
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 13:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783AbaBYMa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Feb 2014 07:30:27 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:58362 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751402AbaBYMa0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Feb 2014 07:30:26 -0500
X-Greylist: delayed 956 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Feb 2014 07:30:26 EST
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	id 1WIGtp-0000ov-OI; Tue, 25 Feb 2014 13:14:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <vpqlhx0a3cb.fsf@anie.imag.fr>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1393330455.
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1393331413.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242663>

Am 24.02.2014 17:21, schrieb Matthieu Moy:
> $ git add foo.txt
> $ git status
> On branch master
> Changes to be committed:
>    (use "git reset HEAD <file>..." to unstage)
>
>          modified:   foo.txt

Maybe status should display a stash count if that count is > 0, as this 
is part of the state of the repo.

$ git status
On branch master
Stashes: 1                         <----------
Changes to be committed:
     (use "git reset HEAD <file>..." to unstage)

           modified:   foo.txt

It would be in Omars example case a clear message that git kept the 
stash. And generally a reminder that there is still a stash around that 
might or might not be obsolete.
