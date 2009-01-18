From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH v4 0/7] customizable --color-words
Date: Sun, 18 Jan 2009 16:05:49 +0100
Message-ID: <adf1fd3d0901180705s260f0051wb4e3a978601618ec@mail.gmail.com>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de>
	 <1232209788-10408-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Teemu Likonen <tlikonen@iki.fi>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jan 18 16:07:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOZF6-0000k6-Lb
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 16:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762441AbZARPFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 10:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762417AbZARPFw
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 10:05:52 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:61729 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762093AbZARPFw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 10:05:52 -0500
Received: by bwz14 with SMTP id 14so7046918bwz.13
        for <git@vger.kernel.org>; Sun, 18 Jan 2009 07:05:50 -0800 (PST)
Received: by 10.103.92.10 with SMTP id u10mr332508mul.22.1232291149126; Sun, 
	18 Jan 2009 07:05:49 -0800 (PST)
In-Reply-To: <1232209788-10408-1-git-send-email-trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106210>

2009/1/17 Thomas Rast <trast@student.ethz.ch>:
> Johannes Schindelin wrote:
>> Thomas, could you pick up the patches from my 'my-next' branch and
>> maintain an "official" topic branch?
>
> I cherry-picked the three commits you had there, and rebuilt on top.
> I pushed them to
>
>  git://repo.or.cz/git/trast.git tr/word-diff-p2
>
> again (js/word-diff-p1 again points directly at your half).

I've tested tr/word-diff-p2 and I have not found any issues. I've even
tested that nothing changed from the tradicional word diff to:

git log -p --color-words="[^[:space:]]+"

for the whole git history.

At the end I've found that a general regex that works best for me is:

"[[:alpha:]]+|[[:digit:]]+|[^[:alnum:][:space:]]"

and that is what I tested.

Santi
