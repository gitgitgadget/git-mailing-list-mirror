From: =?iso-8859-1?Q?Sidney_San_Mart=EDn?= <s@sidneysm.com>
Subject: Re: Question about commit message wrapping
Date: Wed, 14 Dec 2011 16:04:50 -0500
Message-ID: <3BFBBBF6-878E-4B98-A1BB-16F841B6773D@sidneysm.com>
References: <35A5A513-91FD-4EF9-B890-AB3D1550D63F@sidneysm.com> <m3zkf1hnh9.fsf@localhost.localdomain> <E085218D-9287-4F82-B34C-8379742F818A@sidneysm.com> <201112102030.15504.jnareb@gmail.com> <CAH5451kGn72tLAwdvQFBjSyHSL0rUmaPZrbL7Z-KfHWN-HAuCQ@mail.gmail.com> <CAH6sp9NwyxZi6KR4U96=sWdiqCseyTLEDoHdw=y9hUx2kHwOpg@mail.gmail.com> <4EE62DB9.8030406@ira.uka.de> <op.v6edibfz0aolir@keputer> <4EE6C31C.60909@alum.mit.edu>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Frans Klaver <fransklaver@gmail.com>,
	Holger Hellmuth <hellmuth@ira.uka.de>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	JakubNarebski <jnareb@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Dec 14 22:04:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Raw0X-0002IS-Im
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 22:04:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758110Ab1LNVEx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Dec 2011 16:04:53 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:44427 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756603Ab1LNVEw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2011 16:04:52 -0500
Received: by qcqz2 with SMTP id z2so790042qcq.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 13:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sidneysm.com; s=google;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=L6OaumwXfKhEA3c358Q8GVPLFa3bOGSLgHRuDXDD9/U=;
        b=P6QO2tWBRU2pyg1m+W8U3eCNpCdvSp7qo7HTMNirPGbxS4rWbxQvHklEDeHxIs8v37
         w30JRVBTVO0HaBu4xhKS3Rb0B5g3Crjwjk6fImDeImNmc6fwaR5d6/TiTyDDy47jpBM5
         Oh3AgUqh6p2DwtprLniaYCTfaGJidXxqOc6r8=
Received: by 10.224.200.70 with SMTP id ev6mr699424qab.28.1323896691545;
        Wed, 14 Dec 2011 13:04:51 -0800 (PST)
Received: from [172.20.1.57] (rrcs-184-75-21-194.nyc.biz.rr.com. [184.75.21.194])
        by mx.google.com with ESMTPS id dm3sm8037128qab.12.2011.12.14.13.04.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 13:04:50 -0800 (PST)
In-Reply-To: <4EE6C31C.60909@alum.mit.edu>
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187166>

On Dec 12, 2011, at 10:14 PM, Michael Haggerty wrote:

> FWIW I think automatic wrapping of commit messages is a bad idea.  I
> wrap my commit messages deliberately to make them look the way I want
> them to look.  The assumption of an 80-character display has historic=
al
> reasons, but it is also a relatively comfortable line-width to read
> (even on wider displays).

A lot of Git repos live in heterogeneous environments. I played a littl=
e with some of the popular Git interfaces I can use on my computer. The=
 majority of them=85

- compose and show commit messages in a proportional font (where the wi=
dth of and formatting in "80 characters" means nothing),
- don=92t insert line breaks when you write a commit message (and don't=
 provide a way to do so automatically),
- do wrap commit messages when showing them.

Jakub, you said that education was the answer to getting some consisten=
cy in line wrapping, but I have trouble imagining the makers of new too=
ls using fixed-width text for anything other than code.

> And given that commit messages sometimes
> contain "flowable" paragraph text, sometimes code snippets, sometimes
> ASCII art, etc, no automatic wrapping will work correctly unless
> everybody agrees that commit messages must be written in some specifi=
c
> form of markup (or lightweight markup).  And I can't imagine such a
> thing ever happening.

The two biggest websites I know of for talking about code, GitHub and S=
tack Overflow, both adopted flavors of Markdown. It is basically the fo=
rmatting syntax already used for commit messages in the Git project its=
elf (this email too), so can be formatted to look good in a specific en=
vironment (i.e. proportional fonts) and looks good by itself.

(Actually, as far as I can tell commit messages are the only place GitH=
ub doesn=92t currently render user-entered text as Markdown.)

I think, now and in the future, consistency will be found most easily i=
n in Markdown-like formatting and least in 80 columns of fixed-width te=
xt.

- - -

## Gitbox 1.5.1
- Commit messages written and displayed in a proportional font
- Does not insert line breaks when you commit
- When displaying a commit message, turns single line breaks into space=
s and keeps double line breaks, wraps as needed based on the size of th=
e viewing area (it's somewhat intelligent about this, it does preserve =
some line breaks; it doesn't preserve spaces used for formatting)

## Tower 1.0.3
- Commit messages written and displayed in a proportional font
- Does not insert line breaks when you commit. Collapses multiple newli=
nes into a single newline
- When displaying a commit message, wraps at 100 characters and collaps=
es multiple newlines into a single one

## GitHub (Mac app) 1.1.1
- Commit messages written and displayed in a proportional font
- Inserts line breaks after 73 characters when you commit (incl. in the=
 middle of a long identifier)
- Does not wrap lines when displaying commit messages, and doesn=92t pr=
ovide a way to scroll to read them

## GitHub (website)
- Commit messages written and displayed in a fixed-width font
- Does not insert line breaks when you commit, input wraps, visually, a=
t 113 characters
- When displaying a commit message, uses CSS to wrap the commit message=
 to 700 pixels, 100 characters

## git (default configuration in a fresh Linux Mint live cd)
- Does not insert line breaks when you commit (using the default editor=
 (nano) and pager (less, IIRC)
- Does not wrap lines when displaying commit messages.
