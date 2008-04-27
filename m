From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] cvsps/cvsimport: fix branch point calculation and broken branch imports
Date: Sun, 27 Apr 2008 13:06:53 +0800
Message-ID: <46dff0320804262206p76941ee8la6a784ed0b6f8294@mail.gmail.com>
References: <1207100091.10532.64.camel@gandalf.cobite.com>
	 <0C7AA499-56AD-4D20-AED0-9E7DDD0C77DF@zib.de>
	 <1207230582.17329.39.camel@gandalf.cobite.com>
	 <47F5FA79.8010604@alum.mit.edu>
	 <1207590845.17329.98.camel@gandalf.cobite.com>
	 <47FC2190.3070303@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "David Mansfield" <david@cobite.com>,
	"Steffen Prohaska" <prohaska@zib.de>, git@vger.kernel.org
To: "Michael Haggerty" <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Apr 27 07:08:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jpz7O-0007Wc-2T
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 07:08:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbYD0FGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 01:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbYD0FGy
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 01:06:54 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:29858 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbYD0FGy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 01:06:54 -0400
Received: by wx-out-0506.google.com with SMTP id h31so3639020wxd.4
        for <git@vger.kernel.org>; Sat, 26 Apr 2008 22:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=+1tLrWpkn45ORmmunZAKJSvlRJUl7iPI4m+26c7Hpmg=;
        b=CTqFZ4YwKtTiqzOzUBUyq9PIumKQ9wp5z+baudlNQ1ss5dCKzu8An3MgAd9tzxafEGyqNEiZxG9g0aehOMOdxbe/9zhBAvPzWj0d18GWTC9UDwg//tQn71zb8E34QA5rgONH7EjGw0LtzOu3RlP+0cs8ifY0IwzsBqETzTpSAgU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RzHC/Bwj5O/r1GlNduS0x7kMR1UqxRVFdbNGIyW3iLXQ3VGXQi6yXLt4wc2knd1AHJsyLl+oDYT7Xcygx9pweF6m/qoCTkU+KnDPVPxgnZP6vAQ9mQkBq9WBMA61HjdgObJHkFrx2Nuza15JyiK7WM4uf97bhCX04JCJH/45ei0=
Received: by 10.100.41.15 with SMTP id o15mr10077595ano.48.1209272813281;
        Sat, 26 Apr 2008 22:06:53 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Sat, 26 Apr 2008 22:06:53 -0700 (PDT)
In-Reply-To: <47FC2190.3070303@alum.mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80408>

On Wed, Apr 9, 2008 at 9:53 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>  > The place where the fixup branch logic needs to be is in git-cvsimport,
>  > not in cvsps.  Better yet, get rid of git-cvsimport and replace it with
>  > cvs2git if it works better.
>
>  cvs2git hopefully gives a more accurate conversion of a CVS repository
>  -- it handles all of the cases described above, plus many more [1] --
>  but it is much slower and can't work incrementally.  So there is
>  definitely still demand for something like git-cvsimport.
>

These days i tried to convert the cvs repository into git. I really
want the conversion to be as accurate as possible. However, the cvs
repository has been tagged in a very bad style which makes
git-cvsimport or cvsps not work well.

cvs2git sounds to be the right tool i should try. Unfortualely, i
can't touch the cvs repository directly. So is it possible to use
cvs2git in the remote host instead of the host of the cvs repository
just as git-cvsimport does? Yes, i know it can't now. I just wonder
whether it is possible to implement.

I choose to reply to this thread instead of opening a new one because
i think this reply of Michael has told much shortcommings of
git-cvsimport or cvsps but had got no replies yet.

-- 
Ping Yin
