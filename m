From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH 3/6] transport-helper: clarify pushing without refspecs
Date: Thu, 18 Apr 2013 20:56:47 +0200
Message-ID: <517041EF.5060000@gmail.com>
References: <1366243524-18202-1-git-send-email-felipe.contreras@gmail.com> <1366243524-18202-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 20:57:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USu0y-0007AQ-20
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 20:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754358Ab3DRS4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 14:56:55 -0400
Received: from mail-ee0-f50.google.com ([74.125.83.50]:43138 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab3DRS4z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 14:56:55 -0400
Received: by mail-ee0-f50.google.com with SMTP id e53so1483424eek.9
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 11:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=SKAhEqMdAAytnH/oYWf4bPbWhxxsXX+fbpG2cCh2Kl4=;
        b=yLkbpHdDr8gk0s/w11m6/UVb6Mv2kFnT8IwWQPRFmH6oHpZio1ouX45jBTrUQc6k3S
         gJsJcwIFVch0irvqRGaxlq3lVRiDqrnn+Nh4EJjfWShHGAG7fOI9P+tAppX4S5YraFbL
         BY50SMxGsjrD3mhv2Y7pDgkgI4Qiv1pwdwA4bBnfvCtjx4mgqa0qwAmDw2GmumY30r+V
         Gtg6f2q4qP7ictzRosaQHU+6//XfBQZiAPlp9FEaeb91odpgGL6HVQm9cyEGZYPTSJc5
         JPfoAvxIZWQOqpOdiiXGEawZCVEjaQlg6tLXNsYiJKsMsanTlW8olnLf3Qpj55F5KJmt
         YObA==
X-Received: by 10.15.75.70 with SMTP id k46mr33350907eey.4.1366311414013;
        Thu, 18 Apr 2013 11:56:54 -0700 (PDT)
Received: from [192.168.178.20] (host93-95-dynamic.6-79-r.retail.telecomitalia.it. [79.6.95.93])
        by mx.google.com with ESMTPS id ch6sm17814293eeb.17.2013.04.18.11.56.50
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 11:56:53 -0700 (PDT)
In-Reply-To: <1366243524-18202-4-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221682>

On 04/18/2013 02:05 AM, Felipe Contreras wrote:
> This has never worked, since it's inception the code simply skips all
>
s/it's/its/ (sorry for nitpicking)

> the refs, essentially telling fast-export to do nothing.
> 
> Let's at least tell the user what's going on.
> 
> [SNIP]
>

Regards,
  Stefano
