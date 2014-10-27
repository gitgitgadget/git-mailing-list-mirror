From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Editing git changelog automatically
Date: Mon, 27 Oct 2014 07:05:44 +0100
Message-ID: <1414389944.7883.2.camel@spirit>
References: <CAM_iQpWNQbv_GTT+H5KNCqqRS3qWfBuBge4+ZTAS_WiaREku4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Cong Wang <xiyou.wangcong@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 07:06:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XidRH-0001MV-CF
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 07:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbaJ0GFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2014 02:05:49 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:35814 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbaJ0GFs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 02:05:48 -0400
Received: by mail-wg0-f42.google.com with SMTP id k14so2871043wgh.25
        for <git@vger.kernel.org>; Sun, 26 Oct 2014 23:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=wF1dcd5SMBNnEtfEknAD1afqxYdASDwaXVSfX1x1kzY=;
        b=KjawwrQuCbId4oB67unp/2Gz77zvGpUnHP+IGpU8xeR/F6oydBCafuIiq9nHOJ9gpN
         TkKI0QOJGjihMfZ9rBkGb4H9q+NifJfIz1UYY7P8BSuBqQfFr+bN/RHDjaRNX1IxgIrH
         Af6Z/YZfUzIMnhzf9Fgz10zOIMPXa7IzJP2KZgdQBgx/TWHqN3DlEIPWt4l1v6RUwUwc
         dfHU3imtk2ZgpXIpFHBOtF3KDRNjQgOqijTGpSkwDSOkaHy+dk0MxxkrqyzuAZXxsxGa
         +aUswtLkSq3jbz+L35vEidaIaqKZwJ2xYI5xQsjbVq4dscUmoSAA2gJ4YkIpyOgW7byR
         FumQ==
X-Gm-Message-State: ALoCoQmEMozceAvxiOgxIEYUSzhCrhfSDUojt+S6wQSI3DIEYgcpWV1bdYUS36Tt261Z6FlEVAxl
X-Received: by 10.194.87.168 with SMTP id az8mr20639191wjb.65.1414389947633;
        Sun, 26 Oct 2014 23:05:47 -0700 (PDT)
Received: from [10.42.1.3] (195-240-45-142.ip.telfort.nl. [195.240.45.142])
        by mx.google.com with ESMTPSA id pn4sm14373699wjc.38.2014.10.26.23.05.46
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 26 Oct 2014 23:05:46 -0700 (PDT)
In-Reply-To: <CAM_iQpWNQbv_GTT+H5KNCqqRS3qWfBuBge4+ZTAS_WiaREku4w@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On zo, 2014-10-26 at 22:27 -0700, Cong Wang wrote:
> 
> My question is how to edit dozens of git commit changelogs
> automatically?

You can use git filter-branch in --msg-filter mode.
-- 
Dennis Kaarsemaker
www.kaarsemaker.net
