From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Problem using GIT CVS-server
Date: Wed, 3 May 2006 23:11:17 +1200
Message-ID: <46a038f90605030411o29af1d1bra3276353347516f6@mail.gmail.com>
References: <445865A5.5030700@lumumba.uhasselt.be>
	 <46a038f90605030311s4e05de2dr90277f97a3a5c223@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 13:11:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbFGN-0004Iw-67
	for gcvg-git@gmane.org; Wed, 03 May 2006 13:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbWECLLS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 07:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965150AbWECLLS
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 07:11:18 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:34911 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965149AbWECLLS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 07:11:18 -0400
Received: by wr-out-0506.google.com with SMTP id 36so106989wra
        for <git@vger.kernel.org>; Wed, 03 May 2006 04:11:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G715IvJq88etvzpB6x7a8XHUclKw5iyaRpH2bbuL4nEEBhhXTsDx9iMgBYI80OoQcefmrP58FNioSbwcVggcxPnlxJKbDYPbf/ykIU4XIwN5xJlSr3KAzGrsuyCuUUVqPTpm7DGC2VxUBFLE76AviOHMl13iMTn1X86W8RY7WNs=
Received: by 10.54.66.17 with SMTP id o17mr1781618wra;
        Wed, 03 May 2006 04:11:17 -0700 (PDT)
Received: by 10.54.127.4 with HTTP; Wed, 3 May 2006 04:11:17 -0700 (PDT)
To: "Panagiotis Issaris" <takis@lumumba.uhasselt.be>
In-Reply-To: <46a038f90605030311s4e05de2dr90277f97a3a5c223@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19470>

On 5/3/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> Hmmm. 100% reproduceable -- looking at it now.

Grumble. Some recent change has broken cvsserver -- if I rewind to the
commit I made of cvsserver, the checkout works correctly. I suspect
changes to git-diff-tree. However, I'll play dumb and try bisect to
see where it leads...

(Nice thing about bisecting with C code is that as you get closer the
delta is smaller, and the recompile is smaller too ;-)

Ok -- an hour's gone by and I'm still fidgeting with bisect. It seems
to have been broken soon after v1.3.0 but I'm having trouble nailing
the commit, and understanding WRF has changed.

Can you test with git v1.3.0?


martin
