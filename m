From: Tim Harper <timcharper@gmail.com>
Subject: Re: [PATCH] I don't known anyone who understands what it means when they do a merge and see "file.txt: needs update".  "file.txt: has changes" is much clearer.
Date: Sat, 3 May 2008 10:19:46 -0600
Message-ID: <E49F9E2F-A773-4B9E-A4FE-3A764D86803F@gmail.com>
References: <1209798522-13618-1-git-send-email-timcharper@gmail.com> <alpine.DEB.1.00.0805031509170.30431@racer>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 03 18:20:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsKTY-0002Mj-ET
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 18:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918AbYECQTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 12:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758778AbYECQTw
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 12:19:52 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:64040 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639AbYECQTv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 12:19:51 -0400
Received: by wf-out-1314.google.com with SMTP id 27so439461wfd.4
        for <git@vger.kernel.org>; Sat, 03 May 2008 09:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        bh=6MuKOO7geQZafepILvTehgwXBOowwbAlhizcueE/r10=;
        b=lfWt0sZxBu4DWxbV+DOVLHgilSUks+l+PSbyPWSOUPZvxIO0SgSeHzAQ2iUqw6syvWTZHIDCVn/NLZE577g4FgUxE10ZZARsudHZmTNiQkuaH3YbLBK7oMiCd/gcUKn7+YeJhSKIc9SeOhgwZxfTKoyT2VHKDWYtqpRTTnQARQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        b=XHbiW+Yxs8c6ngyoykHBc19C6/4dbeL0dfPLWGC3ew7WyHgK3bPGfDNT8psz+zeq3789i4Yclch5/0ZSPFrQHEBPRD1TuDgvFK7N5zEjk9ALCcu871KxY3gZyTPYALtIar1kJ7oFxASiLaKpXHCvXDmwbFULUf9/4TLo3KcgW+8=
Received: by 10.142.70.13 with SMTP id s13mr1745273wfa.162.1209831591322;
        Sat, 03 May 2008 09:19:51 -0700 (PDT)
Received: from ?192.168.1.105? ( [66.29.163.1])
        by mx.google.com with ESMTPS id 22sm10034649wfd.19.2008.05.03.09.19.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 May 2008 09:19:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805031509170.30431@racer>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81098>

heh heh - yeah, I used git to send the email and it just sent that  
huge honkin line.

I like "local changes".

There's a bunch of lines that say "not uptodate".  I'll look for them  
all and resend the patch.

Thanks,
Tim

On May 3, 2008, at 8:09 AM, Johannes Schindelin wrote:

> Hi,
>
> the subject is a nice joke ;-)
>
>
> On Sat, 3 May 2008, Tim Harper wrote:
>
>> -			printf("%s: needs update\n", ce->name);
>> +			printf("%s: has changes\n", ce->name);
>
> How about "local changes"?
>
> Ciao,
> Dscho
>
