From: =?UTF-8?B?IkFsZWphbmRybyBSLiBTZWRlw7FvIg==?= <asedeno@MIT.EDU>
Subject: Re: [PATCH] git-svn: Add a svn-remote.<name>.pushurl config key
Date: Wed, 06 Apr 2011 08:56:41 -0400
Message-ID: <4D9C6309.8080809@mit.edu>
References: <4D9B310A.9020203@mit.edu> <1302034509-8842-1-git-send-email-asedeno@mit.edu> <4D9C6023.6040305@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	James Y Knight <jknight@itasoftware.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 06 14:57:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7SIK-0002TT-7t
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 14:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755986Ab1DFM47 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2011 08:56:59 -0400
Received: from DMZ-MAILSEC-SCANNER-4.MIT.EDU ([18.9.25.15]:63464 "EHLO
	dmz-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755976Ab1DFM45 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Apr 2011 08:56:57 -0400
X-AuditID: 1209190f-b7cf3ae0000046b8-aa-4d9c63135351
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
	by dmz-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 7F.7A.18104.3136C9D4; Wed,  6 Apr 2011 08:56:51 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id p36Cut49007992
	for <git@vger.kernel.org>; Wed, 6 Apr 2011 08:56:56 -0400
Received: from darkmatter.mit.edu (DARKMATTER.MIT.EDU [18.238.2.175])
	(authenticated bits=0)
        (User authenticated as smtp/darkmatter.mit.edu@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p36Cur4V012264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 6 Apr 2011 08:56:54 -0400 (EDT)
Received: by darkmatter.mit.edu (Postfix, from userid 108)
	id 3F16C14C021; Wed,  6 Apr 2011 08:56:53 -0400 (EDT)
Received: from [18.238.2.136] (JABUN.MIT.EDU [18.238.2.136])
	by darkmatter.mit.edu (Postfix) with ESMTPSA id 11F9114C00F;
	Wed,  6 Apr 2011 08:56:53 -0400 (EDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <4D9C6023.6040305@drmicha.warpmail.net>
X-Enigmail-Version: 1.1.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsUixG6nriucPMfX4ECblUXXlW4mB0aPz5vk
	AhijuGxSUnMyy1KL9O0SuDJ+rVjJUjCVu+Lg4n/sDYxvOboYOTkkBEwkjr2YyAJhi0lcuLee
	rYuRi0NIYB+jREfTQkYI5ySjxOsVG5khnI9MEhsOT2cCaRESKJK4OGUdK0RiMaPEuv13wGbx
	CqhJfLx1mRXEZhFQldh4rBusgU3ARWLJ42tsILaoQKZEx5737BD1ghInZz4B6xUR0Je4du4J
	2FBmgVmMEo9mT2QGSQgLeEhMO7Ya6oxGRonpb2+ATeIE+mJn4w1GiC8kJU4fPwK0jQOoW11i
	/TwhkDCzgLxE89bZzBMYRWYh2TcLoWoWkqoFjMyrGGVTcqt0cxMzc4pTk3WLkxPz8lKLdE30
	cjNL9FJTSjcxgsKeU5J/B+O3g0qHGAU4GJV4eFcsnu0rxJpYVlyZe4hRkoNJSZT3QsIcXyG+
	pPyUyozE4oz4otKc1OJDjBIczEoivKavZ/kK8aYkVlalFuXDpKQ5WJTEeWdJqvsKCaQnlqRm
	p6YWpBbBZGU4OJQkeOuSgIYKFqWmp1akZeaUIKSZODhBhvMADa8CqeEtLkjMLc5Mh8ifYlSU
	EucNAUkIgCQySvPgemFp6RWjONArwrxNIFU8wJQG1/0KaDAT0OCtU2aDDC5JREhJNTDW//mT
	yasT7ldcY8TK8PuWevOsji8LPjy1qj3ZbKe2n0m6pPl86bIc5gkxx1Vm3lGRiP6r6KsqcN6R
	l39bsmvF6etBX/Tar36Ku+54/su9igkPut6623yOXjwzWpj/s7yikUkHUx+T5p/o 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170971>

On 4/6/2011 8:44 AM, Michael J Gruber wrote:
> Alejandro R. Sede=C3=B1o venit, vidit, dixit 05.04.2011 22:15:
>> > Similar to the 'remote.<name>.pushurl' config key for git remotes,=
 the
>> > 'pushurl' key is treated the same as the 'url' key. This is distin=
ct
>> > from the 'commiturl' key, which is defined to be a full svn path.
>> >=20
>> > This is necessary if you want to be able to commit to multiple bra=
nches.
> Maybe one can understand this remark after reading the whole thread, =
but
> reading it as a commit message I'm wondering: Huh? How can I have bee=
n
> doing it then without pushurl?
>=20
> Also, "treated the same as the url" makes a reader wonder why we have
> two names for the same.
>=20
> The point of pushurl is that you can use a passwordless transport for
> fetches and another transport for pushes. The standing assumption is
> that both urls point in fact at the same repo. Weird things can happe=
n
> if not. Is that assumption the same for your svn pushurl?

Yes, that is the idea. I will rephrase the commit message and
documentation to be clearer when I send the next version of this patch.

When I say, "treated the same as the url," what I mean to say is that
any manipulations that would be done to 'url' are also done to
'pushurl', such as appending '/trunk' or '/branches/<branch-name>/' if
necessary, which does not happen with commiturl since it is a full snv =
path.

-Alejandro
