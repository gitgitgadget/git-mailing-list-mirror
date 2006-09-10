From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 1/3] Move sideband client side support into reusable form.
Date: Sun, 10 Sep 2006 21:15:11 +0200
Message-ID: <cda58cb80609101215t699c7d6fy4620c6a500d7d408@mail.gmail.com>
References: <7vpse4tcyc.fsf@assigned-by-dhcp.cox.net>
	 <7vk64ctctv.fsf@assigned-by-dhcp.cox.net>
	 <7vd5a4t3e0.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Rene Scharfe" <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Sep 10 21:15:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMUlz-0002UN-6J
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 21:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbWIJTPO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 15:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbWIJTPO
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 15:15:14 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:45424 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932533AbWIJTPM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 15:15:12 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1304368wxc
        for <git@vger.kernel.org>; Sun, 10 Sep 2006 12:15:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=INjnckxTYwBisQpw1HYNAWqz2oPsdO9aontTffaxZhJX4qDZrKDwSL2lTMftr0Gzxm1btMX+F64Dk9iYnOEAt/S/edp4RBpkJHpymgRZpTSBPoBsK9eHONF1IabNh8kyWOXExQ7CJTHDfLpiN2zslLti+ppykYRwPCj8j976soo=
Received: by 10.70.56.4 with SMTP id e4mr2804087wxa;
        Sun, 10 Sep 2006 12:15:12 -0700 (PDT)
Received: by 10.70.72.5 with HTTP; Sun, 10 Sep 2006 12:15:11 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vd5a4t3e0.fsf_-_@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26810>

2006/9/10, Junio C Hamano <junkio@cox.net>:
> This moves the receiver side of the sideband support from
> fetch-clone.c to sideband.c and its header file, so that
> archiver protocol can use it.
>

looks good, that's what I was doing but you beat me.

-- 
               Franck
