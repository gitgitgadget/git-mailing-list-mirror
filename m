From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] Make "git stash" configurable
Date: Fri, 21 Dec 2007 10:26:16 -0800
Message-ID: <74FF0697-8157-4308-8BA4-A1C7D0C7D260@midwinter.com>
References: <200712211026.lBLAQWWM014059@mi0.bluebottle.com> <2AB285BD-DA6E-49D1-B664-B1A8B552DD76@midwinter.com> <vpq4pec7yb8.fsf@bauges.imag.fr> <7v3atw7x33.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?UTF-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 19:26:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5ma6-0001aD-4I
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 19:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562AbXLUS0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 13:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752720AbXLUS0U
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 13:26:20 -0500
Received: from tater.midwinter.com ([216.32.86.90]:47928 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752352AbXLUS0T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 13:26:19 -0500
Received: (qmail 16756 invoked from network); 21 Dec 2007 18:26:17 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=DVTQlAbEAtj4mZBgdKqHFmXWg5iv6ZLYgQCYdJNRKFdCiMiJh6F9X16M+/6QVuP3  ;
Received: from localhost (127.0.0.1)
  by localhost with SMTP; 21 Dec 2007 18:26:17 -0000
In-Reply-To: <7v3atw7x33.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Dec 21, 2007, at 9:54 AM, Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>> It also makes portable scripts harder. It's easy to write a script
>> that works only if you have the option set ...
>
> In general I'd agree but in this particular case I do not think
> that applies.  Scripts can always say what they want, either
> "stash save" or "stash list".

I bet Matthieu meant that it's easy for someone who runs bare "git  
stash" all the time to forget that there's an option to make that  
command do something different, and to thus code up a local script  
that runs the command as they're used to running it. Such a script  
will work just fine for them but it'll break as soon as they give it  
to someone else who has the option set differently.

-Steve
