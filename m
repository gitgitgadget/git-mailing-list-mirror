From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.0.0-rc4
Date: Wed, 21 May 2014 22:45:53 -0500
Message-ID: <537d72f16f11f_1bf76cb308f3@nysa.notmuch>
References: <xmqqr43oq8q5.fsf@gitster.dls.corp.google.com>
 <537bf50f27417_353e13c330846@nysa.notmuch>
 <xmqqa9abqczg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: linux-kernel-owner@vger.kernel.org Thu May 22 05:57:29 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1WnK8G-0007mj-OR
	for glk-linux-kernel-3@plane.gmane.org; Thu, 22 May 2014 05:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221AbaEVD5M (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 21 May 2014 23:57:12 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:57785 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbaEVD5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2014 23:57:10 -0400
Received: by mail-oa0-f41.google.com with SMTP id m1so3361163oag.28
        for <multiple recipients>; Wed, 21 May 2014 20:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=yEmvh/Kc9WnmQcfF6dgkpTFPp75nS5de7DpR7bUiYIY=;
        b=hV2vo6+vL/gpA0tm7tiHIgRAePdkLqtk3Gvk33z4OqUMUrsx5laRettcf0uG9e7pDG
         slcGj4RPtDAkPUWAn8423F70jkceSeV4kRN10FZutZ4emWItrQNlpcRPm7eQfRbPt+AH
         iwhlUvHI+oF/W6ElSBhNBgbeDeEBeiC1svLTu2Lh6C9YmJFmTs80zRiZN7EndP2rdX36
         KDotqPFH1VgrBFbzcLFdHx7wPcSaiHfFo2mMAIQ7xTb8fa2D6Z+L0mld88qW+J9JDtzl
         nmxCccDfeKZEV3xUrRzc14sJJ5iUohUkoVoOstSviQdoLTNUWVeSpi29CGVXGqUxFMRL
         eTQQ==
X-Received: by 10.60.149.233 with SMTP id ud9mr28545237oeb.66.1400731029662;
        Wed, 21 May 2014 20:57:09 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id c7sm3649052obq.25.2014.05.21.20.57.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 May 2014 20:57:08 -0700 (PDT)
In-Reply-To: <xmqqa9abqczg.fsf@gitster.dls.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249872>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Junio C Hamano wrote:
> >
> >>  * The remote-helper interface to fast-import/fast-export via the
> >>    transport-helper has been tightened to avoid leaving the import
> >>    marks file from a failed/crashed run, as such a file that is out-of-
> >>    sync with reality confuses a later invocation of itself.
> >
> > Really? Where are the patches for that?
> >
> > I think it's fair to say the way the remote-helpers and transport-helper
> > has been handled for v2.0 has been a total disaster.
> 
> Thanks for noticing.  The last-minute change of plans in the morning
> on the -rc release day did not help.  Will remove.

But this changed before that.

> Anything else I missed?

Not as far as I can see.

-- 
Felipe Contreras
