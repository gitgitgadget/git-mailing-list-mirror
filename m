From: Gerhard Schrenk <gps@mittelerde.physik.uni-konstanz.de>
Subject: Re: A shortcoming of the git repo format
Date: Wed, 27 Apr 2005 22:58:12 +0200
Message-ID: <20050427205812.GA4412@frodo>
References: <426F2671.1080105@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Apr 27 22:55:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQtYJ-0000vg-AE
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 22:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbVD0U6x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 16:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbVD0U6x
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 16:58:53 -0400
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:47053 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S262012AbVD0U61 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 16:58:27 -0400
Received: from localhost (localhost.localnet [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 96B4A2BC45
	for <git@vger.kernel.org>; Wed, 27 Apr 2005 22:58:17 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
	by localhost (honk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 07532-43 for <git@vger.kernel.org>;
	Wed, 27 Apr 2005 22:58:13 +0200 (CEST)
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.140.5])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 5E0652BC44
	for <git@vger.kernel.org>; Wed, 27 Apr 2005 22:58:13 +0200 (CEST)
Received: from frodo.physik.uni-konstanz.de (frodo.physik.uni-konstanz.de [134.34.140.36])
	by gandalf.physik.uni-konstanz.de (Postfix) with ESMTP id E38C3C
	for <git@vger.kernel.org>; Wed, 27 Apr 2005 22:58:12 +0200 (CEST)
Received: from gps by frodo.physik.uni-konstanz.de with local (Exim 3.35 #1 (Debian))
	id 1DQtbo-00019U-00; Wed, 27 Apr 2005 22:58:12 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <426F2671.1080105@zytor.com>
User-Agent: Mutt/1.5.6+20040907i
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at honk.physik.uni-konstanz.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* H. Peter Anvin <hpa@zytor.com> [2005-04-27 07:43]:
> Most of git's files are starting to converge toward an RFC822-like 
> header with (tag, data) and a free-form section.  This is a good
> thing.

I really hate RFC822-like data structures. Why? Lazy straightforward
people (who have written to much mails) tend to break the relational
data
modell and don't realize what they loose. Usually they introduce
non-atomar tags like

Tag: value1, value2

and game over. You have just broken the first normal form (1NF). In the 
end the relational normalization process is just not to break the
functional dependencies of your data. It's worth it.

I'm reacting like pawlov's dog and really don't know what I'm talking
about (namely git). But please don't do the same error and just
associate
relational = sql = crap. The shell's operator stream paradigma fits very
good to the relational modell. It's certainly closer to the relational
algebra than sql...

Take care
Gerhard

