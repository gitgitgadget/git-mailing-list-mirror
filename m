From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v4] transport-helper: report errors properly
Date: Mon, 8 Apr 2013 11:20:15 -0700
Message-ID: <CAGdFq_h9o+oMriF52Bh2e60eJfLM7F9GTbwcSE1mD3Leyt76Yg@mail.gmail.com>
References: <1365432004-20132-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 20:21:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPGgu-0008Sv-IO
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 20:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935535Ab3DHSVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 14:21:00 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:39862 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762937Ab3DHSU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 14:20:59 -0400
Received: by mail-ie0-f174.google.com with SMTP id aq17so7220549iec.19
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=XCU/03jqWpNUivqwZgaCFboMSKhMZBs0n5x4HOGJ0V8=;
        b=ys4XP68hMOH22oO9tK/jH0k5uwNrY3X8eTuLAzsd3t1QOEOQQ8oQ1maN60a51tN6eX
         YLod++1Ev8sH4qDM4UZBC0JbJgXCl7W1WiFNh3iXrjvC21dmPC+S7k85O8UjpaqiJWEA
         QAb0GP7zh0JhAYM5xyeZRnSn+6xHl0zXYRCc8VWwsZ5NvxtCgQRPbMf8k0u08lmgB06J
         Qn+3ZMNTjmfuQqhpRO1WCGkFlmN8qxkJwzcuIrWo6HKMVqSW2fnwsyVNViCgqSFKS6xk
         PmIMoaxcNPfWP1I6RcR1a6+ikDzNmj9g1khQcbfyeCWjCXP43pGjuB5TPBm3vGpWyqLm
         JNSQ==
X-Received: by 10.50.57.5 with SMTP id e5mr7975385igq.57.1365445255613; Mon,
 08 Apr 2013 11:20:55 -0700 (PDT)
Received: by 10.50.157.229 with HTTP; Mon, 8 Apr 2013 11:20:15 -0700 (PDT)
In-Reply-To: <1365432004-20132-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220481>

On Mon, Apr 8, 2013 at 7:40 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> +               die("Reading from remote helper failed");

Does the user know what a remote helper is? Could we point them at
some helpful docs in case they don't?

--
Cheers,

Sverre Rabbelier
