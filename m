From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: still getting 'It is a submodule!" in 1.6.2.5
Date: Wed, 06 May 2009 09:31:19 +0200
Message-ID: <op.uthy6h131e62zd@merlin.emma.line.org>
References: <gtnjq8$317$1@ger.gmane.org>
 <7vy6tc2gnt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>,
	"Tim Olsen" <tim@brooklynpenguin.com>
X-From: git-owner@vger.kernel.org Wed May 06 09:31:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1bbY-0006OH-3C
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 09:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237AbZEFHb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 03:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754128AbZEFHbZ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 03:31:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:39807 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753591AbZEFHbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 03:31:25 -0400
Received: (qmail invoked by alias); 06 May 2009 07:31:23 -0000
Received: from e179171104.adsl.alicedsl.de (EHLO mandree.no-ip.org) [85.179.171.104]
  by mail.gmx.net (mp024) with SMTP; 06 May 2009 09:31:23 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX1+ome0wZjeoEYrz8xYO5C59k0eJlaC+KoZG9nNhGk
	9+OlFsj3yq07uj
Received: from merlin.emma.line.org (localhost [127.0.0.1])
	by merlin.emma.line.org (Postfix) with ESMTP id B84DF9458F;
	Wed,  6 May 2009 09:31:19 +0200 (CEST)
In-Reply-To: <7vy6tc2gnt.fsf@alter.siamese.dyndns.org>
User-Agent: Opera Mail/9.64 (Linux)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118330>

Am 05.05.2009, 08:43 Uhr, schrieb Junio C Hamano <gitster@pobox.com>:

> Tim Olsen <tim@brooklynpenguin.com> writes:
>
>> Clemens replied with a patch [2], but I don't think it got into git's  
>> git.
>>
>> Junio replied with two versions of a patch [3, 4], of which one of them
>> appears to have made it into git's git as commit
>> 7dae8b21c2fe39a59661c709f0dc17090dafa5a4
>>
>> 1.6.2.5 was then released yesterday which has commit
>> 7dae8b21c2fe39a59661c709f0dc17090dafa5a4.
>
> But that is not the one you want.  7dae8b2 (diff -c -p: do not die on
> submodules, 2009-04-29) is to allow viewing of such a merge correctly; To
> make the merge automatically, you'd need 0c44c94 (merge-recursive: do not
> die on a conflicting submodule, 2009-04-29), which is on 'master', but  
> not
> on 1.6.2.X (and likely will never be).
>
> Could you be running 1.6.3-rcX instead of 1.6.2.X?  In general, the tip  
> of
> the 'master' is always as stable as any released version, if not more.

Is there an easy-to-find and easy-to-grasp table that lists which branches  
are recommended for which target group? If there is, I have constantly  
missed it.

May I suggest that there be a remark on the download page of git-scm.com  
that "master" is really the recommended branch?

-- 
Matthias Andree
