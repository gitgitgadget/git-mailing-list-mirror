From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGIT 0.13 recognizes but not list packed StGIT controlled branches
Date: Mon, 19 Nov 2007 11:20:38 +0000
Message-ID: <b0943d9e0711190320r28224763t5a6c9ed7758a12b3@mail.gmail.com>
References: <200711190005.49990.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 12:21:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu4gS-0003Dc-Nn
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 12:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbXKSLUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 06:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbXKSLUk
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 06:20:40 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:60388 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbXKSLUj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 06:20:39 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1390749rvb
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 03:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4s24slQPpHgisI4htGNinIG8+3hVT7xqkImVE4IG8J0=;
        b=Jwb5Br0s2H3QErxV+HmbHAVYSst8rw9MjEXR1q0cc9fbNtz2keNX2LX2h03uKfo8mt6xv7madZVVjXFdjBOq3GedPwMoBLXzGi7DIP+sZ4/Sep6Iiix4OZcqfHPvahitZzKiGfLsn06293zY1CrHtNqZfazPL3Qzr3GJA+ofX0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RQUayD/CLlK/FJlJwH3QY8lBwQiYtlr/CLcI4YgA2wQPDwt20kJP9HYIP7I99Kq1tjFDMyRphS+zrL2iRkp5pK4QSzLkXOR5PEN8eVCzOVQH0XXSboRPBRV5cxwv8lDKnDOLDaXTpCEEIaIcpSjsllRa8dxeMnLCskEH7FgZhpE=
Received: by 10.141.197.8 with SMTP id z8mr1950947rvp.1195471238713;
        Mon, 19 Nov 2007 03:20:38 -0800 (PST)
Received: by 10.141.170.11 with HTTP; Mon, 19 Nov 2007 03:20:38 -0800 (PST)
In-Reply-To: <200711190005.49990.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65429>

On 18/11/2007, Jakub Narebski <jnareb@gmail.com> wrote:
> I use Stacked GIT 0.13 with git 1.5.3.5 (and Python 2.4.3).
> StGIT does recognize old StGIT branches (and converts them),
> but "stg branch -l" list only one branch. I guess that is
> cause by the fact that all the rest of branches are packed.

Have you tried the latest StGIT snapshot. We added support for this
and it will be available in 0.14 (to be released pretty soon).

> Another StGIT question: how to check if given branch is controlled
> by StGIT (needed for my bash prompt)?

'stg branch -l' lists the branches and marks those controlled by
StGIT. For a simple test, just use a command which would fail on
non-stgit branches (stg id base). Yet another way is to check for the
presence of '.git/patches/<branch>'.

-- 
Catalin
