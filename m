From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git help error
Date: Tue, 04 Dec 2007 09:55:23 -0800
Message-ID: <7v1wa25oqc.fsf@gitster.siamese.dyndns.org>
References: <cc723f590712040826o7ca36bfg35b8cb4d64ee8d2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Aneesh Kumar" <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 18:56:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izc0k-0006Hs-VO
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 18:56:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150AbXLDRzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 12:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754564AbXLDRza
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 12:55:30 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:38426 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753863AbXLDRz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 12:55:29 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id CE6722FB;
	Tue,  4 Dec 2007 12:55:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 581989CD70;
	Tue,  4 Dec 2007 12:55:47 -0500 (EST)
In-Reply-To: <cc723f590712040826o7ca36bfg35b8cb4d64ee8d2d@mail.gmail.com>
	(Aneesh Kumar's message of "Tue, 4 Dec 2007 21:56:48 +0530")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67069>

"Aneesh Kumar" <aneesh.kumar@gmail.com> writes:

> git help gives me the below error.
>
> [master@git]$ git help add
> No manual entry for git-add
> See 'man 7 undocumented' for help when manual pages are not available.
> [master@git]$
>
> I have the git binaries installed via --prefix
>
> ./configure --prefix=/home/kvaneesh/bin-local/git/
> and to see the man page i have to say
>
> man -M /home/kvaneesh/bin-local/git/share/man/
>
> I guess git-help need to take care of the prefix.

When you run "man" from the command line, can you say

     $ man git-add

and make it work?  If it fails the same way, then what you are missing
is MANPATH environment variable, isn't it?
