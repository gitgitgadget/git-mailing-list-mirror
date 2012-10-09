From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: [PATCH] t/t5400-send-pack: Use POSIX options to cp for portability
Date: Tue, 9 Oct 2012 09:15:25 +0200
Message-ID: <k50iuv$j0b$1@ger.gmane.org>
References: <1349683681-18978-1-git-send-email-bdwalton@gmail.com> <7vlifgncq8.fsf@alter.siamese.dyndns.org> <7vd30snbtk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 09:16:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLU2w-0004Ii-TP
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 09:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522Ab2JIHP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 03:15:57 -0400
Received: from plane.gmane.org ([80.91.229.3]:33390 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751669Ab2JIHPz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 03:15:55 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TLU2p-0004Gm-On
	for git@vger.kernel.org; Tue, 09 Oct 2012 09:15:59 +0200
Received: from dsdf-4db5c6de.pool.mediaways.net ([77.181.198.222])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Oct 2012 09:15:59 +0200
Received: from jojo by dsdf-4db5c6de.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Oct 2012 09:15:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db5c6de.pool.mediaways.net
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207306>

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Ben Walton <bdwalton@gmail.com> writes:
>>
>>> Avoid a GNU-ism in the cp options used by t5400-send-pack.  Change
>>> -a
>>> to -pR.
>>>
>>> Signed-off-by: Ben Walton <bdwalton@gmail.com>
>>> ---
>>
>> Thanks, but is "-p" essential for this test to pass, or can we get
>> away with just "-R"?
>
> Besides, when you spot a potential problem, please ask "git grep"
> to catch them all.
>
>    $ git grep "cp -a" t/
>    t/t5400-send-pack.sh:   cp -a parent child &&
>    t/t5550-http-fetch.sh:  cp -a
>    .git"$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> t/t5800-remote-helpers.sh:      cp -a server server2 &&


There's 2 more places in Documentation/git-tutorial.txt. There it looks like 
we'd want to use 'cp -pR' instead

Bye, Jojo 
