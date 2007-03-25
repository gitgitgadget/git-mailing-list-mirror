From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: merge strategy request
Date: Mon, 26 Mar 2007 11:34:29 +1200
Message-ID: <46a038f90703251634t2ab6a455t382ebe29cdb53667@mail.gmail.com>
References: <Pine.LNX.4.63.0703241430420.12864@qynat.qvtvafvgr.pbz>
	 <Pine.LNX.4.63.0703250315461.4045@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0703242130050.6730@woody.linux-foundation.org>
	 <7v648paj14.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"David Lang" <david.lang@digitalinsight.com>, git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 01:34:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVcEM-0000E6-4T
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 01:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbXCYXea (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 19:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753533AbXCYXea
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 19:34:30 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:2644 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532AbXCYXe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 19:34:29 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1940882wxd
        for <git@vger.kernel.org>; Sun, 25 Mar 2007 16:34:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PzJJH/bRnw0bPM77gVp2woMero1sUZn4HBqubzyHP7NWLuBnxY55Rc0e2jU3vh65zKriR3Y94EWlbSW0PlDatj29JevbPAqDjar7tV/4A648IzKQI7phPSp6bkRIy3ROzznG4YfRFZE7v3ZYF3hW5zp97TgRGT7V5u+Regzjnmo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=alhtH+VmwQd2eZBSw7usptWgVhXEfVL9NZ9lsFRTN/e6fXwRBHOpfrcfHlhZ0yCf4TckF+k/Tay+b8hrtIgGhqiTHk8QvwcwNiFeh2D83ES1l4qC4aWaW/MhAFh3/37ASk91U9TX4SYfOUzY94HXlGCzxjjk/bqMbHOmqwCoZTA=
Received: by 10.90.115.4 with SMTP id n4mr6246998agc.1174865669150;
        Sun, 25 Mar 2007 16:34:29 -0700 (PDT)
Received: by 10.90.52.17 with HTTP; Sun, 25 Mar 2007 16:34:29 -0700 (PDT)
In-Reply-To: <7v648paj14.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43093>

On 3/25/07, Junio C Hamano <junkio@cox.net> wrote:
> Right.  In the current system, git-mergetool might be a better
> place to add support for special perpose 3-version file-level
> merge backend than merge-recursive, at least until gitattributes
> materializes.

Would it be possible to have an env var (GIT_MERGE) that can be used
to call an arbitrary script with merge/diff3 semantics instead of
using the internal 3-way merge? That way we could do syntax-specific
merges (ignore comments/whitespace, for example).

i would surely have a use for it, as sometimes my internal team is not
_that_ good about trimming whitespace, and we have merges that succeed
except for their whitespace conflicts.

cheers,



martin
