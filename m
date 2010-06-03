From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2010, #01; Wed, 2)
Date: Thu, 3 Jun 2010 11:13:45 +0800
Message-ID: <AANLkTimuTIugURlYxwbk7wGW2IM11YTy4P91YDguLQUb@mail.gmail.com>
References: <7v4ohlatwn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 05:13:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OK0sT-0002LW-Pu
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 05:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933755Ab0FCDNs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jun 2010 23:13:48 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38139 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933726Ab0FCDNr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jun 2010 23:13:47 -0400
Received: by iwn6 with SMTP id 6so1594619iwn.19
        for <git@vger.kernel.org>; Wed, 02 Jun 2010 20:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NCPBkbVz/UMnL8DN4OIU43MPfQUgwCMReE8ASyKbt04=;
        b=N4WT63jgG0M3/fy/+kHOS2X+i/Xd1CMQ27yl4hDjNK0nF4vrSGM3qcVRAsbBtZePfd
         PtG0jvITtOR/Qr9AG8Mmuf01UA9OkYZ0fJ367/dCEV2BVGS58FW3LNitecKqu+aDjqIn
         jRssEgStPEPfxOV2ZvuVJqlwuJJBTGk+a2HuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=W/v6rFb/gs3NomNr08glhQw9459RQZeYXFpllra81iOvxUMroR6NylU3G1RIWuOBO4
         ZUWfBZkXRrT6z8HVleBOgV5tqUp1t3WvYfK/EzC6VkM5A6YeAG70LRz0SR+LL8xInKtd
         86bQ9kFZTUu5JRh5LPuGw1PJB11evPIszKlf0=
Received: by 10.231.147.143 with SMTP id l15mr11101951ibv.9.1275534825989; 
	Wed, 02 Jun 2010 20:13:45 -0700 (PDT)
Received: by 10.231.14.199 with HTTP; Wed, 2 Jun 2010 20:13:45 -0700 (PDT)
In-Reply-To: <7v4ohlatwn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148287>

Hi,

On Thu, Jun 3, 2010 at 7:36 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> [New Topics]
> [snip]
> * tc/commit-abbrev-fix (2010-05-27) 3 commits
> =A0- commit::print_summary(): set rev_info.always_show_header to 1
> =A0- t7502-commit: add summary output tests for empty and merge commi=
ts
> =A0- t7502-commit: add tests for summary output
>
> Will merge to 'next'. =A0I am not quite happy about the "impossible t=
o
> trigger" die message, though. =A0It is a good defensive programming t=
o catch
> breakages caused by future changes that may invalidate the assumption=
 this
> patch makes, but then the message should be worded as such to state t=
hat
> assumption, I think.

I'll try to remember to re-send the third patch with your suggestion
about the message.

> [Cooking]
> [snip]
> * tc/merge-m-log (2010-05-11) 8 commits
> =A0(merged to 'next' on 2010-05-21 at e889876)
> =A0+ merge: --log appends shortlog to message if specified
> =A0+ fmt-merge-msg: add function to append shortlog only
> =A0+ fmt-merge-msg: refactor merge title formatting
> =A0+ fmt-merge-msg: minor refactor of fmt_merge_msg()
> =A0+ merge: rename variable
> =A0+ merge: update comment
> =A0+ t7604-merge-custom-message: show that --log doesn't append to -m
> =A0+ t7604-merge-custom-message: shift expected output creation

=46WIW, I've been using this feature for as long as it's been cooking -
no issues thus far.

--=20
Cheers,
Ray Chuan
