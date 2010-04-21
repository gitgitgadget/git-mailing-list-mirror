From: Kim Ebert <kd7ike@gmail.com>
Subject: Re: Useless error message?
Date: Wed, 21 Apr 2010 15:29:02 -0600
Message-ID: <4BCF6E1E.701@gmail.com>
References: <z2o3abd05a91004211417v263d5a0eg497341ddf7bd79a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 21 23:36:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4haf-0002Cd-Qd
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 23:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756657Ab0DUVfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 17:35:14 -0400
Received: from mail-pz0-f176.google.com ([209.85.222.176]:39527 "EHLO
	mail-pz0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755329Ab0DUVfL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 17:35:11 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Apr 2010 17:35:11 EDT
Received: by pzk6 with SMTP id 6so2623483pzk.1
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 14:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=bQd6D4vms735SndHAOcDFcTaYr00iPoeDuyd2d3CmRk=;
        b=p9GlPqLvW4WCdl7yrADnjsDCt1a0LcRaiExdpFGFu3kp6Egp5S3a24wiZuQlCwda8F
         2qqWzAyPZFNYl4HeCP11jeSKDiCKWaHBuxUzvMBiFMBhQk64zhxyjjZsmytg5QaHrVBa
         m9oWZSSLj1O3MX0lyLeaXwBDPTo4LhvVNOqPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=KCIoh68/0Lup//DcM4AaYFcirB+70dwV8zMW2Gx8fot/Kn+mfrDf3DVPNx66RRKz7s
         mR3ojK2bftmDEuwOleydd34OnxRfLmvjmEWXTsD3U2/K3Q/543hGtmyXa/woD4b5YeZu
         YzSHcWI3FWCiVdd5gvncdkspttq0jbrvRCDjA=
Received: by 10.141.214.20 with SMTP id r20mr884610rvq.268.1271885344744;
        Wed, 21 Apr 2010 14:29:04 -0700 (PDT)
Received: from [192.168.1.201] (host-166.arcadia-srv-216-83-132.fiber.net [216.83.132.166])
        by mx.google.com with ESMTPS id h11sm10317519rvm.21.2010.04.21.14.29.03
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 21 Apr 2010 14:29:03 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090625)
In-Reply-To: <z2o3abd05a91004211417v263d5a0eg497341ddf7bd79a5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145463>

I find that it usually means I didn't set up git-daemon-export-ok. Of 
course, that has usually been my experience.

Aghiles wrote:
> "fatal: The remote end hung up unexpectedly"
>
> Is that really meaningful ? Or maybe it is a configuration problem
> on my side ?
>
>   -- aghiles
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   
