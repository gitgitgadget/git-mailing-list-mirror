From: Sergei Organov <osv@javad.com>
Subject: Re: git help error
Date: Tue, 04 Dec 2007 21:33:03 +0300
Message-ID: <874pey9uow.fsf@osv.gnss.ru>
References: <cc723f590712040826o7ca36bfg35b8cb4d64ee8d2d@mail.gmail.com>
	<7v1wa25oqc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Aneesh Kumar" <aneesh.kumar@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 19:34:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izcac-0005NG-IQ
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 19:33:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbXLDSda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 13:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbXLDSda
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 13:33:30 -0500
Received: from javad.com ([216.122.176.236]:3114 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750813AbXLDSd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 13:33:29 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lB4IX9U37384;
	Tue, 4 Dec 2007 18:33:12 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1IzcZr-0006EQ-LY; Tue, 04 Dec 2007 21:33:03 +0300
In-Reply-To: <7v1wa25oqc.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Tue\, 04 Dec 2007 09\:55\:23 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67073>

Junio C Hamano <gitster@pobox.com> writes:
> "Aneesh Kumar" <aneesh.kumar@gmail.com> writes:
>
>> git help gives me the below error.
>>
>> [master@git]$ git help add
>> No manual entry for git-add
>> See 'man 7 undocumented' for help when manual pages are not available.
>> [master@git]$
>>
>> I have the git binaries installed via --prefix
>>
>> ./configure --prefix=/home/kvaneesh/bin-local/git/
>> and to see the man page i have to say
>>
>> man -M /home/kvaneesh/bin-local/git/share/man/
>>
>> I guess git-help need to take care of the prefix.
>
> When you run "man" from the command line, can you say
>
>      $ man git-add
>
> and make it work?  If it fails the same way, then what you are missing
> is MANPATH environment variable, isn't it?

I think what the OP asked for makes sense. git-help should better find
corresponding version of manual pages automatically. This way, if one
invokes different versions of git-help, he will get corresponding
version of help text.

-- 
Sergei.
