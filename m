From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Partial tree export and merging
Date: Thu, 25 Sep 2008 21:51:10 +0700
Message-ID: <fcaeb9bf0809250751x403a4b31vf05cdaba04563bbc@mail.gmail.com>
References: <ACF330629DFB034AB290061C320F43460836E082@GOEMAILBE02.europe.mahr.lan>
	 <48D9FACB.20901@mahr.de> <48DA476F.1070700@mahr.de>
	 <fcaeb9bf0809241051se24bcf7tb836d1b820e288d6@mail.gmail.com>
	 <48DBA1DF.3050502@mahr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jens Lehmann" <Jens.Lehmann@mahr.de>
To: "Heiko Voigt" <heiko.voigt@mahr.de>
X-From: git-owner@vger.kernel.org Thu Sep 25 16:52:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KisCe-0005nc-AI
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 16:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbYIYOvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 10:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752511AbYIYOvO
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 10:51:14 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:43008 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbYIYOvN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 10:51:13 -0400
Received: by fg-out-1718.google.com with SMTP id 19so324344fgg.17
        for <git@vger.kernel.org>; Thu, 25 Sep 2008 07:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=P9jm2akQtX/r4rQVqsG6YIvTHoeKJdlVfOUQU9lAL6A=;
        b=piRWWJCiQJ4O/hx9zRPmhzoAIjnMg/3S0b0GcQI/O5md4F7eLsIRAkmGS7OkY8aXVG
         sTegTItDtMR3Xy5gCEBpO6sI2AaHym/Oqg8y5mBL4TcoOpLjf/1wIvA8qcHih9gCFbnj
         XEGQP/1KwQVhJshRwwP5VTzMxNhZKr87G83y0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=upQExD+eplTV10e+4zAyUUGpQIE6l+W1QrJ1mGg7EKrGS/Ak9JOUqXCbkRH1llzFE2
         qqm8SoRu99K49VOuJK5t8y5+WEC2PFGzwvEPmDvllHfp0lXwnJjxiqEJiuBkoxO55Tk/
         g6+kiCrOYukjVAZWANJUuFyJpEmPFoNhvIzwQ=
Received: by 10.86.94.11 with SMTP id r11mr80332fgb.0.1222354271009;
        Thu, 25 Sep 2008 07:51:11 -0700 (PDT)
Received: by 10.86.95.9 with HTTP; Thu, 25 Sep 2008 07:51:10 -0700 (PDT)
In-Reply-To: <48DBA1DF.3050502@mahr.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96772>

On 9/25/08, Heiko Voigt <heiko.voigt@mahr.de> wrote:
> Nguyen Thai Ngoc Duy schrieb:
>
> > That could be done with (under-developing) sparse checkout. Basically
> > language team's people do "git clone
> --sparse-checkout='*.loc:*.html'
> > your-repo.git". Then they only have *.loc and *.html files in working
> > directory. When they commit, all other files are unchanged. Developers
> > merge to have updated *.log/html as usual.
> >
>
>  Where is that option ? Or are you suggesting me to implement it ?

As I said, it is being developed. It should not be used in production
environment yet but if you want to try, you can get it from here

http://repo.or.cz/w/git/pclouds.git in branch sparse-checkout

> > I have a question though: is language team allowed to checkout/modify
> > files other than *.loc and *.html?
> >
>
>  Well in an ideal world they should only have access to the "language"
> files. But it is not crucial for us if they get access to the source. Its
> more an issue of user friendlyness. The revision control which is in place
> at the moment does allow them to selectively check out those files.

Thanks. Just wanted to know the scenario that sparse checkout could be used.
-- 
Duy
