From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: Question about commit message wrapping
Date: Mon, 12 Dec 2011 23:16:49 +0100
Message-ID: <op.v6edibfz0aolir@keputer>
References: <35A5A513-91FD-4EF9-B890-AB3D1550D63F@sidneysm.com>
 <m3zkf1hnh9.fsf@localhost.localdomain>
 <E085218D-9287-4F82-B34C-8379742F818A@sidneysm.com>
 <201112102030.15504.jnareb@gmail.com>
 <CAH5451kGn72tLAwdvQFBjSyHSL0rUmaPZrbL7Z-KfHWN-HAuCQ@mail.gmail.com>
 <CAH6sp9NwyxZi6KR4U96=sWdiqCseyTLEDoHdw=y9hUx2kHwOpg@mail.gmail.com>
 <4EE62DB9.8030406@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Andrew Ardill" <andrew.ardill@gmail.com>,
	"Jakub Narebski" <jnareb@gmail.com>,
	=?utf-8?Q?Sidney_San_Mart=C3=ADn?= <s@sidneysm.com>,
	git@vger.kernel.org
To: "Holger Hellmuth" <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Dec 12 23:17:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaEB9-00008K-7u
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 23:16:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754489Ab1LLWQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 17:16:54 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:51894 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754481Ab1LLWQx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 17:16:53 -0500
Received: by eekc4 with SMTP id c4so1842009eek.19
        for <git@vger.kernel.org>; Mon, 12 Dec 2011 14:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=DWyF+wOsSTiLiQcXVXs/e5eHWcxzchMZ2h1M56q0bv0=;
        b=jMnMYn8rhmLtciXUnUrdRbPSf6jEl1eLdAkCDUZZsK+XcxBev4QgP0HEnfMNhpl6yT
         orc+2LgNjdCEmsaQCtOrxqSd3LmKYkfB06cUzqcjUTksIzbwK6I8Drs/3HKwnPMMcJnx
         Jq6nPSuj2Geu/mFkUoT5GuTR6vBTo9mAHAmoY=
Received: by 10.14.11.222 with SMTP id 70mr3151253eex.186.1323728212597;
        Mon, 12 Dec 2011 14:16:52 -0800 (PST)
Received: from keputer (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id 54sm1842296eeo.10.2011.12.12.14.16.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Dec 2011 14:16:51 -0800 (PST)
In-Reply-To: <4EE62DB9.8030406@ira.uka.de>
User-Agent: Opera Mail/12.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186963>

On Mon, 12 Dec 2011 17:37:13 +0100, Holger Hellmuth <hellmuth@ira.uka.de>  
wrote:

>> I am starting to think that we need to somehow keep the current
>> behavior, but override at smaller widths. Maybe even use format=flowed
>> in format-patch.
>
> Could you explain what overriding at smaller widths would achieve?  
> Supporting format=flowed would be nice though.

I specifically meant trying to detect pre-wrapped text, removing the  
new-lines where we think it is because of wrapping at 80 characters. So  
the result would be: perfect on screens up to 80 characters wide, and ok  
on anything wider.

The implementation of that however could affect code in the mail if it  
isn't done properly.

>
>> On the other hand, the fundamental use with git is to
>> communicate code, and I'm not sure how that [cw]ould be handled.
>
> I prefer wrapped code to code that is cut of at a specific column.  
> Wrapped code has much less possibility for misinterpretation. Python  
> programmers might disagree?

Wrapped code as in auto-wrapped? Or as in manually wrapped? Python  
programmers have significant white space, but you can still hard wrap  
stuff, as long as the next statement is properly indented.

>
> I see your proposal mainly as an improvement to the display of texts,  
> not code.

Me too.


-- 
Using Opera's revolutionary e-mail client: http://www.opera.com/mail/
