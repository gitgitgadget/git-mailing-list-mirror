From: Rune Philosof <rune@philosof.dk>
Subject: Re: [PATCH 1/2] Complain in the tests about git config not failing
 with, keys without a section
Date: Mon, 05 Mar 2012 08:59:29 +0100
Message-ID: <4F547261.7000506@philosof.dk>
References: <4F50A79E.5060206@philosof.dk> <7v8vjiethh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 08:59:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Spa-000478-Tz
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 08:59:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756340Ab2CEH7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 02:59:38 -0500
Received: from mailout-limhamn.gigahost.dk ([94.246.99.122]:58801 "EHLO
	mailout-limhamn.gigahost.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755914Ab2CEH7h (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2012 02:59:37 -0500
Received: from mailout.gigahost.dk (mailout.gigahost.dk [217.116.232.226])
	by mailout-limhamn.gigahost.dk (Postfix) with ESMTP id 795D71882138;
	Mon,  5 Mar 2012 07:59:30 +0000 (UTC)
Received: from smtp.gigahost.dk (unknown [89.186.169.107])
	by mailout.gigahost.dk (Postfix) with ESMTP id 5BE6D1D70257;
	Mon,  5 Mar 2012 08:59:30 +0100 (CET)
Received: from [10.101.85.57] (pc.tv2.dk [193.88.88.10])
	by smtp.gigahost.dk (Postfix) with ESMTPSA id 48FD823408C;
	Mon,  5 Mar 2012 08:59:30 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7v8vjiethh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192213>

On 02-03-2012 19:40, Junio C Hamano wrote:
>> git is supposed to fail when having a key without a section, but does not.
> I do not think anybody said it is supposed to fail in this case.
>
> the behaviour for a single level name is just "undefined", which is very different from "must fail".

Quoting from `git help config`:
This command will fail if:
  3. no section was provided,
...
under SYNTAX
  Each variable must belong to some section, which means that there must 
be a section header before the first
        setting of a variable.

--
Greeting
Rune Philosof
