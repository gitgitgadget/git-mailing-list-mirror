From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: Should 'git config' support key with dot such as 'a.b'
Date: Tue, 18 Mar 2008 08:40:46 +0800
Message-ID: <46dff0320803171740of822d02medc5911e0d056eb4@mail.gmail.com>
References: <46dff0320803140124t1469defsf7002f720cf2002e@mail.gmail.com>
	 <alpine.LSU.1.00.0803141138340.24600@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 18 01:41:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbPtS-00084Z-Aq
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 01:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365AbYCRAku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 20:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752375AbYCRAku
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 20:40:50 -0400
Received: from hs-out-0708.google.com ([64.233.178.251]:55239 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbYCRAkt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 20:40:49 -0400
Received: by hs-out-0708.google.com with SMTP id 4so4284716hsl.5
        for <git@vger.kernel.org>; Mon, 17 Mar 2008 17:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ZUVoCoaOa3nFBYP0dzvihtLjCf0Lo255hYfxzDrLt/0=;
        b=P8vlsUSXgH/gqgokHbK6q6sRIjpso64Z1wbe/vjSOmNj2iy6E+QPR0S1ugfbumyvozS4JGDYhoOfcSEuapDQumPH/ypLo50s8Y21uxcrd8GtgYWgHVK1RUX9xEX8bAYy3gj2BGJWHQ0XKqUE4ffdI7UY92l5exhQ6m8dVfEPo0w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=wLFor+MzewIPBBPoJqg//TMMjkvUiu/tyVqT9aeIgqZzxY48U/9ZxZKY2Q159Hk8fgQ1FpqjItbjUa0XzhkBt+5GAnwoNYsXlgLDgT+eOGARTI9cAhBQxYTbCsfZQFRyvhq5Z+siOkvC7a5KiHVPGl0SVPQDl6oUVljftZs7p6k=
Received: by 10.100.110.16 with SMTP id i16mr97242anc.8.1205800846411;
        Mon, 17 Mar 2008 17:40:46 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Mon, 17 Mar 2008 17:40:46 -0700 (PDT)
In-Reply-To: <alpine.LSU.1.00.0803141138340.24600@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77473>

On Fri, Mar 14, 2008 at 6:39 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>
>
>  On Fri, 14 Mar 2008, Ping Yin wrote:
>
>  > I find it is so annoying to write submodule definition as follows
>  > (yeah, only url, without path)
>  >
>  > ------------------------------
>  > [submodule 'crawler']
>  >     url = url1
>  > [submodule 'search']
>  >     url = url2
>  > ------------------------------
>  >
>  > I think the following form is more simple
>  > ---------------------------------
>  > [submodule]
>  >      crawler.url = url1
>  >      search.url = url2
>  > ---------------------------------
>  >
>  > So, could we support such simpler form?
>
>  I don't like it at all.  Historically, we had much stricter rules on the
>  variable names than the second part of the section names.
>
>  Also, your suggestion would make things even more confusing than beginners
>  already complain Git is.
>

Beginners will not edit config file directly. If they do, they can
follow the usaual syntax. So beginners don't have to know the new
syntax.

But for advanced users, the config file can be edited freely with more
free syntax. With current syntax, 'submodule'  will be repeated tons
of times when having tons of submoudles. Why not make life much easier
for advanced users in such case?



-- 
Ping Yin
