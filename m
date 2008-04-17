From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Confused about "ident" filter
Date: Thu, 17 Apr 2008 16:36:09 +0200
Message-ID: <48076059.4040503@gnu.org>
References: <Pine.LNX.4.64.0804170812230.7970@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu Apr 17 16:42:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmVEX-0000Qp-VD
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 16:37:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756064AbYDQOgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 10:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756060AbYDQOgT
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 10:36:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:13705 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755822AbYDQOgS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 10:36:18 -0400
Received: by fg-out-1718.google.com with SMTP id l27so71211fgb.17
        for <git@vger.kernel.org>; Thu, 17 Apr 2008 07:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=qKFI8Wmf32GwShRaFwLgfMocp7U6RkqOe9Q4WvPRmbg=;
        b=YabAucoCKYMMMtA2t+eEDMOoTSdYy3nrsJH3pGdWjBzNr1zcHahV1j15Df/KmauK854T3L25qJfI2C9+nnRHIHHqZvKUE+MojJ1zL6awY3JKq8AwmxDcdoZNDKhcX/JQw0mYWlwytMZVnrN8wj5dVg+sEK/7k/tFccJA4NTKKXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=UNIs17HMyX7Hd07YOTQkUqq3IRcE04WIJpcPj+eFTZQD+63WbtSuEEAvUw34fElCehnVwyophVLmctYGLESIo9bQg3B133FHEvwjC9PAVSAqLXHGekzJjrzTPjIJ7RqM9ge84YxrlXFXOaHLeXBO6h+k0COLW2MVvAkI0Oa6Aa8=
Received: by 10.86.89.4 with SMTP id m4mr2834814fgb.45.1208442975145;
        Thu, 17 Apr 2008 07:36:15 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.176.226])
        by mx.google.com with ESMTPS id e11sm8099420fga.5.2008.04.17.07.36.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Apr 2008 07:36:14 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <Pine.LNX.4.64.0804170812230.7970@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79792>

Peter Karlsson wrote:
> I tried doing "git checkout test.perl", I tried "git clone" to get a new
> copy of the repository, but still it showed only "$Id$".

In fact I'm a little confused too.  The only way I found to expand 
"$Id$" consistently was "rm test.perl; git checkout test.perl", or "rm 
test.perl; git reset --hard HEAD".

I was not so surprised that clone did not expand, though IMHO it is a 
bug -- but I was *very* surprised to see that cloning a bare repository 
did not expand, either.

Paolo
