From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: rc4 - make quick-install-doc is broken
Date: Sat, 04 Aug 2007 12:27:08 -0400
Message-ID: <46B4A8DC.1000504@gmail.com>
References: <46B49617.3070402@gmail.com> <Pine.LNX.4.64.0708041637450.14781@racer.site> <46B4A2B0.9080208@gmail.com> <46B4A47E.5030901@gmail.com> <Pine.LNX.4.64.0708041715140.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 04 18:27:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHMTE-0000ZV-Ea
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 18:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763376AbXHDQ1N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 12:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760381AbXHDQ1N
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 12:27:13 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:13371 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759289AbXHDQ1M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 12:27:12 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1085105wxd
        for <git@vger.kernel.org>; Sat, 04 Aug 2007 09:27:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Pgzx14bhWI/uYgo8JncdnuITq733m7nfiM85aVqf0/wBFTYFD+s5oDKVLImzHhcHcV8+Xv2niUSVVEC5nDwiTwpCss57td5e+dc0S8NbJMZbeA1vxS6iVPgiUqjWsXmXOnxw7sNtBPgXRdCkIX3RamYf5ffIvzj02Ai23x+Rbd0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=nxtLaJOPjKld4SwwWQfkea7OcltW2BeUeUwwCWmsPWs7949nlLX+tKky1YJ5ePljH+7BA3kV+V1+ekkR1O+DVOuSctygyu28/eMHS7LxW0hdXOO44Op4A09vv5rKqdAIom8Wi4Z3H1TB0cWKviAY80ghaqV8Q5wzQcpDG7uaXx8=
Received: by 10.90.95.11 with SMTP id s11mr3870408agb.1186244831170;
        Sat, 04 Aug 2007 09:27:11 -0700 (PDT)
Received: from ?192.168.100.118? ( [72.66.124.87])
        by mx.google.com with ESMTPS id 34sm5425047agc.2007.08.04.09.27.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Aug 2007 09:27:10 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
In-Reply-To: <Pine.LNX.4.64.0708041715140.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54878>

Johannes Schindelin wrote:
> Hi,
>
> On Sat, 4 Aug 2007, Mark Levedahl wrote:
>
>   
>> git checkout-index -a -f --prefix="$mandir"/
>>     
>
> Just to hazard a guess... you see an error message there, such as "cannot 
> chdir to <blablabla>: No such file or directory"?
>
> It's kinda hard to debug this with incomplete information.
>
> Ciao,
> Dscho
>
>
>   
Nope - no error messages, nada. The trace output I sent you is 
absolutely uninformative as well. There is absolutely no visible 
difference between the version where this works (the previous commit) 
and the version where it does not, except that in the latter case the 
files are not written out (or at least not to where they should be 
written nor to any other place I can find.

If you have any suggestions on how I can help debug this, I am more than 
willing but not at all familiar with the internal workings of git.

Mark
