From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Mon, 10 Jun 2013 23:39:15 +0530
Message-ID: <CALkWK0=A478RNR7v1qQ_xzVhHRRBEF96XHDS_a-dOwv5E0aF-A@mail.gmail.com>
References: <20130608164902.GA3109@elie.Belkin> <CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
 <20130608173447.GA4381@elie.Belkin> <CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
 <20130609014049.GA10375@google.com> <CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
 <20130609052624.GB561@sigill.intra.peff.net> <CALkWK0mu2_9M5aTczcEkv37eLaAg5_mGDZ_W9nqQFoesB4wc3g@mail.gmail.com>
 <20130609180437.GB810@sigill.intra.peff.net> <CALkWK0kkhDOSSdF=E4PvO24hg++_FpP3YFaGRD3yq80XG0TRJA@mail.gmail.com>
 <20130609184553.GG810@sigill.intra.peff.net> <7vppvvnetw.fsf@alter.siamese.dyndns.org>
 <CAMP44s3p1atFz52-mKaKpZkLGp+Uoehc1ovTUQAN-raxWzWd8Q@mail.gmail.com>
 <7v8v2il62c.fsf@alter.siamese.dyndns.org> <CAMP44s1x4Dm2KwyuN=oisSFdoCPxYzu+ZjZjHN45_=i7b=z0_Q@mail.gmail.com>
 <vpq7gi1eupf.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 10 20:10:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um6Xe-0003Wk-R1
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 20:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753900Ab3FJSJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 14:09:57 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:45039 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032Ab3FJSJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 14:09:56 -0400
Received: by mail-ie0-f172.google.com with SMTP id 17so17202718iea.17
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 11:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Fg/deGfodgt+wjZ4XEWeLhOzBAG8LXCAAwXo/DgIW3w=;
        b=ZVDCSLYfzmfXnFwJd5GiKlC9ep/KSHsoJquIdMMJNhZXzdWEjZHph0n2WqZtullOlB
         FCnFLEyEjXt/0WSKelAGqH/XYBsncSVDaAP19b0D2px4PBp33uKUM+j0QPSVwTw5c+Wf
         JyvUz6kEHKbngdQMpt4TMkWdqecBKF1ZoUypDbKMIq5/4vXGfp5TrCHLNgqT+d+yCK7s
         eApR+dLF0Xy1le+8nvthtc+Yqyen5jNWEn0Tb/BTHCtytZeExcmXxW3rlHVq/2lcxk0H
         9JtlPEEz/KgrWDC6unmh/cAbkX6VjTX9Ise5fEoB29l/JA/IDrGOZ4k8UQ6CDOX9NTgh
         +hFA==
X-Received: by 10.50.3.37 with SMTP id 5mr4531561igz.0.1370887796018; Mon, 10
 Jun 2013 11:09:56 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 10 Jun 2013 11:09:15 -0700 (PDT)
In-Reply-To: <vpq7gi1eupf.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227336>

Matthieu Moy wrote:
> https://lkml.org/lkml/2012/4/12/434
> https://lkml.org/lkml/2012/4/15/112

We don't want things taken out of context now, do we?  Follow up this
thread [1], if you're interested in that discussion.  I did clip out
the quotes you chose on purpose, in the interest of presenting
evidence in an unbiased manner.

> I don't follow the lkml so maybe I've just been unlucky and Google
> didn't show me an accurate sample, but arguing that your behavior is
> welcome on the LKML seems weird.

Are people criticizing his discussion style, tone, and demeanour,
instead of focusing on the argument?

[1]: http://thread.gmane.org/gmane.linux.kernel/1280458/focus=8675
