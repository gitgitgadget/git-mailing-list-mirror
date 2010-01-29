From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH v2] fast-import: Stream very large blobs directly to	pack
Date: Fri, 29 Jan 2010 18:02:55 -0500
Message-ID: <4B63691F.4000507@gmail.com>
References: <20100129012350.GD20488@spearce.org> <7vockdjx6w.fsf@alter.siamese.dyndns.org> <20100129152254.GC21821@spearce.org> <20100129163838.GD21821@spearce.org> <m3aavwbwaz.fsf@localhost.localdomain> <20100129183024.GA22101@spearce.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jan 30 00:03:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nazrq-0000Yl-7d
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 00:03:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755922Ab0A2XDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 18:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303Ab0A2XDE
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 18:03:04 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:37274 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754783Ab0A2XDD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 18:03:03 -0500
Received: by gxk26 with SMTP id 26so683549gxk.8
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 15:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=qoHW+beEyLs1MogiQ61idLwEebfYcxMVtciw4YNIXH0=;
        b=X6uYdOkQST9VHQ81C2JburZNzEXt40pU1hunNDQjmjCSwdzYksvtDDvyIZi10iJahj
         j9FXs+LT/WPav0WJxq4w5GDpcxYPrBOoSixQ3dKqZSxTJInBtgh7V4Fn4e8MyC4tY8FM
         dT9C7FnXk42u1UgJGDVU20eLattmrXGfdgTqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=Kxahne6NHte5e0rVt7ASSe9/GgxRxWBT61Vj7bUbk4p7y+7+/bqd2g33cmsThBLqa6
         WPATsbLOWcQJ00DOf7E2+r3QScM572UzMGNv0ZPdPvpc9o5pX2XseOU7d0E7dW7ux4NC
         YD4W7fmdfvkegA6moGJp9EZW2lnUjSbJSNR1E=
Received: by 10.101.118.5 with SMTP id v5mr1719336anm.99.1264806181763;
        Fri, 29 Jan 2010 15:03:01 -0800 (PST)
Received: from ?10.0.0.6? (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 23sm880934ywh.3.2010.01.29.15.03.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 Jan 2010 15:03:01 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <20100129183024.GA22101@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138396>

Shawn O. Pearce wrote:
...
> Implemented as core.bigFileThreshold in this patch... but I didn't
> document it...

Bad dog! No biscuit!
