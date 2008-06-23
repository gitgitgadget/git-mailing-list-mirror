From: Mircea Bardac <dev@mircea.bardac.net>
Subject: Re: git svn --add-author-from implies --use-log-author
Date: Mon, 23 Jun 2008 22:22:58 +0100
Message-ID: <48601432.2090707@mircea.bardac.net>
References: <20080620113147.GC27940@frsk.net>	 <485BB134.9080203@mircea.bardac.net> <32541b130806231312l679aba31ra3daac2bb634cf1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 23 23:24:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAtW6-0001Qz-Bg
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 23:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012AbYFWVXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 17:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753283AbYFWVXF
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 17:23:05 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:24022 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754012AbYFWVXC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 17:23:02 -0400
Received: by rv-out-0506.google.com with SMTP id k40so7273392rvb.1
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 14:23:02 -0700 (PDT)
Received: by 10.140.136.6 with SMTP id j6mr13386943rvd.231.1214256182048;
        Mon, 23 Jun 2008 14:23:02 -0700 (PDT)
Received: from macmac.local ( [89.155.32.52])
        by mx.google.com with ESMTPS id b39sm11363859rvf.8.2008.06.23.14.23.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Jun 2008 14:23:01 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <32541b130806231312l679aba31ra3daac2bb634cf1b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85931>



Avery Pennarun wrote:
> You can set config options for these, however:
> 
> git config svn.addAuthorFrom true
> git config svn.useLogAuthor true
> 
> (I actually use "git config --global" to set these on my system so
> they apply to all my git-svn repositories.)

Oh great. This is what I actually wanted. Makes a lot more sense to have 
them as (global) variables.

My initial thought was that there are (somewhere) some variables being 
set for the repository by using --add-author-from and --use-log-author 
with "git svn clone ...". I find this quite intuitive (and maybe this 
should be default?). I can't see a reason for using these options once 
and not using them later, but it might just be me.


>>  P.S. I am very curious why using From and not Signed-off-by. I had the
>> feeling that Signed-off-by is being used to also mark the path of a patch.
>> Also, is there a centralized list of all the ways a patch can be "marked"
> 
> Signed-off-by is a legal declaration.  Please read the documentation
> carefully before using it.
> 
> From: is automatically added (when you enable the option and there's
> no Signed-off-by or From already) and is just informational.

I have found that Documentation/SubmittingPatches contains info on how 
to use "Signed-off-by:"/"Acked-by:"/a little bit of "From:" but, as far 
as I remember, others have been/are used. Are they all gathered 
somewhere, as recommendations?

Many thanks.

-- 
Mircea
http://mircea.bardac.net
