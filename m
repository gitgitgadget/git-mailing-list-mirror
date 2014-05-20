From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Mon, 19 May 2014 21:06:24 -0500
Message-ID: <537ab8a0d1304_2edfa832fc53@nysa.notmuch>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
 <20140516084126.GB21468@sigill.intra.peff.net>
 <xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
 <20140516225228.GA3988@sigill.intra.peff.net>
 <5376f2ca5c90d_65b915db2f877@nysa.notmuch>
 <20140517062413.GA13003@sigill.intra.peff.net>
 <xmqq1tvq4r43.fsf@gitster.dls.corp.google.com>
 <53795ef8e4023_10da88d30825@nysa.notmuch>
 <xmqqppja2t8a.fsf@gitster.dls.corp.google.com>
 <537a75e0a53b7_afee5d300f3@nysa.notmuch>
 <xmqqzjidv1y4.fsf@gitster.dls.corp.google.com>
 <xmqqvbt1uzo0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 09:59:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmZcr-00047d-4b
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 04:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118AbaETCRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 22:17:52 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:48499 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbaETCRf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 22:17:35 -0400
Received: by mail-ob0-f181.google.com with SMTP id wm4so7186857obc.40
        for <git@vger.kernel.org>; Mon, 19 May 2014 19:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=JUfPIPaeRBFnPCzcUij4Mxefh8kIcqn1BMdED/wqoAY=;
        b=Qf0N7cYc2aFnulfmtl8HJOtjowcHA59E8RR7OF2D+DKt5vII2WCnUB9ofN1gQezuQi
         bQOIMkGw3RPIccviNS8pXK2BsC60GOfbYdI20uK4NS6R/MvuixAu3VdU6g5NVcF7VMQE
         DyIUbI+c3D9JuzKc5SEvCiTYHxvlHj2qpbftlHRsWV9RaQAxnPJ32A8RXsE6m52AmP2z
         zBsrHpD87s/DTI7eRFYEN5+ToXVReBei3/U90NVip8V6ee1WdiE4T+qawPFiGxJdfWlg
         tpq97ePx12J/RAsVF3HQSz3SKYn9GlXEgPUYVDs72IrCMFjOK/Ih80D8cTIOjaeXFBER
         w65A==
X-Received: by 10.182.250.200 with SMTP id ze8mr7598950obc.72.1400552255123;
        Mon, 19 May 2014 19:17:35 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id x14sm35229817obp.19.2014.05.19.19.17.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 May 2014 19:17:34 -0700 (PDT)
In-Reply-To: <xmqqvbt1uzo0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249640>

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Felipe Contreras <felipe.contreras@gmail.com> writes:
> >
> >> We could. Personally I don't see the point of making the warning any
> >> more annoying....
> 
> If we were giving the users a choice of "no thanks, I'll keep using
> the obsolete one", then trying to be a low key and giving them a way
> to squelch with an advice.* config might make sense, but if we plan
> to remove/stub at as early as v2.1, I think annoyance is very much
> what we want, actually, because it clearly is the case that we do
> prefer users switching instead of waiting for v2.1.
> 
> How does this sound?

The patch below assumes the user has ~/bin in his PATH, which might not
be the case. Personally I don't see the point of creating extra
annoyance with instructions that might not work.

-- 
Felipe Contreras
