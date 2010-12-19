From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: subdirectory-filter does not delete files before the directory came into existence?
Date: Sun, 19 Dec 2010 03:23:59 +0100
Message-ID: <201012190323.59829.trast@student.ethz.ch>
References: <1292365295.6666.22.camel@ct> <201012150003.30127.trast@student.ethz.ch> <1292415733.11607.51.camel@hppc323.few.vu.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Jan Wielemaker <J.Wielemaker@cs.vu.nl>
X-From: git-owner@vger.kernel.org Sun Dec 19 03:24:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PU8wT-0005sy-8T
	for gcvg-git-2@lo.gmane.org; Sun, 19 Dec 2010 03:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264Ab0LSCYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 21:24:03 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:16058 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932247Ab0LSCYC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 21:24:02 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sun, 19 Dec
 2010 03:24:00 +0100
Received: from pctrast.inf.ethz.ch (217.162.250.31) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sun, 19 Dec
 2010 03:24:00 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc5-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <1292415733.11607.51.camel@hppc323.few.vu.nl>
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163948>

Jan Wielemaker wrote:
> The reported problems also apply to the next module.  What appears to
> work is this:
> 
>   * Walk through the history, finding the commit where the directory
>   is created.
>   * use git tag -l --contains <commit that created dir> to get the 
>   tags we want to keep.
>   * get all tags, use comm and delete the tags not in the `contained'
>   set above.
> 
> Not very friendly and I'm (with Thomas) about the status of these
> findings.  I like to thank Thomas for giving me the right clue.

Now I finally remember where I knew this problem from:

  http://article.gmane.org/gmane.comp.version-control.git/91708

(My memory really sucks.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
