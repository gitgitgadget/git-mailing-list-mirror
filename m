From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/10] i18n relative dates, help, remote, apply, index-pack and bundle
Date: Mon, 23 Apr 2012 11:56:00 -0700
Message-ID: <xmqq62cqjn0f.fsf@junio.mtv.corp.google.com>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 20:56:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMOQk-0007jf-D6
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 20:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754812Ab2DWS4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 14:56:04 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:35739 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520Ab2DWS4D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 14:56:03 -0400
Received: by qabg24 with SMTP id g24so330553qab.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 11:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=Qfi8XDle2sfsBRX/iDTefYuBfvj/Lp4E/mJexNKf3II=;
        b=VLvafpRllOcbXVTAql1F3Vidfy/zxbRFzUCS2oot+OiVZ9IQ/LjCEsG2WKSZnqbZ1w
         kfT+Cpzf6qTvdcqDSdUYD9iO/9x+YztCPVEYSU1MiHEotboy1xbPuak4QLHRhjx/8/+z
         W1lnVeUBmRWAQp8Cvif4mVbEuOLYO00yAf+FtuJcrjCwlHSAStc5XkxLGNF+/zjn40jd
         /ZQbrjVW3kPM329WH6s2R9wbeU+q9R7kofyf1xfojNF09O9FFQcE5fmWsJ+kZlIXQ9rm
         TSUriMJBpc4N3506QgWNcAcN9q6P6py67ji0hCbSxMaCcPXX9OGyY9i8QiLB+eIBigW7
         C00Q==
Received: by 10.101.137.21 with SMTP id p21mr6243758ann.26.1335207361800;
        Mon, 23 Apr 2012 11:56:01 -0700 (PDT)
Received: by 10.101.137.21 with SMTP id p21mr6243728ann.26.1335207361614;
        Mon, 23 Apr 2012 11:56:01 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id k54si15683227yhh.5.2012.04.23.11.56.01
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Mon, 23 Apr 2012 11:56:01 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 808F41E005B;
	Mon, 23 Apr 2012 11:56:01 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id EDB44E120A; Mon, 23 Apr 2012 11:56:00 -0700 (PDT)
In-Reply-To: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 23
 Apr 2012 19:30:20 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQm7Er115wY91KTWpINj0JRl2NjG8/ywIV8s0SMY/I98jkSFhiMtQXdOSGAVEHIQOxeS9df+KqutxElKNcCYAT9yO4RDntl+yW2w+OOJbiROSTQ92EJhEO+B9Y+lT299xQtpjjEOquLeeN2a6V4CjzLcyyu60NWTe70PV/gWwv6WSEnSiCQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196157>

This series looked sensible overall, so I'll queue but please eyeball my
conflict resolutions after I push it out on 'pu' in several hours.

Thanks, both.
