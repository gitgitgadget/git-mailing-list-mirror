From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [PATCH] Documentation: clarify commits affected by gitk --merge
Date: Sun, 8 Feb 2009 01:15:05 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngoscgp.qdh.sitaramc@sitaramc.homelinux.net>
References: <20090206044053.GA6831@atcmail.atc.tcs.com>
 <7vtz75udj6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 02:16:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVyHv-0001E6-Eu
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 02:16:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388AbZBHBPT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Feb 2009 20:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752228AbZBHBPT
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 20:15:19 -0500
Received: from main.gmane.org ([80.91.229.2]:48841 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752178AbZBHBPS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 20:15:18 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LVyGS-0000gv-Rz
	for git@vger.kernel.org; Sun, 08 Feb 2009 01:15:16 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 01:15:16 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 01:15:16 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108907>

On 2009-02-07, Junio C Hamano <gitster@pobox.com> wrote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
>>  	After an attempt to merge stops with conflicts, show the commits o=
n
>>  	the history between two branches (i.e. the HEAD and the MERGE_HEAD=
)
>> -	that modify the conflicted files.
>> +	that modify the conflicted files and do not exist on all the heads
>> +	being merged.
>
> I do not understand what you are trying to add here, sorry.

It's basically the same thing as the explanation for --merge
in 'git help log':
   --merge
       After a failed merge, show refs that touch files
       having a conflict and don=C2=B4t exist on all heads to
       merge.

I'm pretty sure gitk is doing the same thing, so I thought
the extra text should be added.

Regards,

Sitaram
