From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 20:11:02 +0000
Message-ID: <200711262011.02689.andyparkins@gmail.com>
References: <200711252248.27904.jnareb@gmail.com> <fiet88$68n$1@ger.gmane.org> <2A34D324-48A4-49EF-9D4E-5B9469A0791D@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Mon Nov 26 21:11:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwkIj-0003H8-AM
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 21:11:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbXKZULL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 15:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752163AbXKZULJ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 15:11:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:45358 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbXKZULI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 15:11:08 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1015482ugc
        for <git@vger.kernel.org>; Mon, 26 Nov 2007 12:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=IeYx6z0IfBRJT8X09f47KbTcpkp7VNL2TwxDzSxxv/o=;
        b=wBicZoxAi7L5ggrCEpV6xtE2LQQDDfysqBC2L3HsrLCBDSu6FljImSr/2+ovTVv7Bk4czRDthvqhlhnqAKmAVkiUIptnysePk2NplorqpZ+9lLUutfqE8kUr0zIJXwnLBEALuohUNYZyUln5Os5G3PlkZ8erKRNN+FvJAt+VkCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QYH6iz4hQ8kKISOCesvahOBADgo+VcGKEmezTlCwZsVku8xvE9t4d0Fd2NjNylWnm9avtiC43vKyI2t/VvZfKaxqQWRhhUO2j1IPO4OF88NVjIFjQMwtx/3L8XeHVdV/ksxg02TqmoezVPc7hS7JtygAJVqq0td+DaBE+3zTxjU=
Received: by 10.66.249.8 with SMTP id w8mr167474ugh.1196107866869;
        Mon, 26 Nov 2007 12:11:06 -0800 (PST)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTPS id e1sm1395793ugf.2007.11.26.12.11.05
        (version=SSLv3 cipher=OTHER);
        Mon, 26 Nov 2007 12:11:06 -0800 (PST)
User-Agent: KMail/1.9.7
In-Reply-To: <2A34D324-48A4-49EF-9D4E-5B9469A0791D@lrde.epita.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66108>

On Monday 2007, November 26, Benoit Sigoure wrote:
> On Nov 26, 2007, at 5:46 PM, Andy Parkins wrote:
> >  - libgit would have come first
>
> I warmly second that.
>
> >  - "git revert" should be called "git invert"
> >  - "git revert" would (maybe) be "git reset"
>
> But here, I have to disagree.  Why would you want to call "git-
> revert" "git-reset"?

I don't; you're reading it the wrong way around.  I think current revert 
should actually be called invert.  "revert" means to move back to a 
previous point.  That is not at all what git-revert does, what it actually 
does is to apply the opposite of the given commit - i.e. an inversion.

Revert on the other hand would be the perfect name for current git-reset.

> I know it's annoying that commands with the same name do different
> things in SVN/CVS but I don't think it's a reason to necessarily

I know that very well; nor did I pick any of those suggestions based on what 
svn does.  There is no other VCS that uses "invert" as far as I know.  Nor 
does any other VCS use "revert" the way I'd like; so I'm really not sure 
where you're getting the idea that I chose those as a copy of another VCS.  
What I would like (ideally, with a time machine) is those words, which have 
a well defined meaning in English, to match more closely with their 
function in the VCS.  "revert" is definitely not right.

> adapt to them.  There are plenty of misnomers already anyway
> (checkout, commit, add).

I know; but the question was "what if we could start again".  I don't see 
too many problems with checkout and commit as it happens.  They both seem 
like adequate verbs to describe the operations they perform.  We could 
perhaps quibble about the extra functionality that they've both gained, but 
that isn't a naming fault, and the extensions are natural extensions for 
users of git.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
