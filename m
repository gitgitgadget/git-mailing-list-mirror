From: Eli Collins <eli@cloudera.com>
Subject: Re: [PATCH] diff: add a 'path' meta header for non-renames and 
	non-copies
Date: Wed, 5 May 2010 14:14:42 -0700
Message-ID: <w2ndfe484f01005051414p294820f8jbf974b0cde20236d@mail.gmail.com>
References: <1272852221-14927-1-git-send-email-eli@cloudera.com>
	 <1272868072-12120-1-git-send-email-bert.wesarg@googlemail.com>
	 <7viq75tpaw.fsf@alter.siamese.dyndns.org>
	 <z2m36ca99e91005030037jb880e65w73efa551a53d7be6@mail.gmail.com>
	 <7v1vdtt0d7.fsf@alter.siamese.dyndns.org>
	 <m2i36ca99e91005031555x4bb2df54yb47058d9f7d5342c@mail.gmail.com>
	 <7v8w80sb5b.fsf@alter.siamese.dyndns.org>
	 <AANLkTilsk7Hh0oN72SfOlRK92qQhjVa-rNYUtVHocEj0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed May 05 23:14:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9lvd-0002qy-5q
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 23:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755519Ab0EEVOo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 May 2010 17:14:44 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:62313 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754049Ab0EEVOn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 May 2010 17:14:43 -0400
Received: by pxi5 with SMTP id 5so1737416pxi.19
        for <git@vger.kernel.org>; Wed, 05 May 2010 14:14:42 -0700 (PDT)
Received: by 10.142.56.4 with SMTP id e4mr6700694wfa.308.1273094082409; Wed, 
	05 May 2010 14:14:42 -0700 (PDT)
Received: by 10.142.88.2 with HTTP; Wed, 5 May 2010 14:14:42 -0700 (PDT)
In-Reply-To: <AANLkTilsk7Hh0oN72SfOlRK92qQhjVa-rNYUtVHocEj0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146420>

Ditto.  I frequently generate patches for other systems (primarily
svn) and they require diffs w/o perfixes.  Seemed like there should be
a way to enable this option in gitconfig so users don't need to type
--no-prefix w every diff invocation or use an alias (aliasing diff to
diff --no-prefix in gitconfig doesn't work and wouldn't be a good idea
anyway).

Thanks,
Eli


On Tue, May 4, 2010 at 12:30 PM, Bert Wesarg <bert.wesarg@googlemail.co=
m> wrote:
> On Tue, May 4, 2010 at 03:34, Junio C Hamano <gitster@pobox.com> wrot=
e:
>> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>>
>>> ... do you have any other
>>> thoughts on adding a <path> extended header for non-renames and
>>> non-copies?
>>
>> Other than "Why do we even need it?", no. =A0We actually have been c=
areful
>> when designing the output format to make sure that necessary informa=
tion
>> appears.
>>
>> See also this thread:
>>
>> =A0 =A0http://thread.gmane.org/gmane.comp.version-control.git/3990/f=
ocus=3D4002
>>
>> I wasn't too opposed to having a separate "Index: " line (or Anton's
>> "name") like CVS does, but the conclusion of the thread was that it =
is not
>> necessary.
>>
>
> Thanks for the pointer. The discussion revolves around technical
> arguments and the conclusion that this extra information is not
> necessary is reasonable. My intention for this information comes only
> from the usability and convenience side: I want a path without any
> prefix which I can select in the terminal and use this to open the
> file. Thats why it is only an option for the UI interface.
>
> Bert
>
