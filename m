From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use diff3 instead of merge in merge-recursive.
Date: Wed, 18 Oct 2006 11:38:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610181135120.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061018085949.GA26501@cepheus.pub>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 11:38:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga7sX-0002Z3-82
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 11:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWJRJiT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 05:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWJRJiT
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 05:38:19 -0400
Received: from mail.gmx.de ([213.165.64.20]:56250 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932148AbWJRJiS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 05:38:18 -0400
Received: (qmail invoked by alias); 18 Oct 2006 09:38:16 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 18 Oct 2006 11:38:16 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
In-Reply-To: <20061018085949.GA26501@cepheus.pub>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29214>

Hi Uwe,

On Wed, 18 Oct 2006, Uwe Zeisberger wrote:

> If no error occurs, merge (from rcs 5.7) is nothing but:
> 
> 	diff3 -E -am -L label1 -L label2 -L label3 file1 file2 file3 > tmpfile
> 	cat tmpfile > file1

Interesting. I wonder if we could streamline the code such that index_fd 
is called directly on the output of diff3? Of course, the result has to be 
removed when the call to diff3 fails.

> I didn't made any timing tests or further tests for correctness, but I
> hope Johannes still has the framework from the time when he converted
> the Python script to C?  
> 
> @Johannes: If so, could you test this patch?

I have to dig a little where I have it, but I think I can give it a try in 
a few hours (imagine this lyrics to the melody of the day job blues).

Ciao,
Dscho
