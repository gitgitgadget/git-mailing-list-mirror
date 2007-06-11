From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Introduce optional "keywords" on tag objects
Date: Sun, 10 Jun 2007 18:01:35 -0700
Message-ID: <7vejkj4840.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
	<200706102104.48440.johan@herland.net>
	<7vabv77ael.fsf@assigned-by-dhcp.cox.net>
	<200706110116.15673.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 03:01:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxYHw-0007sz-OZ
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 03:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763106AbXFKBBh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 21:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763041AbXFKBBh
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 21:01:37 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:48973 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762958AbXFKBBg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 21:01:36 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070611010136.CDJ18396.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 10 Jun 2007 21:01:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id A11b1X00T1kojtg0000000; Sun, 10 Jun 2007 21:01:36 -0400
In-Reply-To: <200706110116.15673.johan@herland.net> (Johan Herland's message
	of "Mon, 11 Jun 2007 01:16:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49807>

Johan Herland <johan@herland.net> writes:

> On Sunday 10 June 2007, Junio C Hamano wrote:
>> Johan Herland <johan@herland.net> writes:
>> > For now, I couldn't find a good reason why the set of allowed characters
>> > for keywords should be smaller than for the tag name.
>> 
>> The set of allowed tag names excludes shell metacharacters,
>> primarily to help scripting.  
>
> It already does? Or are you proposing this? Right now the code doesn't 
> enforce anything like this, AFAICS...

Ah, I was being silly.  I somehow thought you were talking about
valid names you can have under refs/tags/.
