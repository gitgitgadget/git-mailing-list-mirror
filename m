From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v2] gitk: Add a horizontal scrollbar for commit history
Date: Sat, 02 Nov 2013 10:40:45 +0100
Message-ID: <5274C89D.10103@hvoigt.net>
References: <1383130702-4966-1-git-send-email-ncornu@aldebaran-robotics.com> <5270F4FC.60900@viscovery.net> <CAMXp-VMku0eSQmmbdy-NQDedH4VSgZN5XmpTeBHvN8qX1=ersg@mail.gmail.com> <20131031090526.GA9164@iris.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>,
	Nicolas Cornu <ncornu@aldebaran-robotics.com>
X-From: git-owner@vger.kernel.org Sat Nov 02 10:49:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcXpI-0008Bb-OX
	for gcvg-git-2@plane.gmane.org; Sat, 02 Nov 2013 10:49:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805Ab3KBJsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Nov 2013 05:48:46 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.39]:43888 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330Ab3KBJsp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Nov 2013 05:48:45 -0400
X-Greylist: delayed 477 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Nov 2013 05:48:45 EDT
Received: from [77.20.34.36] (helo=[192.168.178.45])
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1VcXhG-0006kU-2E; Sat, 02 Nov 2013 10:40:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <20131031090526.GA9164@iris.ozlabs.ibm.com>
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237237>

Hi,

Am 31.10.2013 10:05, schrieb Paul Mackerras:
> On Wed, Oct 30, 2013 at 01:47:08PM +0100, Nicolas Cornu wrote:
>> This is useful on all our repos, every times, as we put a tag per day.
>> If the HEAD didn't move during 150 days, we got 150 tags.
>
> Here is a patch that I did some time ago but have never pushed out.
> Do you think it is an improvement when using gitk on a repo with lots
> of tags?
>
> Paul.
>
> [PATCH] gitk: Tag display improvements
>
> When a commit has many tags, the tag icons in the graph display can
> easily become so wide as to push the commit message off the right-hand
> edge of the graph display pane.  This changes the display so that if
> there are more than 3 tags or they would take up more than a quarter
> of the width of the pane, we instead display a single tag icon with
> a legend inside it like "4 tags...".  If the user clicks on the tag
> icon, gitk then displays all the tags in the diff display pane.
>
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Yes please. I have not tried it but the description sounds great. Will 
try to give it a testdrive next week.

Cheers Heiko
