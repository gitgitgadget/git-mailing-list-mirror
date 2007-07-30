From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: merge time
Date: Mon, 30 Jul 2007 18:25:36 +0200
Message-ID: <46AE1100.2020005@dawes.za.net>
References: <46ADDD3B.3000806@dawes.za.net> <78813.86273.qm@web51002.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthew L Foster <mfoster167@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 18:27:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFY62-0004HS-CY
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 18:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966554AbXG3Q0K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 12:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966608AbXG3Q0J
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 12:26:09 -0400
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:35898 "EHLO
	spunkymail-a9.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S966613AbXG3Q0H (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2007 12:26:07 -0400
Received: from [192.168.201.100] (dsl-146-24-241.telkomadsl.co.za [165.146.24.241])
	by spunkymail-a9.g.dreamhost.com (Postfix) with ESMTP id 1740721025;
	Mon, 30 Jul 2007 09:25:57 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.5 (Windows/20070716)
In-Reply-To: <78813.86273.qm@web51002.mail.re2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54240>

Matthew L Foster wrote:
> Maybe I am the only one that thinks the web interface should be just as feature rich as the
> command line interface? 
> 
> -Matt
> 

Well, having said that "Use reflogs" was the general response, I don't 
think that anyone ever really followed through and made it a readily 
accessible feature, even on the command line.

That is, the reflogs are readily accessible, but noone made it possible 
to link them to the commits in such a way that the dates/times change as 
you seem to desire.

Of course, you can do things like:

$ git show HEAD@{2.days.ago}

to see what HEAD looked like 2 days ago, but you can't do things like 
get gitk to show you that this tag only appeared in your repo 2 days ago.

(Keep in mind, of course, that reflogs are referring to YOUR local copy 
of the git repo, not what HEAD was on the server that you cloned from.)

And also keep in mind that on the command line you can invoke a lot of 
"plumbing commands" that you certainly wouldn't expect to be exposed in 
a web interface.

Rogan
