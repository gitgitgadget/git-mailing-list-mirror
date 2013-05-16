From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCHv2 04/10] remote: Reject remote names containing '/'
Date: Thu, 16 May 2013 17:44:40 +0530
Message-ID: <CALkWK0kRzADXq8ePTkDLg76-0du7+5Uvbn7pXu3Tw0d7VLsPow@mail.gmail.com>
References: <1368289280-30337-1-git-send-email-johan@herland.net>
 <1368289280-30337-5-git-send-email-johan@herland.net> <7vtxm7scn5.fsf@alter.siamese.dyndns.org>
 <CALKQrgcry9bwmonaeWA4M7a3k36S_Q3ZQLmv7Ui5r+tdzdMr_A@mail.gmail.com>
 <CALkWK0k=P265MCmvj9C7MFiF=tkhCZ__3oF8FWmWd4sNx3VcTw@mail.gmail.com> <CALKQrgewHCrkf0kP57Mm+werT9yAWnLZP7CJn-k3g85gfPRspA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	jrnieder@gmail.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu May 16 14:15:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucx5i-0003ff-9i
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 14:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753156Ab3EPMPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 08:15:22 -0400
Received: from mail-ia0-f169.google.com ([209.85.210.169]:56353 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934Ab3EPMPV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 08:15:21 -0400
Received: by mail-ia0-f169.google.com with SMTP id k38so3501959iah.0
        for <git@vger.kernel.org>; Thu, 16 May 2013 05:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Ze876mDzdqo+Nq8IG5CdAyZSWcBHCgITrvyJzJ0Lo0Q=;
        b=0AQDiP4N0q4r+2+dWvoVy+BM5+zPiEqJ7bX1PYj7Tlyo6is+rW0WajJYVm4LJH9VhD
         PCjZCs37w5TxBpUHldcIOfeIObR38u83FXq6/MNDRUTYK7hOnj+mgD29tQ2wSCZFqJaf
         /C3XwUMgnd+IFkiz0m5ui08esJuSyS8Bw22mZJRDwR4L6xmemcqeA2oHbE1Onk5y56kj
         IEVGpVQv1onHMLoZea0mX94WPYBYF+1hjniWl0KMOtuLKqg7lgYNMLtGdTG/JC+LVGUj
         NOfryvF+mWpkvKIc2qmThMZqEWfjlmP1X5Qu+vlQ4sOWnSHO8CS2b8H6EGiBDZnNYMbj
         NABw==
X-Received: by 10.50.73.65 with SMTP id j1mr9136136igv.49.1368706521132; Thu,
 16 May 2013 05:15:21 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 16 May 2013 05:14:40 -0700 (PDT)
In-Reply-To: <CALKQrgewHCrkf0kP57Mm+werT9yAWnLZP7CJn-k3g85gfPRspA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224558>

Johan Herland wrote:
> FWIW, I've abandoned this patch, and don't care much about multi-level
> remote names anymore. They work in current git, and they will sort-of
> work with remote ref namespaces as well, although you will have to use
> full refnames when referring to their remote-tracking refs. If
> multi-level remote names suddenly become popular, we can change the
> code to try to resolve them unambiguously.

Makes sense.  We can deal with the issue if and when multi-level
remotes become popular.
