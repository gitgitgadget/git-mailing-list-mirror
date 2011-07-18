From: Christof =?ISO-8859-1?Q?Kr=FCger?= <git@christof-krueger.de>
Subject: Re: What changed in merge commit?
Date: Mon, 18 Jul 2011 19:10:24 +0200
Message-ID: <1311009024.18226.121.camel@oxylap>
References: <CAF_dkJC-ee2Bqyi2_Fx_j8mu3tCFsV8o=xMRLjx+s2di4=HfkQ@mail.gmail.com>
	 <CABPQNSaOQxBqf34_799zc46EnHsc7L3BiSATyYq+Q6oGs0H6sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Patrick Doyle <wpdster@gmail.com>, git <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Jul 18 19:10:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QirL3-000766-S7
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 19:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754081Ab1GRRKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 13:10:32 -0400
Received: from vserver.localhost.li ([85.214.46.152]:35782 "EHLO
	mail.localhost.li" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754056Ab1GRRKb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 13:10:31 -0400
Received: from p5794df2c.dip.t-dialin.net ([87.148.223.44]:51685 helo=[192.168.0.126])
	by mail.localhost.li with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <git@christof-krueger.de>)
	id 1QirKt-0002dQ-3n; Mon, 18 Jul 2011 19:10:28 +0200
In-Reply-To: <CABPQNSaOQxBqf34_799zc46EnHsc7L3BiSATyYq+Q6oGs0H6sw@mail.gmail.com>
X-Mailer: Evolution 2.30.3 
X-Spam-Score: 0.0 (/)
X-Spam-Report: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177387>

On Mo, 2011-07-18 at 18:52 +0200, Erik Faye-Lund wrote:
> You probably want to do something like "git diff SHA1-OF-MERGE^
> SHA1-OF-MERGE" to see what the merge changed compared to it's previous
> commit.
You could also use "git log --name-status -m" which will show multiple
entries for each parent of the merge commit.
See "man git-diff-tree" and look for the description of the options -m,
-c and --cc

Bye,
  Chris
