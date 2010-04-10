From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git status --porcelain is a mess that needs fixing
Date: Sat, 10 Apr 2010 00:51:24 -0500
Message-ID: <20100410055124.GA17778@progeny.tock>
References: <20100409184608.C7C61475FEF@snark.thyrsus.com>
 <20100410040959.GA11977@coredump.intra.peff.net>
 <20100410054645.GA17711@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Raymond <esr@snark.thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 10 07:51:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0TbB-0006CR-4R
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 07:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241Ab0DJFu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 01:50:59 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:41774 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861Ab0DJFu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 01:50:58 -0400
Received: by ywh32 with SMTP id 32so720883ywh.33
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 22:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=PhxcMBNh2w1VxScVoQNg2melmEcTc9xEL6WjbYwqgag=;
        b=cb/SOv3SebuHxjQMBpORLO8LedwS207u81sPQx3CgpK0+ju07jxL23XtnP+1EmwGZk
         Y7uW8h57MqAit0KToWMGX33l7gKpQkEJw7rfN21Pyln3QqVrHwrJ7s3+5me6xTVqruLu
         fODhNTeQxeJ8bth/IHEdrmWpZkseyvx4fw8xs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=q7ufC+kFvasmm89UCfCa1ro7Vgn43YsHCtESqPY0w0vOAkLp3mHO3dvFjx4Ekr3HLy
         hLfZvTjRCM/ky6JqI82jTlGzmBWHytyLQj0wU/psnr3AIiprD6TCo4I92uHQPoHtddb8
         st1J9+OXyqlwKBwpi7+04UW+vC3fIUTzPNn8Y=
Received: by 10.100.233.2 with SMTP id f2mr1575631anh.43.1270878657653;
        Fri, 09 Apr 2010 22:50:57 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm1526740iwn.2.2010.04.09.22.50.56
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Apr 2010 22:50:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100410054645.GA17711@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144513>

Jonathan Nieder wrote:
> Jeff King wrote:

>> If you really want a list of ignored files, I think you are stuck
>> comparing the output of "git ls-files -o" and "git ls-files -o
>> --exclude-standard".
>
> "git clean -n -d" may help.

err, "git clean -n -d -X".

I am also not sure how stable the "Would remove " output format is,
or how stable we want it to be.  Probably not stable at all, so
sorry about that.

Jonathan
