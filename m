From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] Fix t3700 on filesystems which do not support question marks in names
Date: Fri, 15 Aug 2008 01:30:05 -0700
Message-ID: <32AE3B17-2608-4C0F-93F6-E62937B332D1@sb.org>
References: <81b0412b0808150011r534d8453yab2a5c42b255657f@mail.gmail.com> <7vproabvcr.fsf@gitster.siamese.dyndns.org> <81b0412b0808150023sd30559fi68ff1e439013f26e@mail.gmail.com> <81b0412b0808150032o20f69346jb4f573b78cd11f2b@mail.gmail.com> <333CFE63-8410-45F5-9483-4AC6FFEB57F3@sb.org>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 15 10:31:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTuiG-0001NT-PC
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 10:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757399AbYHOIaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 04:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757320AbYHOIaJ
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 04:30:09 -0400
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:45610 "EHLO
	randymail-a12.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757110AbYHOIaI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Aug 2008 04:30:08 -0400
Received: from [192.168.1.101] (c-76-103-51-229.hsd1.ca.comcast.net [76.103.51.229])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a12.g.dreamhost.com (Postfix) with ESMTP id 6981C19CC01;
	Fri, 15 Aug 2008 01:30:12 -0700 (PDT)
In-Reply-To: <333CFE63-8410-45F5-9483-4AC6FFEB57F3@sb.org>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92466>

On Aug 15, 2008, at 1:23 AM, Kevin Ballard wrote:

> Wow, trying to use git-am to apply this patch bus errors. This isn't  
> good. Specifically, git mailinfo bus errors when the email is piped  
> to it. Curiously, the attached "patch" is actually another MIME- 
> formatted message with an inline patch. And I can pipe this "patch"  
> to git-am and that works. How did you generate this message?

Ok, it turns out that Don Zickus's patch "Allow emails with boundaries  
to work again [v2]" fixes the crash.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
