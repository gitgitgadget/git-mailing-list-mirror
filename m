From: Pedro Melo <melo@simplicidade.org>
Subject: Re: linking libgit.a in C++ projects
Date: Thu, 31 Jul 2008 12:16:45 +0100
Message-ID: <0EC13CCC-0F7B-41A0-BEB2-67E6EC8D5E37@simplicidade.org>
References: <ac9f0f090807310253v1d97e2a1n4ddf34aa4fdc79f0@mail.gmail.com> <20080731105727.GF7008@dpotapov.dyndns.org> <ac9f0f090807310410u461f5584ved74769d8452c539@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>, git@vger.kernel.org
To: cte <cestreich@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 13:18:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOWAI-00054f-EG
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 13:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbYGaLQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 07:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbYGaLQt
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 07:16:49 -0400
Received: from mail.sl.pt ([212.55.140.13]:46411 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751783AbYGaLQs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 07:16:48 -0400
Received: (qmail 22807 invoked from network); 31 Jul 2008 11:16:45 -0000
Received: from unknown (HELO [10.0.0.201]) (melo@[195.23.56.34])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <cestreich@gmail.com>; 31 Jul 2008 11:16:45 -0000
In-Reply-To: <ac9f0f090807310410u461f5584ved74769d8452c539@mail.gmail.com>
Jabber-Id: melo@simplicidade.org
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90929>


On Jul 31, 2008, at 12:10 PM, cte wrote:
> On Thu, Jul 31, 2008 at 3:57 AM, Dmitry Potapov <dpotapov@gmail.com>  
> wrote:
>> On Thu, Jul 31, 2008 at 02:53:37AM -0700, cte wrote:
>>> However, the git source uses a few reserved C++ keywords; namely
>>> 'typename', and 'new'.
>>
>> Because this source code are meant to be compiled by C and not by C+ 
>> +!
>> Even if we will have real git library for other applications to use,
>> it still be compiled only by C. Thus, C++ keywords are not issue.
>
[...]
> Fortunately, g++ can compile C programs and link static libraries that
> were compiled by C compilers, unless of course, they use C++ keywords.
> I don't think it is unreasonable to rename the _very few_ C++ keywords
> in git's source in the interest of allowing C++ projects to leverage
> libgit.

I think the point Dmitry was trying to make is that you should compile  
libgit as C, using gcc, and then link it with your C++/Objective C code.

No patch is required to git, only to your makefile/xcode project file.

Best regards,
-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
