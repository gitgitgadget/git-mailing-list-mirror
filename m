From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH] gitweb: Adding a `blame' interface.
Date: Mon, 12 Jun 2006 23:38:26 +0200
Message-ID: <20060612213826.GC4705@c165.ib.student.liu.se>
References: <11500407193506-git-send-email-octo@verplant.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 23:38:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fpu7D-0003dI-PL
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 23:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWFLVi2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 17:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWFLVi2
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 17:38:28 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:60116 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S932382AbWFLVi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 17:38:27 -0400
Received: from c165 ([213.114.27.46] [213.114.27.46])
          by mxfep01.bredband.com with ESMTP
          id <20060612213826.DJXB9567.mxfep01.bredband.com@c165>;
          Mon, 12 Jun 2006 23:38:26 +0200
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1Fpu78-0005aK-00; Mon, 12 Jun 2006 23:38:26 +0200
To: Florian Forster <octo@verplant.org>
Content-Disposition: inline
In-Reply-To: <11500407193506-git-send-email-octo@verplant.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21743>

On Sun, Jun 11, 2006 at 05:45:19PM +0200, Florian Forster wrote:
> This patch adds an interface for `git-blame' to `gitweb.cgi'. Links to it are
> place in `git_blob'.
> Internally the code uses `git-annotate' because `git-blame's output differs for
> files that have been renamed in the past. However, I like the term `blame'
> better.
> 

You can pass "--compatibility" to git-blame to get output which is
identical to git-annotates output. However, "--time" is not
implemented in git-blame yet. I will send a patch in a separate mail.

git-blame is a bit faster than git-annotate and, as far as I know, it
produces output which is correct.

- Fredrik
