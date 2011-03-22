From: Daniel <daniel@netwalk.org>
Subject: Re: dependable submodules
Date: Mon, 21 Mar 2011 20:56:52 -0700
Message-ID: <AANLkTikv+Wf_nSt0GZj0WgPjpbk6Kr_WG-ueO6US9bUM@mail.gmail.com>
References: <AANLkTi=JVO+KhnLKR-PvNQQFaZLhUmiVbKFxuytYEpmc@mail.gmail.com>
	<7vd3lmv2k1.fsf@alter.siamese.dyndns.org>
	<AANLkTin8Mr5xLtLqHSVuEOzzfmqnR2LU5vDdVfPprNXn@mail.gmail.com>
	<4D877A70.8070907@jku.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, apenwarr@gmail.com
To: Robert Pollak <robert.pollak@jku.at>
X-From: git-owner@vger.kernel.org Tue Mar 22 04:57:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1siK-0002DQ-11
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 04:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171Ab1CVD4z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2011 23:56:55 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42066 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237Ab1CVD4y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 23:56:54 -0400
Received: by wwa36 with SMTP id 36so8296219wwa.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 20:56:53 -0700 (PDT)
Received: by 10.227.168.132 with SMTP id u4mr4771839wby.50.1300766212957; Mon,
 21 Mar 2011 20:56:52 -0700 (PDT)
Received: by 10.227.141.84 with HTTP; Mon, 21 Mar 2011 20:56:52 -0700 (PDT)
X-Originating-IP: [216.228.174.132]
In-Reply-To: <4D877A70.8070907@jku.at>
X-Google-Sender-Auth: bBkrD2T5CDbZRCrGcFlMHJKzw4M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169698>

On Mon, Mar 21, 2011 at 9:18 AM, Robert Pollak <robert.pollak@jku.at> w=
rote:
> =A0On 2011-03-20 Daniel wrote:
> [...]
>> So would it be correct to say that even though those files are
>> remotely fetched on a clone of the repository, they are actually
>> revisioned and stored in the super project?
>
> You might want to try Avery Pennarun's git-subtree, which seems to
> provide this functionality.
> It's at https://github.com/apenwarr/git-subtree.

I tried git-subtree. thanks but this is not what I wanted. This
removed the .git dir for the subtree and hence updating the subtree is
not easy.

I want the functionality of git submodule except that I don't want the
version checked in as part of the superproject to have to be fetched
remotely.

-d




--=20
"America was founded by men who understood that the threat of domestic
tyranny is as great as any threat from abroad. If we want to be worthy
of their legacy, we must resist the rush toward ever-increasing state
control of our society. Otherwise, our own government will become a
greater threat to our freedoms than any foreign terrorist."
=A0- Ron Paul, Texas Straight Talk, May 31, 2004
