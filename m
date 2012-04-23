From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 00/10] i18n relative dates, help, remote, apply,
 index-pack and bundle
Date: Mon, 23 Apr 2012 22:06:36 +0200
Message-ID: <CACBZZX54AmWcCqD=BDx5MspRJSrLWUh5dfo=nrc8-x-Bei6MAA@mail.gmail.com>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com> <xmqq62cqjn0f.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Jonathan Niedier <jrnieder@gmail.com>, git@vger.kernel.org,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 22:07:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMPXM-0006lc-Rz
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 22:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753347Ab2DWUG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 16:06:58 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:37814 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840Ab2DWUG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 16:06:57 -0400
Received: by eekc41 with SMTP id c41so3369365eek.19
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 13:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rtmBAFwd/JTgajRoQxpwYBVDVvWMhnYGKkoxowCIDmo=;
        b=ZvSX2gM7+Tm5QL/RaNmMgDJs3gFVq4h8Yw4tH/z0paKy3XGfF6j1/v1Hyi7TjyHlfE
         DDe6rOZeq74blApvBqn8w50UKhEQYs4abHSRFnGaK/tXIYcbeij8JbTiMNRa1dMrcWp5
         PNq+MIxjYVjUlnZ9xKINQlKtYInBfyauNWPWN9Z9Ftwr2lpTb4Ig489l2fmCZ5TPt/nP
         qFKFJUHI8PFxQQ4QroiXQefdIAUtZwEV4P6+gVjseSyqikg3TiBnZomz+uhWdLE+wewt
         Pd7EDw9I0k3DJFXOZtIXx/2nOC00h7NH6/2xWrolA5v4Ax6GV/HaPzQTj4Oz0OxqrWdh
         zfhA==
Received: by 10.14.207.9 with SMTP id m9mr1505739eeo.52.1335211616512; Mon, 23
 Apr 2012 13:06:56 -0700 (PDT)
Received: by 10.213.108.81 with HTTP; Mon, 23 Apr 2012 13:06:36 -0700 (PDT)
In-Reply-To: <xmqq62cqjn0f.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196163>

On Mon, Apr 23, 2012 at 20:56, Junio C Hamano <gitster@pobox.com> wrote:
> This series looked sensible overall, so I'll queue but please eyeball my
> conflict resolutions after I push it out on 'pu' in several hours.

Same here. It looks good to me. Thanks for working on this.

Some of it uses strings concated to other strings, but in those cases
it would be tricky to provide the translators with all the
alternatives, and in any case it's a huge improvement on not making
things translatable at all.
