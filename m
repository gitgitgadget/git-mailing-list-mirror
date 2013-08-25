From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] Make test "using invalid commit with -C" more strict
Date: Sat, 24 Aug 2013 23:40:41 -0700
Message-ID: <20130825064041.GT2882@elie.Belkin>
References: <1377316906-70338-1-git-send-email-draenog@pld-linux.org>
 <1377316906-70338-2-git-send-email-draenog@pld-linux.org>
 <20130824200128.GB2960@elie.Belkin>
 <xmqqfvtyl1gm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kacper Kornet <draenog@pld-linux.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 08:40:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDU0J-0005kP-1E
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 08:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756063Ab3HYGkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 02:40:47 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:43737 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756027Ab3HYGkq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 02:40:46 -0400
Received: by mail-pa0-f45.google.com with SMTP id bg4so2211635pad.18
        for <git@vger.kernel.org>; Sat, 24 Aug 2013 23:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=rL+vofJiaXl+LYdXGA++0PuPWIxLvlNfE8OiW1OIt3Y=;
        b=Wou7IeGRkd8qXtw5XWOJ1cXrV/N6nIVwS3ir+azaoa1eMQCEZgq4U/klH1lBLO1IGR
         TljopJ5OjTDKltd81BX35dRytypmAFKjf+NyE9HsAaCgPTV69NLa7e9n2E7Of44MEx+Z
         OJMOljrvgl/GEOGOxfpeSnpl6IAzaRRk8RnBFjpVI0Tt0NYPBd6w0Nqdmd+wjaqzSnwS
         8uEIWF0Q2MnC14hXwnvACmHRebo3U/abAy9ve0xgWTUUPlV/NuT1VqMF8EtLUy+MbRUA
         UlcdtZrTV/GA6Tfgq73UHDvTMV2Yb3AGEaDdtEyXhfvPEBMYdPm0cQNnSK/tUZNJbX8C
         RpeQ==
X-Received: by 10.68.169.161 with SMTP id af1mr8733306pbc.22.1377412845969;
        Sat, 24 Aug 2013 23:40:45 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id t9sm10137741pba.46.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 24 Aug 2013 23:40:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqfvtyl1gm.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232931>

Junio C Hamano wrote:
>> Kacper Kornet wrote:

>>> In the test 'using invalid commit with -C' git-commit would have failed
>>> even if the -C option  had been given the correct commit, as there was
>>> nothing to commit.
[...]
> Also it would be much simpler to say "git commit --allow-empty".

Sounds good. ;-)

Thanks,
Jonathan
