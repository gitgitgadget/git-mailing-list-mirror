From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2010, #02; Wed, 11)
Date: Wed, 11 Aug 2010 20:41:08 -0500
Message-ID: <20100812014107.GA18937@burratino>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Bo Yang <struggleyb.nku@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 03:42:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjMoj-00078R-P3
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 03:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758887Ab0HLBmo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 21:42:44 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61316 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758831Ab0HLBmn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 21:42:43 -0400
Received: by qwh6 with SMTP id 6so814978qwh.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 18:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vb45aZu02aFf0le7cezUKowZV+JdiyqT4DirJEXsgkI=;
        b=B6TuudIdfHAz4JMMwFFAb6iek5bGTqXXN9cF0phxLCekVJaPNNepcbuR9QI7YdtrDM
         xp4r1IrExejpbs7EyJrL0W5o6GFjNKiHKL8gUrvIF0lLvUcuNsfevtW5Uli1HKJijEZW
         2XlcWGxQHlsu5771UYZdXNkyVs0xwQ/NyMWsc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=bkKqkU11eVQNJREj05ud3JfNIDq4je1Obzd5PjF8nOt5OTJWZvrk6VXs/xuMz+X3ie
         iGCISr5fA1rbohBobUVIidGq7Tv+PgVFqXsX7npk7oemI5z+BLDHH9y5c0fgibzr1oke
         Fb0pY82mMYiMfOcfdnvutYNTwBCYdLEcHfm2Q=
Received: by 10.220.62.5 with SMTP id v5mr12003949vch.242.1281577362384;
        Wed, 11 Aug 2010 18:42:42 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id a15sm442331vci.33.2010.08.11.18.42.41
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 18:42:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153323>

Junio C Hamano wrote:

> * by/line-log (2010-08-11) 18 commits

Is there a simple and current =E2=80=9Chere is how to try this code and=
 what
it will do for you=E2=80=9D document?

In my imagination such a document is about three lines, including an
example. :)

> * jn/commit-no-change-wo-status (2010-07-24) 9 commits
>  . commit: suppress status summary when no changes staged
>  . commit --dry-run: give advice on empty amend
=2E..

Could you revert the tip of this one?  What remains is a good
cleanup (+ change in --dry-run output for consistency), I think.

There was no positive feedback about suppressing the status summary.
I am afraid it might be a bad idea; I=E2=80=99d be happy if people have=
 other
ideas for making the output friendlier.

> * jn/merge-renormalize (2010-08-05) 12 commits
=2E..
>  . t4200 (rerere): modernize style
=2E..
>  . t6038 (merge.renormalize): style nitpicks

Should I resend with these two ejected into a separate series?

> * jn/paginate-fix (2010-08-05) 13 commits
=2E..
> I had trouble merging these three topics to 'pu' and ran out of time =
my
> git Wednesday this week.

I=E2=80=99ll try to find time to investigate and publish conflict-resol=
ution
branches.

> * jn/svn-fe (2010-08-09) 10 commits
=2E..
> There was a screw-up on my part---I should have dropped the first one=
 and
> branched this off of jn/parse-date-basic (I'll fix it up before mergi=
ng
> this to 'next').

I didn=E2=80=99t notice the existing parse-date-basic branch.  Sorry ab=
out
that.
