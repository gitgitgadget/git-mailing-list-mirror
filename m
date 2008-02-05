From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH-v2 4/4] git-commit: add a prepare-commit-msg hook
Date: Tue, 05 Feb 2008 16:26:42 +0100
Message-ID: <47A88032.107@gnu.org>
References: <1202205704-10024-1-git-send-email-bonzini@gnu.org> <1202205704-10024-4-git-send-email-bonzini@gnu.org> <alpine.LSU.1.00.0802051500190.8543@racer.site> <47A87DDC.5030708@gnu.org> <alpine.LSU.1.00.0802051520520.8543@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 05 16:27:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMPi7-0000I8-1P
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 16:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200AbYBEP0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 10:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753335AbYBEP0t
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 10:26:49 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:28718 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbYBEP0s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 10:26:48 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3545078wah.23
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 07:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=Ux2JAILod4cTjkc8tnJpC0MXVU4JB9WvhW/3yAO1hYY=;
        b=gK1UBIn6rn9efX4trpBofh8PxWetX7LvJnD1XUjtQru6tqjkwpe9+XngIIekQ2siHr02oZffa/4xto9C8ea5VrSj9DYVoQYat6+u+FIEXmfM8oaonKV87SeOVPgB93P9YQSx8Z71/KAYeovLw++wuYqawI5Mv3Lj+ssmgCpdNEk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=HIiPXa/LZGS4cAqB9NBdqejk1tT3QoF5lP4asJ9P+298h0IZz2zs1P1z/mPm468MVg3ZFyHVPfQzxizO90BmpkzB9p4w2e+8wI17raTRfdQIv3zMjWb+ciOGzH25VvXuoRPcEnAc2YHoTCutnLueYW23NSME7YoZFJ76Me+Ghs4=
Received: by 10.114.159.1 with SMTP id h1mr2025262wae.122.1202225205762;
        Tue, 05 Feb 2008 07:26:45 -0800 (PST)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id j10sm7480823mue.14.2008.02.05.07.26.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 Feb 2008 07:26:45 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
In-Reply-To: <alpine.LSU.1.00.0802051520520.8543@racer.site>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72671>


> I might be missing something

No, you are not.

> but should this not be solved by having the 
> prepare-commit-msg exit 0?  I mean, it is conceivable that such a bad 
> error occurs in the hook that the commit should be stopped then and there.

So you say, don't suppress the hook with --no-verify *and* exit if the 
hook returns 1, even if --no-verify is given.  That's fine by me.

Paolo
