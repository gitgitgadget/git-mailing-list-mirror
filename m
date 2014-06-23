From: Jonathan Nieder <jrnieder@gmail.com>
Subject: pb/trim-trailing-spaces (Re: What's cooking in git.git (Jun 2014,
 #05; Fri, 20))
Date: Mon, 23 Jun 2014 16:13:03 -0700
Message-ID: <20140623231303.GD4445@google.com>
References: <xmqqr42jcj5l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 01:13:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzDQI-0003bU-Oo
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 01:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbaFWXNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 19:13:10 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:37028 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbaFWXNI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 19:13:08 -0400
Received: by mail-pb0-f49.google.com with SMTP id rr13so6412961pbb.36
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 16:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/lJATjEZYqRbRcsYnoyD2NcWM+eluKRkdiJaYc8XaSk=;
        b=Ba6TtAZVRsp3cnVyxGOrETZ1j1SWVEAF6Lwa2FTXnn+uCiAQrTAgsT2ngPp6KPNRyA
         aloKBWsH7dozMopolCJwbhvGKRuoMN4NhgvOWIzXq7OREpq1QiVx+ZGgtYv1qcBl8CXx
         G+qJx68mkOi9zjvdPlvC+0f0Zssis8GZQKYx5SoF2BA3Carq/rLBwnQMA1xVVRSrmvkz
         gONog0FdsbLT+zKr7hUsfLKinGPfVLwjWeBA/RJht+B6Dgg5f4yvcWO/lNKl4DRpla9n
         NgbbsGrmeZO2eHBn5Jh9lRw8DuiSEjT9RNwiyrNgW/aKRpriwcKZc3A4g2jKhVtHNeft
         +7Yw==
X-Received: by 10.66.243.225 with SMTP id xb1mr33623066pac.49.1403565186643;
        Mon, 23 Jun 2014 16:13:06 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ox3sm28661687pbb.88.2014.06.23.16.13.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 23 Jun 2014 16:13:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqr42jcj5l.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252376>

Junio C Hamano wrote:

> * pb/trim-trailing-spaces (2014-06-13) 1 commit
>   (merged to 'next' on 2014-06-20 at 6985153)
>  + t0008: do not depend on 'echo' handling backslashes specially
>
>  Will merge to 'master'.

Without this patch, 'master' doesn't pass t0008 for me with bash as
/bin/sh.  The patch fixes it.  So fwiw I like the patch.
