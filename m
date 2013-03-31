From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Composing git repositories
Date: Sun, 31 Mar 2013 15:57:48 -0700
Message-ID: <20130331225747.GB11704@elie.Belkin>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com>
 <7vmwtqt8rs.fsf@alter.siamese.dyndns.org>
 <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com>
 <7vvc8comj5.fsf@alter.siamese.dyndns.org>
 <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
 <51537A7B.7050206@web.de>
 <CALkWK0nfNCu775MBB-Y28=V93RkV24kbTLTDKWO2dZ-0yxX=Sw@mail.gmail.com>
 <5154AACC.7050006@web.de>
 <CALkWK0k=g3iFjmpUQA1VkuH2kZsVX1_Hpo=LZ7CuotwHz_1++g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 00:58:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMRCm-0002X3-Vm
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 00:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756000Ab3CaW54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 18:57:56 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:55136 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755985Ab3CaW5z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 18:57:55 -0400
Received: by mail-pb0-f42.google.com with SMTP id up7so252743pbc.15
        for <git@vger.kernel.org>; Sun, 31 Mar 2013 15:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=vXEF/iGzsCNK7UhGuRuipKvL7bJmZiwpgbb+Lg3wPro=;
        b=NKkbKCLnuVoug8ZEn6p0cVaEj0z7O544zeFGmOQWN2vXT8JVgl3uRXNsuu/j1Mdojp
         T6+TItNunBgXCnSHi2hXed+qcsUXEvEkDMMGWTimF1jIlH27kOaz8NNIg41yL2JQM+qX
         1IMncEpshdhMJeCUnZMiPthf5cys13P6mHHSdynWSbPS9HChZWWTzn7JzQLtmGDoOE/f
         1vioWvVKGI/CPcoi+0TPyPqU+VSHruPvrZIeqkrIT3BxM8w0eN2fa4N9oBD1OhlJ3g3d
         1ipUCGTrWNL9rB7SqF+yhtkxH16IE9W21w1tA2gcjxwAMA8P0TYXLMJh/d1uTdZahdfb
         Tq+g==
X-Received: by 10.68.177.162 with SMTP id cr2mr14936077pbc.179.1364770674690;
        Sun, 31 Mar 2013 15:57:54 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id k4sm11287742pbi.45.2013.03.31.15.57.52
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 31 Mar 2013 15:57:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0k=g3iFjmpUQA1VkuH2kZsVX1_Hpo=LZ7CuotwHz_1++g@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219648>

Ramkumar Ramachandra wrote:
> Jens Lehmann wrote:

>> A
>> commit is the thing to record here because it *is* the perfect fit
>
> Might be, but saying that doesn't help one bit.  I want to know why.
[...]
> To summarize, everyone seems to be elated with the current state of
> submodules and is vehemently defending it.  I'm a little unhappy, but
> am unable to express my discontent in better prose.  Let's just go
> back to writing patches, and come back to this if and when I have a
> full design.

Elated is probably not the right word.  More "annoyed at being told
their work is ugly without an accompanying concrete and actionable bug
report". :)

If you are curious, at a quieter time it might be useful to ask for
pointers to the discussions that led to the current design, and folks
on the list might be glad to help.

Hope that helps,
Jonathan
