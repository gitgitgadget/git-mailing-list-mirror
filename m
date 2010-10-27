From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG?] t9500 --debug prints "sh: ++GIT_BINDIR++/git: not found"
Date: Wed, 27 Oct 2010 16:34:05 -0500
Message-ID: <20101027213405.GA10263@burratino>
References: <20101027204954.GA31386@burratino>
 <m3ocafib6z.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 23:34:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBDdT-0004dt-SZ
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 23:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406Ab0J0VeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 17:34:15 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52502 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757236Ab0J0VeO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 17:34:14 -0400
Received: by wwe15 with SMTP id 15so1295200wwe.1
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 14:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=C7ExXKej1QE0OzoiviYbXifdz2/g8+f0xq0bo2CXkeU=;
        b=cjmm8D4q9MaRjNqsRZwn2Rq3lExYqtbwg+odPJ+i8BPoT1kHPOtCOlmFwrwJJIgi36
         NR2MZM5eimc1RiNWSDfc24hQBwNUJsM5NfARfL0P/b4sVM9YdRKspyO0m8tuVLHdcHYW
         FKOkkLSkopHtyMexhlXjTSkogmzF8xGxdEVnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=E2V24MUGicV6TAqWaisg+R74ekNMq//h/lj7tjwRZVWys7HTMrwK4Cq9a9dbV/pZpZ
         IRa8TBAEXmMVywTnUItG4ixGwjnavFDy3Z2AVF26iRZKXeXuoXm75BsVmGzJoiXwxEbn
         0jq7f3w3b1F06ZPVwM8ElzN/pQ7E2Lv4/SmDY=
Received: by 10.227.156.202 with SMTP id y10mr2595230wbw.48.1288215252855;
        Wed, 27 Oct 2010 14:34:12 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id f14sm227198wbe.20.2010.10.27.14.34.11
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 14:34:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m3ocafib6z.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160126>

Jakub Narebski wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
>>  sh: ++GIT_BINDIR++/git: not found
>>  ok 3 - no commits: .git summary (implicit)
>>  [...]
[...]
> Fixed in 8ff76f4 (gitweb: Move call to evaluate_git_version after
> evaluate_gitweb_config, 2010-09-26):

Oh!  Yes, that works.  Thanks and sorry for the noise.
