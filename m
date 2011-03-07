From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 00/12] vcs-svn: incremental import
Date: Mon, 7 Mar 2011 13:24:16 +0100
Message-ID: <AANLkTi=+ujWER5aeYzYW1pN-LOdM3Xa2J2bZhjkoeWvB@mail.gmail.com>
References: <20101210102007.GA26298@burratino> <20110306225419.GA24327@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 13:25:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwZUk-0007Kh-Ps
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 13:25:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342Ab1CGMY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 07:24:57 -0500
Received: from mail-gw0-f51.google.com ([74.125.83.51]:57429 "EHLO
	mail-gw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab1CGMY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 07:24:56 -0500
Received: by gwb15 with SMTP id 15so2504942gwb.10
        for <git@vger.kernel.org>; Mon, 07 Mar 2011 04:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=6s6c1GeJJzeXkPIyKdCYJf1viY/cme2gTnQTpd0CZgE=;
        b=x9Sqp8aGxxb/PXkCvQzdX7rWTrY+94XjvyYScTvVLw48Eemk5JhTrCTEV+W0xiqWfT
         CN84yMvVz5xpmHP2cFWIXS9jR0QcUoW5aO0+/vnWr+4s9eV0aIVDbLhE1LrVH/QSpOic
         slFfaKf4vQs9KS7HHFLuX2rnGoTv9VoeD9uSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=iguKKwqvNJ+hrZW8noyZBFsAmnPoGIwcLp9zse4jRNuTAGjrYxwEgwKU5zC77kXVjj
         AcLSYr1E8FZGm3JzEryCJKnDbkG17lXNcltseTceJN8sB7foII88Yuhkh1HPQanSU5hf
         b70cpwTR/UT6U5Y1H9hvLaNAwk6XKKbo4SneY=
Received: by 10.150.148.7 with SMTP id v7mr4461582ybd.49.1299500696116; Mon,
 07 Mar 2011 04:24:56 -0800 (PST)
Received: by 10.151.11.12 with HTTP; Mon, 7 Mar 2011 04:24:16 -0800 (PST)
In-Reply-To: <20110306225419.GA24327@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168579>

Heya,

On Sun, Mar 6, 2011 at 23:54, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Patch 1 changes the mark numbers for blobs to be ridiculously high,
> to make room for memorable commit marks (:1 for r1, :2 for r2, etc).

How high is rediculously high? There are repositories with a lot of
commits, will they have enough room? Ditto for repositories with a lot
of blobs, will _those_ have enough room? What about the git
fast-import side, what about this statement:

"Marks are stored in a sparse array, using 1 pointer (4 bytes or 8
bytes, depending on pointer size) per mark. Although the array is
sparse, frontends are still strongly encouraged to use marks between 1
and n, where n is the total number of marks required for this import."

-- 
Cheers,

Sverre Rabbelier
