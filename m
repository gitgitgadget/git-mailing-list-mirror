From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: autocrlf
Date: Fri, 18 May 2007 13:01:18 +0100
Message-ID: <200705181301.25749.andyparkins@gmail.com>
References: <200705181111.53823.andyparkins@gmail.com> <1179484482.6453.19.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Raimund Bauer <ray007@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 18 14:01:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp19Y-0001Gl-Ie
	for gcvg-git@gmane.org; Fri, 18 May 2007 14:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170AbXERMBn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 08:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754052AbXERMBn
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 08:01:43 -0400
Received: from ik-out-1112.google.com ([66.249.90.178]:13643 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753170AbXERMBm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 08:01:42 -0400
Received: by ik-out-1112.google.com with SMTP id b35so585932ika
        for <git@vger.kernel.org>; Fri, 18 May 2007 05:01:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UGvsPNkDTvIb3mP61VKOr8kQW9P0HSSxfLA0FqL2LYD+h16JyTgpJZT8np0Q3JbyxCmD5gZC03gbpXrnhBtNX3jTweIVkzEZ/C5HO0blJvD/dr5a18OTCLwRQeVFAsmY74nvbbhrwGgoBbYJbcmJpUtuVXaReuZxasKxV5y0tAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Xu+ommVzwboZfCmrJeJsvMUYHzKZrI0ZFBcISDOQy4F/QKyv1AH3krkEQndovi+F10ErLfnKZuz8CgAKJ65b52KX4ovvRYY/wT0+8kLWd1WqrsxMojjoQtLSJ7eAb5koeoxhNiZPO7s1rGb+lp5Jl4Lo0cKvuOc90YiBtLQuY1o=
Received: by 10.82.138.6 with SMTP id l6mr2691689bud.1179489700872;
        Fri, 18 May 2007 05:01:40 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b30sm89709ika.2007.05.18.05.01.34;
        Fri, 18 May 2007 05:01:38 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <1179484482.6453.19.camel@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47597>

On Friday 2007 May 18, Raimund Bauer wrote:

> you need to set core.autoCrlf=input
>
> I had the same problem some time ago ...

The documentation says:

core.autocrlf::
    If true, makes git convert `CRLF` at the end of lines in text files to
    `LF` when reading from the filesystem, and convert in reverse when
    writing to the filesystem.  The variable can be set to
    'input', in which case the conversion happens only while
    reading from the filesystem but files are written out with
    `LF` at the end of lines.  Currently, which paths to consider
    "text" (i.e. be subjected to the autocrlf mechanism) is
    decided purely based on the contents.

That is: "input" ensures that CRLF is stripped on input to the repository.  
While that is fine in some circumstances, the situation I'm describing here 
is what happens on output from the repository.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
