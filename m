From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] In Examples, explain option -r and refer to git-rev-list[1]
Date: Mon, 27 Aug 2007 01:14:02 -0700
Message-ID: <7vy7fxl7hx.fsf@gitster.siamese.dyndns.org>
References: <r6lqfgnp.fsf@cante.net> <46D28502.3030003@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Lukas =?utf-8?Q?Sandstr=C3=B6m?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Mon Aug 27 10:14:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPZjg-0007no-EW
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 10:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbXH0IOI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 27 Aug 2007 04:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbXH0IOH
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 04:14:07 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:36045 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbXH0IOG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Aug 2007 04:14:06 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 28EE11292A9;
	Mon, 27 Aug 2007 04:14:26 -0400 (EDT)
In-Reply-To: <46D28502.3030003@etek.chalmers.se> (Lukas =?utf-8?Q?Sandstr?=
 =?utf-8?Q?=C3=B6m's?= message of
	"Mon, 27 Aug 2007 10:02:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56774>

Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se> writes:

> Jari Aalto wrote:
>> Signed-off-by: Jari Aalto <jari.aalto@cante.net>
>> ---
>>  Documentation/git-log.txt |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>=20
>> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
>> index 49bb539..aa42f0e 100644
>> --- a/Documentation/git-log.txt
>> +++ b/Documentation/git-log.txt
>> @@ -76,7 +76,8 @@ git log -r --name-status release..test::
>> =20
>>  	Show the commits that are in the "test" branch but not yet
>>  	in the "release" branch, along with the list of paths
>> -	each commit modifies.
>> +	each commit modifies. Opton -r (see gitlink:git-rev-list[1])
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ spelling mistake (option)

I think it makes more sense to make Porcelain including "git
log" to always recurse in its diff operations (when diff output
is asked for), in which case the example should simply lose
the "-r" option.

But that is a post-1.5.3 change.  That's why I am planning to
drop this patch for now.
