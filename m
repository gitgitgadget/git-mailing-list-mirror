From: Thomas Koch <koch@comsolit.com>
Subject: Re: git lock files
Date: Mon, 15 Jun 2015 10:52:57 +0200
Organization: comsolit AG
Message-ID: <201506151052.57956.koch@comsolit.com>
References: <5576F02B.4040002@gmail.com> <1433870383-7631-1-git-send-email-sbeller@google.com> <xmqqbngnmsmn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	kostix+git@007spb.ru, hackerp@suddenlink.net, sitaramc@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 10:53:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4Q8i-0005kF-JQ
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 10:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035AbbFOIxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 04:53:04 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37780 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965AbbFOIxD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 04:53:03 -0400
Received: by wifx6 with SMTP id x6so70371106wif.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 01:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:organization:to:subject:date:user-agent:cc
         :references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=J9yAgqopzzdoZYoVeZA9KrdKA3L/U+skC3keWOb1DT0=;
        b=FTkHwr8ohL/dski+nMe0nENjBVCWkE5l/wGBNOqcUF+yyi4FHIuNmV5vCcYm4R7SuL
         SsnnjrGzcSvVwgPUy/oEoT4P3TwzQz7viUnZ2zzFnCoX3trgRki9J2nVIfrI+/lucQqR
         MDklMFfNzWDq6QcVzRZiSFAhQyqng6v0bLjMHQwlGKqBjBskuA9wgcmDM8jXxOyk+I4J
         hbwbUr9ZaT1Y9C0Ez6P+JJTfbvHgZiOFrCeTwZDnXskYva2tQxcRXM27ufMsgi+W6x3O
         40y1bOZ5Il637BwpKjp2m21ykoUZkXcdZCkJs4gL4LGjMcGluJ9YdLtf2mxyMBC1dUjS
         89Kw==
X-Gm-Message-State: ALoCoQk4g9t3zBVNSfjCerKsDlTbZftxR6uUHuHg6KhgTPo8F9mcvAne0Uz/J2JOwzzm3cdfA75N
X-Received: by 10.180.198.10 with SMTP id iy10mr2062639wic.46.1434358381210;
        Mon, 15 Jun 2015 01:53:01 -0700 (PDT)
Received: from koch.localnet (234.114.14.46.dynamic.wline.lns.sme.cust.swisscom.ch. [46.14.114.234])
        by mx.google.com with ESMTPSA id ef10sm17886231wjd.49.2015.06.15.01.52.59
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Jun 2015 01:53:00 -0700 (PDT)
User-Agent: KMail/1.13.7 (Linux/3.16.0-0.bpo.4-amd64; KDE/4.8.4; x86_64; ; )
In-Reply-To: <xmqqbngnmsmn.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271664>

might contain good thoughts about locking + git:

Jan 12, 2010 Interest in locking mechanism?
http://git.661346.n2.nabble.com/Interest-in-locking-mechanism-td4293383.html

Jul 04, 2013 intend-to-edit flag 
http://git.661346.n2.nabble.com/intend-to-edit-flag-tp7591127.html

Sep 17, 2013 Locking files / git 
http://git.661346.n2.nabble.com/Locking-files-git-tp7596435.html
