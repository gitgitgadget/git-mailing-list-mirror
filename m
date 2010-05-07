From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Re: git log -M -- filename is not working?
Date: Fri, 07 May 2010 22:25:35 +0200
Message-ID: <vpqfx23wjb4.fsf@bauges.imag.fr>
References: <z2w76c5b8581005071107w79d30963g725269febe746f0@mail.gmail.com>
	<h2m8c9a061005071110nf7e63220ked03598bfa66fbc9@mail.gmail.com>
	<z2r76c5b8581005071131q15524cb8td6711dbb9142b28e@mail.gmail.com>
	<19428.24021.324557.517627@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eugene Sajine <euguess@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Fri May 07 22:25:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAU7J-0006Bv-9p
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 22:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758210Ab0EGUZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 16:25:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47074 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757090Ab0EGUZm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 16:25:42 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o47KJUqM025428
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 7 May 2010 22:19:30 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OAU75-0004YZ-9z; Fri, 07 May 2010 22:25:35 +0200
In-Reply-To: <19428.24021.324557.517627@winooski.ccs.neu.edu> (Eli Barzilay's message of "Fri\, 7 May 2010 14\:37\:09 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 07 May 2010 22:19:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o47KJUqM025428
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1273868375.04366@zACqfznqr2XTEvgZWv/YUw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146588>

Eli Barzilay <eli@barzilay.org> writes:

> On May  7, Eugene Sajine wrote:
>> On Fri, May 7, 2010 at 2:10 PM, Jacob Helwig <jacob.helwig@gmail.com> wrote:
>> > You want the --follow flag, too.
>> 
>> Thanks! I missed this guy. By the way it seems that --follow flag
>> works without -M or -C.
>> 
>> Are those deprecated or I'm missing the difference between three of
>> them??
>
> BTW, I've had at least 4 people now who got confused by this.  Is
> there any use for -M/-C without --follow?  In any case, it will be
> very helpful if the -M/-C descriptions said "see also --follow".
>
> Also, is there a way to set this as the default for `git log'?

I guess -M and -C are here because log accepts all options that diff
accepts, in case you run "git log -p". Then, -M and -C control what
diff is displayed to the user.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
