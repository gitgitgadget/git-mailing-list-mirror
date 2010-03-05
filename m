From: walt <w41ter@gmail.com>
Subject: Re: Question about scm security holes
Date: Thu, 04 Mar 2010 19:20:36 -0800
Message-ID: <4B907884.5080501@gmail.com>
References: <hmp427$d6h$1@dough.gmane.org> <32541b131003041803q9abf6baq4cf9ffcca990b51c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 05 04:23:03 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnO5i-0002YT-QW
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 04:20:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755115Ab0CEDUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 22:20:33 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:13151 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754267Ab0CEDUc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 22:20:32 -0500
Received: by qw-out-2122.google.com with SMTP id 5so365626qwd.37
        for <git@vger.kernel.org>; Thu, 04 Mar 2010 19:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=wlUKZZkmwjxnpp6vLhw8h8vRzX3J+kYXv7DoRIJAlP8=;
        b=QxpmobNeV069ToFezCwu++TJWM59RhV2XtXb/gOnkZkZB2KyhCZCRwng7miDjT5oIF
         l8f/rtSk/LscPq615Hm4rd48kJZrhZ2/8gijt2Dx6ClI+UEieAAOjIG7nlS+EoWTjowE
         X/eR+hikHxsdSptNO34CqM0BjMcpfXwZx+MmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        b=uFsN/AOSBgm4X8Fu3DW6iyFH3oYWVSmo4WqYO9+tsYGSBFwIJe49HNWDscpX2kRHVb
         AvEsVGmRjVrEDdoKHhjCJjCreAN9kBOBX/wHyD5MCY5f5XjIm0ziAgMVNYPmDmB92AEV
         hzjWDOjEXbnlcI+863lBhA0SNWJdWRGFpZLqw=
Received: by 10.224.48.72 with SMTP id q8mr1854582qaf.2.1267759231820;
        Thu, 04 Mar 2010 19:20:31 -0800 (PST)
Received: from [192.168.0.100] (adsl-69-234-212-126.dsl.irvnca.pacbell.net [69.234.212.126])
        by mx.google.com with ESMTPS id 26sm1620866qwa.28.2010.03.04.19.20.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Mar 2010 19:20:30 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.3a3pre) Gecko/20100304 Thunderbird/3.2a1pre
In-Reply-To: <32541b131003041803q9abf6baq4cf9ffcca990b51c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141556>

On 03/04/2010 06:03 PM, Avery Pennarun wrote:

> ...you can create a commit with
> whatever committer/author names you want and then push them in.
> Commits aren't GPG-signed, only tags are, so there are lots of ways to
> forge a commit from someone else and mess up the audit log...

Thanks, that's the kind of reply I was hoping for.  Do you think there
should be a way to sign the commits themselves, at least as an option?

I certainly wouldn't bother, but OTOH nobody wants to steal my code :-/

Do you suppose the devs at Adobe carry the complete source repository
home on their laptops every night?  (Not if they use Perforce, of course,
but they might if they adopted git as their scm.)
