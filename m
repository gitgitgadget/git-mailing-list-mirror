From: alan <alan@clueserver.org>
Subject: Re: Smart fetch via HTTP?
Date: Fri, 18 May 2007 11:33:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0705181130030.13214@blackbox.fnordora.org>
References: <20070515201006.GD3653@efreet.light.src> <20070517124006.GO4489@pasky.or.cz>
 <vpqlkfnipjl.fsf@bauges.imag.fr> <alpine.LFD.0.98.0705181123590.3890@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 18 20:55:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp7c9-0004KM-FE
	for gcvg-git@gmane.org; Fri, 18 May 2007 20:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754602AbXERSzg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 14:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755579AbXERSzg
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 14:55:36 -0400
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:54822 "EHLO
	clueserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754602AbXERSzf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 14:55:35 -0400
X-Greylist: delayed 1353 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 May 2007 14:55:35 EDT
Received: by clueserver.org (Postfix, from userid 500)
	id 1E775F5029E; Fri, 18 May 2007 11:33:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by clueserver.org (Postfix) with ESMTP id 1C621F50246;
	Fri, 18 May 2007 11:33:02 -0700 (PDT)
X-X-Sender: alan@blackbox.fnordora.org
In-Reply-To: <alpine.LFD.0.98.0705181123590.3890@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47631>

On Fri, 18 May 2007, Linus Torvalds wrote:

>
>
> On Thu, 17 May 2007, Matthieu Moy wrote:
>>
>> Many (if not most?) of the people working in a big company, I'd say.
>> Year, it sucks, but people having used a paranoid firewall with a
>> not-less-paranoid and broken proxy understand what I mean.
>
> Well, we could try to support the git protocol over port 80..
>
> IOW, it's probably easier to try to get people to use
>
> 	git clone git://some.host:80/project
>
> and just run git-daemon on port 80, than it is to try to set of magic cgi
> scripts etc.

Except some filtering firewalls try and strip content from data (like 
ActiveX controls.)

Running git on port 53 will bypass pretty much every firewall out there.

(If you want to learn how to bypass an overactive firewall, talk to a 
bunch of teenagers at a school with an agressive porn filter.)

-- 
"ANSI C says access to the padding fields of a struct is undefined.
ANSI C also says that struct assignment is a memcpy. Therefore struct
assignment in ANSI C is a violation of ANSI C..."
                                   - Alan Cox
