From: "David Aguilar" <davvid@gmail.com>
Subject: Re: Using git from Python
Date: Wed, 7 May 2008 21:23:49 -0700
Message-ID: <402731c90805072123g764a3d56ia30035381c0950dd@mail.gmail.com>
References: <alpine.DEB.1.10.0805071612510.26718@sf.creativecommons.org>
	 <87lk2l4fj5.fsf@offby1.atm01.sea.blarg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Eric Hanchrow" <offby1@blarg.net>
X-From: git-owner@vger.kernel.org Thu May 08 06:24:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtxgQ-0005nD-2T
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 06:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354AbYEHEXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 00:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752105AbYEHEXx
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 00:23:53 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:38086 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbYEHEXv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 00:23:51 -0400
Received: by ug-out-1314.google.com with SMTP id h2so335091ugf.16
        for <git@vger.kernel.org>; Wed, 07 May 2008 21:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=XxOtRT5yxIEE74EnLHpmI/gAmeAxgGf7F+VgQ1DtHnk=;
        b=iTl6LefyylTVS23DzTvZdCGBnGv8/vO7ly+ivD4hiCJNSIDcBWC2rT71ipAoon08pchmTkGRkdmFNbCkc+gC7N4LtQ8sBECtp6N3JtClisomFl61F4eOiAAL5mDCutTJzvDfGDk642DcHaqEYbLFynyOraT5yYwVAaNx+4Y3b20=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=itR+GWH99HfSjaL4s0w+FkQMPf0eKBSbtJpeu/+VavWjPlpmMD2pddlnVLLzlCazfjwKp6oQwMhPfj2qbimNbl268cNwDy/xBgs56+ccSOvDI7t4XfVaa3YXf30NQLCK/ggE+ITNbZCUcvqrYTr7jE3Lt46Ha7hGgZIZEVrHyHQ=
Received: by 10.66.219.11 with SMTP id r11mr7366ugg.31.1210220629766;
        Wed, 07 May 2008 21:23:49 -0700 (PDT)
Received: by 10.66.236.11 with HTTP; Wed, 7 May 2008 21:23:49 -0700 (PDT)
In-Reply-To: <87lk2l4fj5.fsf@offby1.atm01.sea.blarg.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81507>

On Wed, May 7, 2008 at 8:54 PM, Eric Hanchrow <offby1@blarg.net> wrote:
>     Asheesh> That's fine ... but since I figured others may have done
>     Asheesh> this also
>
>  As far as I can tell, there is exactly no downside to simply forking a
>  subprocess.  Why are you trying to avoid that?
>
>     Asheesh> raises Exceptions when the git commands fail for some
>     Asheesh> reason.
>
>  If Popen doesn't already raise an exception when the child process
>  fails, then it's surely a simple matter to check the exit code, and
>  raise the exception yourself.
>

There have been many questions about this lately.
For the impatient, grab git.py from the python-git directory of the
ugit project:

http://repo.or.cz/w/ugit.git?a=tree;f=python-git;h=1ef75cef116ce750b5bdf5dd38a4cf1ab2c1ce79;hb=b393c428cf156a7c5c75b18379676dbb534a76d8

http://repo.or.cz/w/ugit.git

I will work on making git.py a separate python-git project, upload it
to pypi, and create a separate repo for it very soon.

The interface is blazingly simple.  It is a 1:1 correspondance to the
git command line interface.  e.g. git.commit(F='/some/path.txt',
s=True)

There are many examples in the t/ directory and within the ugit
project itself.  Let me know offline if you have any questions.  The
documentation could probably use some work.

-- 
 David
