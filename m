From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH/RFC v5 1/1] more cache effective symlink/directory detection
Date: Sun, 11 Jan 2009 09:26:14 +0100
Organization: private
Message-ID: <86vdsm8d09.fsf@broadpark.no>
References: <1231527954-868-1-git-send-email-barvik@broadpark.no>
 <1231527954-868-2-git-send-email-barvik@broadpark.no>
 <49687440.5090506@lsrfire.ath.cx> <7vljtivfao.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 11 09:27:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLvfc-0004rD-7F
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 09:27:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbZAKI0T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Jan 2009 03:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbZAKI0T
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 03:26:19 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:57881 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbZAKI0R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jan 2009 03:26:17 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KDA00DFHSRSDU00@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 11 Jan 2009 09:26:16 +0100 (CET)
Received: from localhost ([80.203.78.153]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KDA00JNNSRR1R60@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 11 Jan 2009 09:26:16 +0100 (CET)
In-reply-to: <7vljtivfao.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105156>

Junio C Hamano <gitster@pobox.com> writes:

> Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>
>> Kjetil Barvik schrieb:
>>> - Also introduce a 'void clear_lstat_cache(void)' function, which
>>>   should be used to clean the cache before usage.  If for instance,
>>>   you have changed the types of directories which should be cached,
>>>   the cache could contain a path which was not wanted.
>>
>> Is it possible to make the cache detect these situations automatical=
ly
>> by saving track_flags along with the cache contents?  Not having to
>> clear the cache manually would be a major feature.
>
>> Also, it's probably worth to split this patch up again.  First switc=
hing
>> to your improved implementation of has_symlink_leading_path(), then
>> introducing has_symlink_or_noent_leading_path() and finally adding
>> LSTAT_FULLPATH and the fourth parameter of lstat_cache() etc. and us=
ing
>> this feature in entry.c seems like a nice incremental progression.
>
> Both are reasonable suggestions.  Thanks.

  Ok!  Thanks for comments!  Version 6 will follow shortly!

  -- kjetil
