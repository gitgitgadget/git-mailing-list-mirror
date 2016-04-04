From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: RFD: removing git.spec.in (Re: git 2.8.0 tarball rpmbuild error)
Date: Mon, 04 Apr 2016 20:20:01 +0200
Message-ID: <1459794001.19561.10.camel@kaarsemaker.net>
References: <CAHHSH-JrPiXnkdpU0cP6KE46hUr3-ZiSjW5FDMpV2HGmSou8kA@mail.gmail.com>
	 <CAFZEwPPQPsk3ERu-h5qk+VZ=f3Ta4oPwgHN=5hTuVH5wxeiPGQ@mail.gmail.com>
	 <20160402161636.GD13271@zaya.teonanacatl.net>
	 <xmqqshz3fjeu.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Todd Zullinger <tmz@pobox.com>,
	Pranit Bauva <pranit.bauva@gmail.com>,
	=?UTF-8?Q?=E3=83=9E=E3=83=83=E3=83=81=E3=83=A7=E3=82=B3=E5=A4=AA?=
	 =?UTF-8?Q?=E9=83=8E?= <mebius1080p@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Apr 04 20:20:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an96j-0001te-7i
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 20:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754403AbcDDSUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 14:20:07 -0400
Received: from mail-lb0-f196.google.com ([209.85.217.196]:33906 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbcDDSUF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 14:20:05 -0400
Received: by mail-lb0-f196.google.com with SMTP id vk4so24064835lbb.1
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 11:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gFa2AhcQRC4bbnChS9IL+S7tU8JcljqVDyHfNLaosaE=;
        b=I8TdGVbadAH9kmZw79cP0gpcw7qV0yemATb0iewa9YLTVZKMwSYShYRzjQAXX5vP5E
         i6znCOSYG9cl9AabG+2WnPWd57d5REJk4YbHPn+OXmOzi9cSuFHPIK/pz6HIMZ3R8qZI
         gzt8sSglW95CwwQ+4PUMqLAeJjWTSxnxtBAHXo9wp0ZYrefkY5KnNHHWByXLlbsrqAIT
         i+jWyvI/craTt9swupm/yiDVns+fc8lMAgBBSSBuTkk494uQe7rOWnGVc9ILx7z3nGrB
         GIpFFV/M9u05b3fVoAW7Yxvk71OcVeelFtKsal1Vn+Y7l4WFCkmCAiBObA/bbqgi7mfF
         qSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gFa2AhcQRC4bbnChS9IL+S7tU8JcljqVDyHfNLaosaE=;
        b=hY2anK1hO4BufNGAf78GKhSzB9RFi4qB5pv29WZ2+hpuXj2jvFPQEx0ycWLMmyfPwL
         SUlJVhTqxkqiD18abp5q159s28DPSi75iOpwG0a7X9rLmKSZgXRNT/l1GNO1CdTmboAO
         ZXi6cj9Yh7dbc66Xk9fx0pVZV5HECSBqkFBpH87BlEWXZ3C1yp/6bJqu+CcIXbIxaO70
         UupvYV5WQ0gD68XKFZpRZ9/pwReD2naZu7TfYzrK1fSYFo/Zg4ASD1c/UIBVeZwSy9tp
         UMN1m2TrU3rZAu3IadkbZp+tzstuVwMOABzTlZuCGja1HIE3MoV4L+P9c+BgWOOwrGuo
         6Row==
X-Gm-Message-State: AD7BkJI5GpDZlB3XHAT3GmaOtUiz/XYqOVCjZf+QebA1JURKlcYU1sew8pmGRf044fsIYQ==
X-Received: by 10.28.148.19 with SMTP id w19mr13477690wmd.10.1459794003292;
        Mon, 04 Apr 2016 11:20:03 -0700 (PDT)
Received: from [10.42.1.4] ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id b8sm30347023wjf.9.2016.04.04.11.20.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Apr 2016 11:20:02 -0700 (PDT)
In-Reply-To: <xmqqshz3fjeu.fsf_-_@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290713>

On za, 2016-04-02 at 20:41 -0700, Junio C Hamano wrote:
> I think by now it is very clear that nobody active in the Git
> development community tests RPM binaries built with git.spec.in we
> have in our tree. I suspect RPM based distros are using their own
> RPM build recipe without paying any attention to what we have in our
> tree, and that is why no packager from RPM land gave any bug report
> and correction before the release happened.

Fedora, RHEL, CentOS, OpenSUSE and Mageia all use their own specfiles
and local patches. I do test and distribute RPM packages based on the
next branch, but use fedora's packaging to do so (which incidentally
also broke and I had to work around this change, but I completely
forgot about git.spec.in).

> I'd propose that during the cycle for the next feature release, we'd
> remove git.spec.in and stop pretending as if we support RPM
> packaging.

I would be in favor of that. In general, I find it much better to use a
distro's packaging and simply transplanting a tarball into it. That
keeps the difference with what the distro provides minimal.

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
