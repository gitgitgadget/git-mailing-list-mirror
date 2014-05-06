From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Tue, 06 May 2014 03:32:23 -0500
Message-ID: <53689e17e6dfb_17dfb9b31017@nysa.notmuch>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
 <20140505184546.GB23935@serenity.lan>
 <xmqqoazb944d.fsf@gitster.dls.corp.google.com>
 <20140506080749.GD23935@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 06 20:52:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiM5-0008Bg-0I
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934352AbaEFInJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 04:43:09 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:52711 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934339AbaEFInH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 04:43:07 -0400
Received: by mail-oa0-f41.google.com with SMTP id m1so7337943oag.0
        for <git@vger.kernel.org>; Tue, 06 May 2014 01:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=Qc6JSR29awdJjfiMU5vJhC2VIb2ZRSAOzwcKYGGSxW0=;
        b=miaiSaLEXvht6UeKmR/gS1ixFRYnJ9Doxh9U7ucEkSkZyuuQPWRECwb83AqcKnZ0Ph
         YYZvOG4JyypzhPIneKhcOShJnDBY4JRSiDc5D/zB+pVxTpYjsdJHgMbRNG8rZjxgYMBn
         r+XdgIUPPaxRQJ4m7YVi/J1XiiOxFA7XRPQ2zXa+nF5GCiYAs+uTYsKBNOjxOhRdnBN9
         tMP36zuddqLvcYDXJMI8D0g7aN9pJNLpEZdjERsuUrBrAHx22LvqdNkMuG2eYH2qX8TG
         Gs8A6oYT4zOgauuYOTdJnsDKpckT+3Oxgz5747dYC+d9+F36tqOndZnPUcFpSmeykCcH
         Hd8w==
X-Received: by 10.60.83.161 with SMTP id r1mr6141505oey.46.1399365787091;
        Tue, 06 May 2014 01:43:07 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id sm4sm25473100obc.3.2014.05.06.01.43.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 May 2014 01:43:06 -0700 (PDT)
In-Reply-To: <20140506080749.GD23935@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248213>

John Keeping wrote:
> The Mercurial API makes no such guarantee; it is considered a private
> implementation detail and most releases seem to contain some changes
> that require all consumers to be updated.
> 
> There is a different level of urgency between "you cannot use this new
> feature until you update Git" and "if you update Mercurial then the
> remote helper will stop working",

s/the remote helper will stop working/certain features of the remote
helper *might* stop working, but we are trying hard to make sure that
doesn't happen/

-- 
Felipe Contreras
