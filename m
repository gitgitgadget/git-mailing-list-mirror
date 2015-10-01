From: David Turner <dturner@twopensource.com>
Subject: Re: message not appear in mailing list
Date: Thu, 01 Oct 2015 13:27:38 -0400
Organization: Twitter
Message-ID: <1443720458.7753.1.camel@twopensource.com>
References: <CAHtLG6RwaXVuM2k4W1hWOnVzUjtQpr0irQkSC0VrdAOPe+bnFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?UTF-8?Q?=E4=B9=99=E9=85=B8=E9=8B=B0?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 01 19:27:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zhhe3-0002Bi-CR
	for gcvg-git-2@plane.gmane.org; Thu, 01 Oct 2015 19:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756696AbbJAR1q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Oct 2015 13:27:46 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34690 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756563AbbJAR1n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2015 13:27:43 -0400
Received: by qgez77 with SMTP id z77so73421943qge.1
        for <git@vger.kernel.org>; Thu, 01 Oct 2015 10:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:organization:content-type:date:mime-version
         :content-transfer-encoding;
        bh=4qkXl8dt+seCSRZBQLcjoMtvmtlZnKtx9pxhniAhc4Y=;
        b=jo9I7OyUjPrymRX3DWTbQGjkajkj4LoePgjtXjFJqlBu+5Mw5xtHypp1Kbu9HjzWRv
         BriVIKJSMcLcEYGLLWNOk3/s+Rv0RxiLVOES+J3hSwtqSJKYkNtzO6UwfSdWdGqXyDrp
         RgmLSBvcoX6yIKFY8fLtyNt92jCsWZZGmUtmQj7pelY3A8+RQg38OdBjnilAvYt49d86
         n3I7HMfs1etZ8OnEZM6bkhmNe97rak38gNrcR6Gc+3aqvrPSH29I1Z3pxic7bvhj9B6t
         i8ufyLbGGeEUxXRJ1OD4mxB/PQFBkdtCVkYVGpWMICCcaVPY7s40/rFwD0doNzcRtfV8
         7ieA==
X-Gm-Message-State: ALoCoQlLbGQbe1lZ6kXSTD8eW/ar4YHtx/4FoKLpZYl4dEyByipyENZg8r1+li2qaAQc0I3v2pDk
X-Received: by 10.141.23.19 with SMTP id z19mr14637219qhd.39.1443720462831;
        Thu, 01 Oct 2015 10:27:42 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id v34sm2793940qge.47.2015.10.01.10.27.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Oct 2015 10:27:42 -0700 (PDT)
In-Reply-To: <CAHtLG6RwaXVuM2k4W1hWOnVzUjtQpr0irQkSC0VrdAOPe+bnFw@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278896>

On Thu, 2015-10-01 at 11:47 +0800, =E4=B9=99=E9=85=B8=E9=8B=B0 wrote:
> Hi,
>=20
> Why the message not appear in mailing list for many hours?
> There is no reject reply message. I sent the mail in plain text with =
a
> tarball attachment.

The git mailing list silently rejects messages over a certain size (as =
I
discovered when trying to send a too-large patch).  Pop the tarball up
on mega.nz (um, or something) and send a link.
