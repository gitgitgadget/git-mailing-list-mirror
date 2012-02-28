From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Tilde spec - befuzzled
Date: Tue, 28 Feb 2012 12:34:44 +0100
Message-ID: <87zkc38a3v.fsf@thomas.inf.ethz.ch>
References: <4F4C995D.9000504@diamand.org> <4F4CA354.2070503@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Luke Diamand <luke@diamand.org>, Git List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Feb 28 12:34:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2LKX-0005TB-9O
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 12:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965287Ab2B1Ler (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 06:34:47 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:31945 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965053Ab2B1Ler (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 06:34:47 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 28 Feb
 2012 12:34:44 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 28 Feb
 2012 12:34:44 +0100
In-Reply-To: <4F4CA354.2070503@op5.se> (Andreas Ericsson's message of "Tue, 28
	Feb 2012 10:50:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191711>

Andreas Ericsson <ae@op5.se> writes:

> On 02/28/2012 10:07 AM, Luke Diamand wrote:
>> The documentation for caret and tilde specs is making my head hurt, even though they always _do_ exactly what I want. And I thought I understood them until I read more carefully.
>> 
>> A suffix '{caret}' to a revision parameter means the first parent of
>> that commit object. '{caret}<n>' means the <n>th parent (i.e.
>> '<rev>{caret}'
>> 
>> So far, so good.
>> 
>> '<rev>{tilde}<n>', e.g. 'master{tilde}3'::
>> A suffix '{tilde}<n>' to a revision parameter means the commit
>> object that is the <n>th generation grand-parent of the named
>> commit object, following only the first parents.
>> 
>> Hang on, *grand*-parents?
>> 
>
> Replace "grand-parent" with "ancestor" and your head might hurt a
> little less. Caret only ever describes parent, while tilde can
> describe either parent or n'th generation grand-parent. Since parent
> and grand-parent are all ancestors, that would be a better term.

Perhaps we should reword it as "n-th first-parent ancestor"?  Barring
confusion about the position of the dashes, that leaves little room for
error.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
