From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: Gitweb indentation wrong in Internet Explorer
Date: Wed, 11 Oct 2006 11:13:48 -0700 (PDT)
Message-ID: <20061011181348.85585.qmail@web31801.mail.mud.yahoo.com>
References: <20061011172553.GA1147@linux-mips.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Oct 11 20:14:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXiaY-0006m7-52
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 20:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161083AbWJKSNu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 14:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161084AbWJKSNu
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 14:13:50 -0400
Received: from web31801.mail.mud.yahoo.com ([68.142.207.64]:438 "HELO
	web31801.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161083AbWJKSNt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 14:13:49 -0400
Received: (qmail 85587 invoked by uid 60001); 11 Oct 2006 18:13:48 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=KcHgRnUy4BbfVLsmo1oBHEWhQFe1oQE7SEtJYWxup+3dOI/vDH0EspDQqqbernZYtapvAi9R85Ll/ZL9Lzf8G4TKr44q5FMwri471QwDWT4tJe/j9W8VjXQmyY4eBaydbQSHe5LE2Utw42FaeKqgfVzPT8mQgWxHAa1tBAoz4tA=  ;
Received: from [64.215.88.90] by web31801.mail.mud.yahoo.com via HTTP; Wed, 11 Oct 2006 11:13:48 PDT
To: Ralf Baechle <ralf@linux-mips.org>, git@vger.kernel.org
In-Reply-To: <20061011172553.GA1147@linux-mips.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28733>

--- Ralf Baechle <ralf@linux-mips.org> wrote:
> I have a report from an MSIE suffering user:
> 
> > When I use it (and I believe I've seen this on my laptop as well as my
> > workstation) all left-hand margin whitespace is collapsed to nothingness.
> > Once can still parse the code, but it's harder with no indentations.
> 
> A screenshot from a Windows laptop to illustrate the problem is at
> http://www.linux-mips.org/~ralf/gitweb.png.  It shows the code was
> preformatted correctly which seems to be an IE bug but the following patch
> seems to work around it.

Thank you.

Has anyone let MSIE people know about this bug?  Or tried latest MSIE?

   Luben

> 
> *** gitweb.cgi.dist	2006-10-09 19:02:19.561726255 +0100
> --- gitweb.cgi	2006-10-09 19:03:31.744837495 +0100
> ***************
> *** 234,239 ****
> --- 234,240 ----
>   	my $str = shift;
>   	$str = decode("utf8", $str, Encode::FB_DEFAULT);
>   	$str = escapeHTML($str);
> + 	$str =~ s/ /&nbsp;/g;
>   	return $str;
>   }
> 
> Thanks,
> 
>   Ralf  
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
