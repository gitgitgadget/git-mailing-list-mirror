From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Unresolved issues #3
Date: Fri, 18 Aug 2006 07:56:34 -0700
Message-ID: <44E5D522.8030407@gmail.com>
References: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net> <44E546F2.7070902@gmail.com> <Pine.LNX.4.64.0608181041420.11359@localhost.localdomain>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 16:56:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE5mF-0004KO-T5
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 16:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbWHRO4t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 10:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030456AbWHRO4s
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 10:56:48 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:31087 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030258AbWHRO4s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 10:56:48 -0400
Received: by nz-out-0102.google.com with SMTP id 14so25109nzn
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 07:56:47 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=hsKXQoIMyl26zZQGfQZAW5NVNgEOngmIb9sBA4EMIINrjmNHkQRH7Ng1bcIHa9A8GRWuZzKwxEjCTocLS8SOzu/s6eXzjkNIzc8j3sndWkDqB94y5ms7niP7QkvjcYjED86gTwExTLWCxAMb7g/dnqvAwvUuWIse+KzYuouRsYo=
Received: by 10.65.176.7 with SMTP id d7mr2270991qbp;
        Fri, 18 Aug 2006 07:56:47 -0700 (PDT)
Received: from ?10.0.0.6? ( [68.234.172.127])
        by mx.gmail.com with ESMTP id 17sm859980nzo.2006.08.18.07.56.45;
        Fri, 18 Aug 2006 07:56:47 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0608181041420.11359@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25669>

Nicolas Pitre wrote:
> On Thu, 17 Aug 2006, A Large Angry SCM wrote:
...
>>
>> 1) I disagree with Nico's assessment that, other than his, there can not
>> exist any type 2 packs that have bit 6 set to mean copy from result.
> 
> Care to explain why?
> 
> Since this code is mine I can tell you that no official GIT version ever 
                                              ^^^^^^^^^^^^^^^^^^^^^^^
> produced such a pack.  The code to make use of that bit was quite 
> involving and the end result wasn't great at all so I never published 
> said code.  This is also why current GIT accepts both pack version 2 and 
> 3 without any distinction using the same code in patch-delta.c on the 
> basis that no version 2 packs ever used that bit.

That doesn't prove the non-existence of other code to do it.
