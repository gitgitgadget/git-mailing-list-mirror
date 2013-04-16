From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH] submodule deinit: clarify work tree removal message
Date: Tue, 16 Apr 2013 09:32:21 -0400
Message-ID: <CABURp0rkeYc7K0COhc1+96Q2Ox2TaNRpMSmQYOiwBpgPJbsafA@mail.gmail.com>
References: <5112C6F6.4030607@web.de> <CABURp0pC2FELxM5aUwxuTqS1roZm+fwkCQA+BoXjrd0+yQMmbg@mail.gmail.com>
 <7v1ubk8u6o.fsf@alter.siamese.dyndns.org> <51477EFF.2010505@web.de>
 <7v7gl4mabf.fsf@alter.siamese.dyndns.org> <5159D9A8.30901@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	"W. Trevor King" <wking@tremily.us>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Apr 16 15:32:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US608-0006Ht-CQ
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 15:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755633Ab3DPNco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 09:32:44 -0400
Received: from mail-vc0-f175.google.com ([209.85.220.175]:41014 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753749Ab3DPNcn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 09:32:43 -0400
Received: by mail-vc0-f175.google.com with SMTP id ib11so372781vcb.6
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 06:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=O7MHQXEBdrUKocvRGvMVoLfKOym3Ek+N1c7+Z2k71IQ=;
        b=YlxtgK6pRfV2ZNVywAL2FMnQHgT9c4XaYAkn61uzjTF/ERHFIC+kHltjLj5F9qUl5q
         5Zdo4U5w5awOtVjNAt9jvhRbATHTHFQUTkY2TYcfmF/KwgCkqnizTaKpAMqMawsmziI9
         XtlOtogJJPn4VtNCP2vEv+qFAYcrU1R7b8lEpqyrMGaCdtKCD4GB4i31EzcjWXFSiBU9
         wi5LxfPcedFgblfSl/Rkw2VRQEFzs/5s4teA/hCJSxmaZAQ9+v1kMANSqDvDshQ83Rj8
         EOiaTZUSZQA3v9z4y/0KROsi7tYViOL1Q0oNC1nJrKw5rF5Bwz6G9j7g3ngvgyMcwlXV
         DsdQ==
X-Received: by 10.52.230.197 with SMTP id ta5mr1259465vdc.103.1366119162918;
 Tue, 16 Apr 2013 06:32:42 -0700 (PDT)
Received: by 10.58.219.34 with HTTP; Tue, 16 Apr 2013 06:32:21 -0700 (PDT)
In-Reply-To: <5159D9A8.30901@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221416>

On Mon, Apr 1, 2013 at 3:02 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Okay, so here is the patch for that. If someone could point out
> a portable and efficient way to check if a directory is already
> empty I would be happy to use that to silence the "Cleaned
> directory" message currently printed also when deinit is run on
> an already empty directory.

   isemptydir() {
        test -d "$(find $1 -maxdepth 0 -empty)"
   }

Sorry for the late reply.  I see this patch is already in master
(which is fine with me).

Thanks,
Phil
