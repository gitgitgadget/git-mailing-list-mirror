From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Getting gitk to display all refs but stgit logs
Date: Tue, 9 Jan 2007 13:17:57 +0100
Message-ID: <e5bfff550701090417g3f8ab697n709721939ab36f5d@mail.gmail.com>
References: <20070108213259.GB17093@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "GIT list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 09 13:18:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4FvW-0001r4-9Z
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 13:18:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbXAIMR7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 07:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbXAIMR7
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 07:17:59 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:20724 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbXAIMR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 07:17:58 -0500
Received: by py-out-1112.google.com with SMTP id a29so4231328pyi
        for <git@vger.kernel.org>; Tue, 09 Jan 2007 04:17:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D/bayhQTxaeoLQqfr8iwqLWQltLpvvZAUsP0NN5GbYH796JYC1rhk4ht6CDiLTlmW6D135S2K2WiSFm0jfJZaX2oE9bRZ9rygr4YJ+t6FGKaPDIT6CCrkX/xd8XjZrnriIi5O2Os4ZHISJjFOAeLgGpZH6nKr7gRWu5W8/GUDog=
Received: by 10.35.91.10 with SMTP id t10mr13439913pyl.1168345077705;
        Tue, 09 Jan 2007 04:17:57 -0800 (PST)
Received: by 10.35.42.4 with HTTP; Tue, 9 Jan 2007 04:17:57 -0800 (PST)
To: "Yann Dirson" <ydirson@altern.org>
In-Reply-To: <20070108213259.GB17093@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36355>

On 1/8/07, Yann Dirson <ydirson@altern.org> wrote:
> Since v0.11, StGIT creates references to keep a hand on patch logs.
> This has the unfortunate side-effect that "gitk --all" suddenly shows
> all those very annoying, and soon becomes unusable on
> repositories for which was very convenient.
>

Normally you only need branch names

gitk/qgit --all  --> practically equivalent to --> gitk/qgit <list of
branch names>

This is already done internally in qgit when, as example, retrieving a
file history to annotate.
