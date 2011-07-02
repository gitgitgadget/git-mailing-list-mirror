From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] branch: honor core.abbrev
Date: Fri, 1 Jul 2011 20:32:00 -0500
Message-ID: <20110702013200.GA2374@elie>
References: <1309449762-10476-1-git-send-email-namhyung@gmail.com>
 <20110630181020.GA1128@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Namhyung Kim <namhyung@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 02 03:32:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qcp4C-0003Ci-Vt
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 03:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071Ab1GBBcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jul 2011 21:32:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51684 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661Ab1GBBcL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2011 21:32:11 -0400
Received: by iwn6 with SMTP id 6so3216040iwn.19
        for <git@vger.kernel.org>; Fri, 01 Jul 2011 18:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=oSq3V6w5v79TlKJyUMBKNd/w+2RO597wrKNGGVx3aUE=;
        b=sHSXk+YIZVJ//I+FetoRxv+iIrqJOLokdChQ8WjDTkZNGKSShHjKEPNMN+FZJgz9qm
         qqYXrkdIe0ZXaGhhKHX6k/p1OSuP3XPrNIm+fUWJmrSk5z1nLJ4zk6C6Xocsxyetxjhq
         SA8CZzMtg+zeBrjDawG0pc580R6O7YyryRkiQ=
Received: by 10.231.60.132 with SMTP id p4mr3298464ibh.121.1309570330278;
        Fri, 01 Jul 2011 18:32:10 -0700 (PDT)
Received: from elie (adsl-68-255-110-41.dsl.chcgil.sbcglobal.net [68.255.110.41])
        by mx.google.com with ESMTPS id x4sm1400405ibm.42.2011.07.01.18.32.08
        (version=SSLv3 cipher=OTHER);
        Fri, 01 Jul 2011 18:32:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110630181020.GA1128@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176542>

Jonathan Nieder wrote:

> Some squashable tests follow.  Maybe they can be useful.  Thanks for
> fixing this.  
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  t/t3203-branch-output.sh |   29 +++++++++++++++++++++++++++++
>  1 files changed, 29 insertions(+), 0 deletions(-)

Are these not wanted?  Or are there improvements needed before they
can be included?
