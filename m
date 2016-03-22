From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] mingw: skip some tests in t9115 due to file name
 issues
Date: Tue, 22 Mar 2016 11:03:37 -0700
Message-ID: <20160322180337.GH28749@google.com>
References: <cover.1458668543.git.johannes.schindelin@gmx.de>
 <7b4eca83305ec05af6434ff80269ba563f2d581d.1458668543.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lars Schneider <larsxschneider@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 22 19:04:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiQey-0002GX-2o
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 19:04:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869AbcCVSDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 14:03:43 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36625 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbcCVSDl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 14:03:41 -0400
Received: by mail-pf0-f193.google.com with SMTP id q129so37944309pfb.3
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 11:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fzr1tPRDLjZodDFiLqTFVngQZXjZvi0y2nJN7KQZkW0=;
        b=RiCh+jBwhl7xX9Uw3nfVlQQlSA4meSUkSLUzbqPAXYFNfczXvILT/HqnWyjpj+g5N/
         ka9iHGjlP5mFqs2+8aefYr25VWyQZMoGfFt+4IZZOeWOIEzNKznNpgb1hsyyodJ+l0EL
         DE8HUw2SlKwvn+1/+P4X8e7zcI/JEEy/jmSkSuypOXr9173XUJKT/Qcj3A0RaKBuNqcG
         GZp4xsH6yj4ULhWZMJhcmDmUzHiJ+DxVVq9AdCMDA76sK79eguSYem+FSJNHNtWmzqge
         NrgWSwwsHEf6jWz4Lyzm1NsK67M9uHEP/+/RPAqQGtcCjW1J44vqTQ0aSnncHnVoIX5I
         4QAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fzr1tPRDLjZodDFiLqTFVngQZXjZvi0y2nJN7KQZkW0=;
        b=e+AXQMyKddtuyo9GvNMb6VDhoMOz7rPRXKdqB4YvGJdIbM/abSYBwuP98rPn1JpXkP
         REunFIDOwVav4fW+HcPtEToTZTbJkDXPnvhWxcg9OsMmwsBS2yBOzdTcfCvyebjhgg40
         uK1zz/0e6/qJILIiImmameE2KPOeU5XR/Xj9DTQhJdBbpDZcwKhdBAvBYdMU175FNOxS
         z2fbj8++w08A3YvDTMmJ9DBkzTQGoIiecqGzbDrHdC+FsO5SPPpzVh4EZagVYFr9aVo3
         8Dgb23bXFtIEg1LxQFwE7Bs6nrwMoLNRQ0ZOSSGzI2i35Nusa0nZDsWdn21foWzhT4pz
         N/gw==
X-Gm-Message-State: AD7BkJKGuGDVxvtyC8sCy0zotTw+Nyt5yllJaYQKAIeFZNEKFhfTQ8/pRKyJTBUyXol9Ig==
X-Received: by 10.66.118.7 with SMTP id ki7mr56160904pab.152.1458669820423;
        Tue, 22 Mar 2016 11:03:40 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:694a:ddce:573a:2ea8])
        by smtp.gmail.com with ESMTPSA id w62sm49818761pfa.79.2016.03.22.11.03.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Mar 2016 11:03:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7b4eca83305ec05af6434ff80269ba563f2d581d.1458668543.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289538>

Johannes Schindelin wrote:

> These two tests wanted to write file names which are incompatible with
> Windows' file naming rules.

Makes sense.  Ideally these would use the FUNNYNAMES prereq which
would be factored out as a lazy prereq from t3600, t4135, and t9903.
But using !MINGW is simpler and works now.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
