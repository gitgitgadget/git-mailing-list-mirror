From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: git add -A fails in empty repository since 1.8.5
Date: Wed, 18 Dec 2013 09:44:17 +0100
Message-ID: <CALWbr2wXxSU4qD_Gj5P7aYxB39tEVBa-TDALVepuwZLh+RNU1Q@mail.gmail.com>
References: <CAEcj5uWHpem+5os+3Mc_a42pk6f30i4UiV=LRPdXkoqiy1jQ_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 09:44:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtCju-0001rM-P6
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 09:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047Ab3LRIoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 03:44:18 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:34426 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072Ab3LRIoS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 03:44:18 -0500
Received: by mail-pb0-f42.google.com with SMTP id uo5so8160356pbc.15
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 00:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4mSMfU3dFe2s+iLGv1wb3ZN7Zt6AMrgu7m/Fg1qrJhs=;
        b=J/nJU5taKkUP53ZVt8ejcUo0myTZvFf1MMAJ6QP7cps34y5d3Yazb9vGf5SE+ZEki5
         LXyVB6R1HVIU4o7QJPJM3qi2r/P1P7O3QGRI93XS0xXeSNm+wwBzXZgnu3jCr0o4DFJD
         7vYM+3y20uBHoTohrHk0klRdbP0S4lg00WnCBZMiHyq82n5tlyCrgZyZ73VRHhMD9yr0
         R3DtK9WURA0a3QOt7uCukjZB3JMHEthOxaeyED6BT2Xa6uQhy5Kj7RvHLetQSuw0qA2e
         kjYNKSLmzxg/fLSD/Orc6HIp3RhXc9JYqPEbKR113Ymnw5n/nXSu9NvbeJGLsAZhYPmP
         6zMg==
X-Received: by 10.68.138.226 with SMTP id qt2mr5142936pbb.65.1387356257704;
 Wed, 18 Dec 2013 00:44:17 -0800 (PST)
Received: by 10.70.124.228 with HTTP; Wed, 18 Dec 2013 00:44:17 -0800 (PST)
In-Reply-To: <CAEcj5uWHpem+5os+3Mc_a42pk6f30i4UiV=LRPdXkoqiy1jQ_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239427>

FWIW, git-bisect points to 84b8b5d (that is $gmane/230349).

On Wed, Dec 18, 2013 at 9:06 AM, Thomas Ferris Nicolaisen
<tfnico@gmail.com> wrote:
> This was discussed on the Git user list recently [1].
>
> #in a repo with no files
>> git add -A
> fatal: pathspec '.' did not match any files
>
> The same goes for git add . (and -u).
>
> Whereas I think some warning feedback is useful, we are curious
> whether this is an intentional change or not.
>
> [1] https://groups.google.com/d/topic/git-users/Qs4YSPhTsqE/discussion
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
