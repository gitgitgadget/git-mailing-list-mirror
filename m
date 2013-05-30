From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (May 2013, #09; Wed, 29)
Date: Thu, 30 May 2013 21:23:40 +0200
Message-ID: <51A7A73C.6070103@web.de>
References: <7va9ndqqyf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 30 21:24:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui8SC-0003Lg-RU
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 21:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759327Ab3E3TYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 15:24:00 -0400
Received: from mout.web.de ([212.227.15.3]:58551 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758515Ab3E3TX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 15:23:59 -0400
Received: from [192.168.178.41] ([91.3.184.137]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MLPaA-1UhaDW3AOY-000hj3; Thu, 30 May 2013 21:23:40
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <7va9ndqqyf.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:5tLIGE5uPki9Q6DurbQvAneyRx1jJW5p6jzW58KjCXp
 pzqvDyPsnt1VZJ2gaebB/JPISkZqvSeZTPw8jL5Av14hErGlt/
 0pNTpWTvpPVdg6k+3BU8e2YUP7XHs869Fq1/wJFRbQWpc8vM08
 fw3TZc1xstorvpnvtRfKX95CkZj7SwI5/7lN8B0X12+GbRao2A
 2+pqAhgFudUWFdLDJOp1A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226030>

Am 30.05.2013 01:58, schrieb Junio C Hamano:
> * jk/submodule-subdirectory-ok (2013-04-24) 3 commits
>   (merged to 'next' on 2013-04-24 at 6306b29)
>  + submodule: fix quoting in relative_path()
>   (merged to 'next' on 2013-04-22 at f211e25)
>  + submodule: drop the top-level requirement
>  + rev-parse: add --prefix option
> 
>  Allow various subcommands of "git submodule" to be run not from the
>  top of the working tree of the superproject.

The summary and status commands are looking good in this version
(they are now showing the submodule directory paths relative to
the current directory). Apart from that my other remarks from
gmane $221575 still seem to apply. And this series has only tests
for status, summary and add (and that just with an absolute URL),
I'd rather like to see a test for each submodule command (and a
relative add to) to document the desired behavior.

But I'm not sure if it's better to have another iteration of this
series or to address the open issues a follow-up series. Having
status, summary and add - at least with absolute URLs - lose the
toplevel requirement is already a huge improvement IMO. Opinions?
