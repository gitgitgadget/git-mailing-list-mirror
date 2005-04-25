From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: mod-times (was: keyword expansion)
Date: Mon, 25 Apr 2005 20:10:11 +0200
Message-ID: <20050425181011.GA14076@cip.informatik.uni-erlangen.de>
References: <20050425002343.GF10806@cip.informatik.uni-erlangen.de> <200504251756.j3PHuSh01362@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Apr 25 20:06:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ7y2-00052W-78
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 20:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbVDYSKf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 14:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262698AbVDYSKe
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 14:10:34 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:38861 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262675AbVDYSKP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 14:10:15 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j3PIABS8016893
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 25 Apr 2005 18:10:11 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j3PIAB2M016890
	for git@vger.kernel.org; Mon, 25 Apr 2005 20:10:11 +0200 (CEST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200504251756.j3PHuSh01362@unix-os.sc.intel.com>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,


> > 	- Time stamp of the last modification of a file

> One way to do this would be to rip on some of the core fundamentals of GIT
> and store the time that an object was created inside the object. E.g.

I think I have nearly something finished. Using rev-tree, cat-file and
ls-tree -r written in perl.

>    blob size secs-since-1970 ...

I dislike the idea because of reasons Torvalds has already mentioned
when talking about file renames and cvs annotate. And it also would fit
only this special case.

Having a 'git export' with real timestamps would be fun, but when I
think it over I don't really need it. And if I need it it would be a
matter of 20 minutes. :-)

	Thomas
