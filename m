From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/3] t9350: point out that refs are not updated correctly
Date: Thu, 25 Oct 2012 00:06:53 -0700
Message-ID: <CAGdFq_hgYPF5eeCB9hSsjVfUyEhkBNJAtzoNuNqs5N6V-+w9Hg@mail.gmail.com>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
 <1320535407-4933-2-git-send-email-srabbelier@gmail.com> <CAMP44s1hdZb_7Lv8SEe+MsfC_q-nXsnjJobABFq6eFR_er4TaA@mail.gmail.com>
 <20121024180807.GA3338@elie.Belkin> <CAMP44s2RspCrRXZbRTsVwezyU9X=+8RF=_9Q+3zX75LBJkdoPA@mail.gmail.com>
 <20121024191149.GA3120@elie.Belkin> <CAMP44s2kjv9fHbruXv7NyVm9m+FjFnYDryuPZQ-RQXN9Nj6MAw@mail.gmail.com>
 <20121025042731.GA11243@elie.Belkin> <CAMP44s1Pe8Ef6-GRbmSs7rY7gWyaPCN+jWGysyttZp3drSDoZg@mail.gmail.com>
 <20121025052823.GB11243@elie.Belkin> <CAGdFq_gg3gPvCADje9ibz8xHgPOLF+=79EqksVzG2JeTOfHocw@mail.gmail.com>
 <CAMP44s3kBxzJbyoxPqWbRMWmpX9sNPGjdRy_KrTeRoVmGC-+Hg@mail.gmail.com>
 <CAGdFq_jfiX9apPyq6pba4S4iCQLGLmDvSrLaujSB5rO0i+fzfg@mail.gmail.com> <CAMP44s1cRg_we5nXeRG1WcWz7YUOBrauJigeNna1YETcno9p=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Eric Herman <eric@freesa.org>,
	Fernando Vezzosi <buccia@repnz.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 09:07:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRHXe-0001i7-6W
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 09:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758377Ab2JYHHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 03:07:34 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:37929 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758362Ab2JYHHe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 03:07:34 -0400
Received: by mail-qa0-f53.google.com with SMTP id c1so35241qae.19
        for <git@vger.kernel.org>; Thu, 25 Oct 2012 00:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=t9xgbAMkEV6nRwH45h3JUzCWvhEHOc63PUo29XqIVJ0=;
        b=rwr57Phg9lEtc0IJAeda/8It7b8lenGbd5BPY9rb8fwyhq+lwn5tV1MoKYQqy2WC7z
         eWs2MjM6l0cEg2mPMM7uXRdDFHXvymebKlg03qIECmooMnMt/hiIhPBl4WEnQxJ14hc+
         5yalTk4XVz0WXFlIEAhkHLoQIftIfrLYP+jKD4a5IsnwwMQmStBUoY7REh65uXRKPleR
         LLYUS078ncdTpPy1rQxWvTA00R20CMpp5/dyIA6cRf+p1s1SOWyZAgJWVgSBdXQAOYgO
         cz2Avx+NFIpn31LVjPRrLNPo9K3190ZlPIXWo8GX3lW7Gg73+4o0l1Hx33tzgiWnaPRL
         tTlw==
Received: by 10.224.189.12 with SMTP id dc12mr8487974qab.59.1351148853202;
 Thu, 25 Oct 2012 00:07:33 -0700 (PDT)
Received: by 10.49.36.195 with HTTP; Thu, 25 Oct 2012 00:06:53 -0700 (PDT)
In-Reply-To: <CAMP44s1cRg_we5nXeRG1WcWz7YUOBrauJigeNna1YETcno9p=A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208355>

On Wed, Oct 24, 2012 at 11:19 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Oh really? This is with your patches:
>
> % git fast-export --{im,ex}port-marks=/tmp/marks foo1 ^foo2 foo3..foo3
> reset refs/heads/foo1
> from :21
>
> reset refs/heads/foo3
> from :21
>
> reset refs/heads/foo3
> from :21
>
> reset refs/heads/foo2
> from :21

That's weird, we have this bit:

+		if (elem->whence != REV_CMD_REV && elem->whence != REV_CMD_RIGHT)
+			continue;

If I understand correctly that should cause it to only output revs
(e.g. 'foo1') and the rhs side of a have..want spec.
-- 
Cheers,

Sverre Rabbelier
