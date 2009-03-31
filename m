From: Joshua Juran <jjuran@gmail.com>
Subject: Re: strbuf name conflict on Mac OS
Date: Tue, 31 Mar 2009 14:57:59 -0700
Message-ID: <B21DA82F-5057-4C78-8400-1CEE5D4E8078@gmail.com>
References: <E5D92A5D-B2CC-44CE-B117-0BB88C0E663E@gmail.com> <alpine.DEB.1.00.0903312222440.6616@intel-tinevez-2-302> <76718490903311436p5fe81ce3k31f18170d9388e8e@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 23:59:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lolzk-0007nk-QR
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 23:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756362AbZCaV6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 17:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755950AbZCaV6I
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 17:58:08 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:20445 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754401AbZCaV6F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 17:58:05 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1791248wah.21
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 14:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:in-reply-to:references
         :mime-version:content-type:message-id:cc:content-transfer-encoding
         :from:subject:date:to:x-mailer;
        bh=+mLUxxHRhyUi9hUerkzhOqkisfjKfaRMGlYIVB9CgCo=;
        b=uQZQ2ibQone2c9Fba3Z2+86aSbQg8LYzlguA/C+vM/N8fid3DPwvGY5C5yzCEq2gi5
         i95W79cCcSAoNK5BvpUNeV8lX23dfvJqSK46hxMl6nq2XfbazTN8JmZoGQ3ZsaU9WdH/
         3R29K7YxvaEEX+p8iTkWV1OLJX7QYRabmVuDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=in-reply-to:references:mime-version:content-type:message-id:cc
         :content-transfer-encoding:from:subject:date:to:x-mailer;
        b=xAKSejLaAVZJNeCDeE7vM4OszYvaxn72iioDws15vMN87LK6MN11hRPcgPAWzGaEyY
         w01FTN7N+o/WKz4t40yX9Tb/RKD3hiEXMMOoQ9TkqGmBlV5JY0GpkJ2XT0SsDGIfQ6Vs
         gwvEMcTTc9f7gEyHp/KcjeGj354ePJv50RDXM=
Received: by 10.114.160.17 with SMTP id i17mr4688956wae.125.1238536683839;
        Tue, 31 Mar 2009 14:58:03 -0700 (PDT)
Received: from ?192.168.1.24? (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id m29sm1333772poh.20.2009.03.31.14.58.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Mar 2009 14:58:02 -0700 (PDT)
In-Reply-To: <76718490903311436p5fe81ce3k31f18170d9388e8e@mail.gmail.com>
X-Mailer: Apple Mail (2.753.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115321>

On Mar 31, 2009, at 2:36 PM, Jay Soffian wrote:

> On Tue, Mar 31, 2009 at 4:24 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> How about this instead?
>>  ifeq ($(uname_S),Darwin)
>> +       BASIC_CFLAGS += -Dstrbuf=git_strbuf
>
> Heh, wrong platform. See Joshua's other message about porting git to
> Mac OS (not Mac OS X). :-)

That, and I'm not using make.  There's no need for this to be any  
more painful than necessary.  :-)

I've added compat/lamp.h, following Brian's suggestion.

Josh
