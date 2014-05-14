From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Wed, 14 May 2014 17:30:03 -0500
Message-ID: <5373ee6be6d88_7411589304d6@nysa.notmuch>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
 <536a83097302f_76ff7a52ec6c@nysa.notmuch>
 <xmqqvbth8ha9.fsf@gitster.dls.corp.google.com>
 <536a999e2c0c_76ff7a52ec1e@nysa.notmuch>
 <xmqqoaz95ees.fsf@gitster.dls.corp.google.com>
 <536ad9601b73b_3caaa612ecdc@nysa.notmuch>
 <CAGK7Mr4DYuU34Zf_3fRQFkT+1TGOkpfLPUnQh=tYh6EMtBEt9A@mail.gmail.com>
 <xmqq8uq6rd30.fsf@gitster.dls.corp.google.com>
 <CAGK7Mr7AcqKnEBk1NwzJFJVSSQE9uWTE00zi+B9z6i0V5tBrEg@mail.gmail.com>
 <87mweku2pt.fsf@fencepost.gnu.org>
 <CAGK7Mr5ezbTVyq2wr7kYWjab6V1srrYwkqSGjo1GuPnkSuGWTQ@mail.gmail.com>
 <87iop8u1km.fsf@fencepost.gnu.org>
 <CAGK7Mr4N5L+jRE0ykBHvopgGv1x4iNXAK+_94R5KhBxHHqMYmA@mail.gmail.com>
 <87egzwtthf.fsf@fencepost.gnu.org>
 <CAGK7Mr6XTxpeJLSqL8PZMS8w+YCqxLrC5wX-dg4BdEaW3QAYTA@mail.gmail.com>
 <87a9aktqms.fsf@fencepost.gnu.org>
 <CAGK7Mr7jhpizoHuA9NDnyNPy_rr8_R0m8-hCFO3CDn2Hbh3_pQ@mail.gmail.com>
 <5373cfb744982_57c3bfb300a0@nysa.notmuch>
 <87mwekrsap.fsf@fencepost.gnu.org>
 <5373e2af9ae58_592416ad2f892@nysa.notmuch>
 <87egzwrovr.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 15 00:41:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhrH-0000CZ-Bk
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbaENWlC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:41:02 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:53591 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbaENWlA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:41:00 -0400
Received: by mail-oa0-f43.google.com with SMTP id l6so285667oag.16
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=Qd6PKuK+wAf3ZFWA4kH7hc2kGIExSzWcO2J0EfMNzkM=;
        b=vCnPmHWMSAl0LTzdrOT/CvkoH1pk41VvWqYk+CFxTV2ka5hZptyMyRmYOOvtQ+0sLn
         pdIzey/w2exzehDi1FkRBLQSFl/z6+49Jxl56EqXLa4KqT5fBIAM85fG2dpQWxGBeSwn
         03NdAw0aeirlTtaPoirbNDV7j3zprsSGyUtn56P3LbtQxtx4cWHPPX6NovOPqOVGLp7E
         yPRJ5jiRM2ht/Lrxr3/hAPb5Q3mDV1X60wll2MfbfxXjNpJ+0+vQQrwRnilzY1j6cMmn
         fKe+TgF89CYZmEI/9R9rdWn2Fx2pGaZPnE/nIxqIU7wXsHOUo0vjM7TkgApmvsL06cP+
         BVew==
X-Received: by 10.182.47.196 with SMTP id f4mr6355360obn.50.1400107260500;
        Wed, 14 May 2014 15:41:00 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id b7sm10599347oed.7.2014.05.14.15.40.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 May 2014 15:40:59 -0700 (PDT)
In-Reply-To: <87egzwrovr.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249044>

David Kastrup wrote:
> Shouting "your God is an imaginary shithead" every time you see Mark

There's no point in discussing with an unconstructive person as you.
I've made my point, you are just talking nonsense.

Every rational person on this list knows that if I wanted to, I could be
much more offsensive and insulting.

-- 
Felipe Contreras
