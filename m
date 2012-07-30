From: Bo98 <BoEllisAnderson@aol.com>
Subject: Re: PROPFIND 405 with git-http-backend and Smart HTTP
Date: Mon, 30 Jul 2012 14:39:28 -0700 (PDT)
Message-ID: <1343684368384-7564144.post@n2.nabble.com>
References: <1343587966493-7564017.post@n2.nabble.com> <CAJo=hJtB6OQ8+8Q_JgPoAntOdQ=Z0tOERYRD7wJ0LRLgacYA8A@mail.gmail.com> <1343637600904-7564056.post@n2.nabble.com> <CAJo=hJtynNo3SPmM4vmmsS3b7PTUwOcQpHPYh0_sPWFWL-4HMA@mail.gmail.com> <1343680215071-7564137.post@n2.nabble.com> <CAJo=hJsES44mXWjKmFqe7z+T_FHZ6Pi19toURyVp-wvW8AqQiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 23:39:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svxgd-0002oR-Db
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 23:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754834Ab2G3Vj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 17:39:29 -0400
Received: from sam.nabble.com ([216.139.236.26]:48603 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754698Ab2G3Vj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 17:39:28 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <BoEllisAnderson@aol.com>)
	id 1SvxgW-0005eH-Ce
	for git@vger.kernel.org; Mon, 30 Jul 2012 14:39:28 -0700
In-Reply-To: <CAJo=hJsES44mXWjKmFqe7z+T_FHZ6Pi19toURyVp-wvW8AqQiw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202618>


Shawn Pearce wrote
> 
> Maybe you forgot to enable ExecCGI?
> 

Whoops, completely forgot about that, but, assuming I did it right, it still
doesn't seem to work.

Here's what I did:

  <Directory "/usr/libexec/git-core/">
    Options +ExecCGI
    Allow From All
  </Directory>



--
View this message in context: http://git.661346.n2.nabble.com/PROPFIND-405-with-git-http-backend-and-Smart-HTTP-tp7564017p7564144.html
Sent from the git mailing list archive at Nabble.com.
