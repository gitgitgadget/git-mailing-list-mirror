From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Fix expected values of setup tests on Windows
Date: Fri, 31 Dec 2010 23:21:31 +0100
Message-ID: <201012312321.31294.j6t@kdbg.org>
References: <201012302205.13728.j6t@kdbg.org> <201012311711.06989.j6t@kdbg.org> <20101231203019.GC5898@burratino>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 31 23:21:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYnLv-0006Cv-T5
	for gcvg-git-2@lo.gmane.org; Fri, 31 Dec 2010 23:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754293Ab0LaWVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Dec 2010 17:21:34 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:62859 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754186Ab0LaWVe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Dec 2010 17:21:34 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2C9BBA7EB5;
	Fri, 31 Dec 2010 23:20:25 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 6590819F69E;
	Fri, 31 Dec 2010 23:21:31 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <20101231203019.GC5898@burratino>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164397>

On Freitag, 31. Dezember 2010, Jonathan Nieder wrote:
> Johannes Sixt wrote:
> > On Freitag, 31. Dezember 2010, Nguyen Thai Ngoc Duy wrote:
> >> in your patch does not. Does bash auto convert value in
> >> TRASH_DIRECTORY="$TE..." line?
> >
> > No. When this line is executed:
> >
> > TEST_DIRECTORY=$(pwd)
> >
> > $(pwd) still has its default behavior to return the POSIX style path. pwd
> > is redefined to pwd -W only later.
>
> Would it make sense to change it to
>
>  TEST_DIRECTORY=$PWD
>
> for clarity and robustness against code movement, then?

Yes, that would make sense.

-- Hannes
