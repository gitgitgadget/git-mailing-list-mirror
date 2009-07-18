From: Michael G Schwern <schwern@pobox.com>
Subject: Re: git silently ignores aliases of existing commands
Date: Sat, 18 Jul 2009 00:16:54 -0700
Message-ID: <4A6176E6.4060708@pobox.com>
References: <4A611CE1.3080709@pobox.com>
 <BLU0-SMTP9743008F68C14C8226D07BAE1F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sean Estabrooks <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sat Jul 18 09:17:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MS4AS-0006Ng-Dr
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 09:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbZGRHRB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 03:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbZGRHRA
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 03:17:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43102 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932323AbZGRHRA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 03:17:00 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 75AE99CEB;
	Sat, 18 Jul 2009 03:16:58 -0400 (EDT)
Received: from [10.23.42.2] (unknown [69.64.236.3]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8EED79CEA; Sat, 18 Jul 2009
 03:16:56 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.22 (Macintosh/20090605)
In-Reply-To: <BLU0-SMTP9743008F68C14C8226D07BAE1F0@phx.gbl>
X-Enigmail-Version: 0.95.7
X-Pobox-Relay-ID: FB1BC51A-736A-11DE-BFCD-AEF1826986A2-02258300!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123509>

Sean Estabrooks wrote:
> On Fri, 17 Jul 2009 17:52:49 -0700
> Michael G Schwern <schwern@pobox.com> wrote:
> 
> [...]
>> It would be nice if git used the alias *before* the installed command.  This
>> lets me fix/change default behaviors without having to come up with a new
>> command.  (Another handy example:  blame = blame -w)  It doesn't do anything
>> useful right now anyway.
> 
> This has been discussed a few times on the list already.   Here is one such
> discussion:
> 
> http://thread.gmane.org/gmane.comp.version-control.git/112487/focus=112493
> 
> You'll see that it was decided that Git would not allow commands to be overridden
> so that you could always be sure what a given command would do when you sit
> down at any installation.  This is especially important for scripting but can
> also be a problem for everyday usage.   You'll just have to choose a new command
> name for the alternate default you want.

I'm in the "more than enough rope" camp myself, so count that as a -1 fwiw.

More importantly, what about the warning telling the user that what they did
is not allowed and didn't work?


-- 
<Schwern> What we learned was if you get confused, grab someone and swing
          them around a few times
        -- Life's lessons from square dancing
