From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] blame: allow -L n,m to have an m bigger than the file's
 line count
Date: Wed, 10 Feb 2010 08:25:34 -0800
Message-ID: <4B72DDFE.7090400@gmail.com>
References: <1265786864-5460-1-git-send-email-bebarino@gmail.com> <76718491002100537h521fcc26gb267ed7cd2b8db6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 17:25:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfFNs-0001cY-UL
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 17:25:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755509Ab0BJQZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 11:25:41 -0500
Received: from mail-yw0-f173.google.com ([209.85.211.173]:61041 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754589Ab0BJQZl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 11:25:41 -0500
Received: by ywh3 with SMTP id 3so194695ywh.22
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 08:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=8ML+i8XBWEGH8gWQEtuvyI8mbpg0W5MNBitY+qDnOfg=;
        b=FNgLaGS+H3LLkQSCoVLl2j5MsCrZsc5913I3I3b6Wgld9y3ni8R52F4jAgflJKhTFV
         /0/ei2rAyHu8mWW/7bhIFTFjFUhywi4CUmb4OUCXPO43ZUI0t49/I+PRyf8DhnebHyQH
         te4HJjdNOm803rAdhv3QKxI2Am+f/+XjVy5eE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=TEu1eTPLAXObLz54EmzXkPHKOyllWaORfS71CMcJsCqCMTemxMvNm2bfmsr9NU4Vln
         hpXJtmxQvph1f1fDlw3D9rTWdDeolaypPvm8Ed6g9B4fdVOGxgaIGVH+G36F2v7ejfj1
         oL6j8AgQYJ/5TFQbiqlqHkPf5v6e3uRtdq82I=
Received: by 10.151.88.11 with SMTP id q11mr1369254ybl.20.1265819140114;
        Wed, 10 Feb 2010 08:25:40 -0800 (PST)
Received: from ?192.168.1.5? (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 21sm509337ywh.1.2010.02.10.08.25.36
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 10 Feb 2010 08:25:38 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7pre) Gecko/20091214 Shredder/3.0.1pre
In-Reply-To: <76718491002100537h521fcc26gb267ed7cd2b8db6f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139514>

On 02/10/2010 05:37 AM, Jay Soffian wrote:
> I agree this is the right thing to do. I'm working on a patch to
> support matching multiple times when given a regex range and made just
> that change as well. :-)
>    

Great! I'll split the patch into a documentation patch (for 1.7.0) and a 
behavioral patch (for post 1.7.0)? Or perhaps you can take care of the 
behavioral change in your upcoming series?
