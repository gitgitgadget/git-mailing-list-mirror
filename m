From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/5] rebase: fix sequence continuation
Date: Wed, 29 May 2013 00:53:45 -0500
Message-ID: <51a597e95039e_7242869e1c713f5@nysa.mail>
References: <1369747757-10192-1-git-send-email-felipe.contreras@gmail.com>
 <1369747757-10192-4-git-send-email-felipe.contreras@gmail.com>
 <7v4ndmybwl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Martin von Zweigbergk <martinvonz@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 07:56:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhZMt-000863-V3
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 07:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754588Ab3E2F4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 01:56:11 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:48031 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117Ab3E2F4L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 01:56:11 -0400
Received: by mail-ob0-f178.google.com with SMTP id fb19so2844901obc.9
        for <git@vger.kernel.org>; Tue, 28 May 2013 22:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=lyKvn9GujwOJcAuEvMJYb+bbU9FN+KPUXKWAUUxASOA=;
        b=ZUQX92NZ4cpdavxk3/g0usCDFCnlESnU9elmNebxEwA894apXMgzjCAnSc6ZUIJQrl
         V4+GZLGItk7VCTC+6egs8zmJ2zuYS1WmCiEtPYwODUXkd0ImdeRy/5swpoFTBx48/Z3/
         p36zOllhyJk2r3LTfN2fmSndoLkf0BP6GZAH2HUkfI+JP56uOfxW5yBjbHk5GPm+kNUg
         Qjo/0mGRMqkoC2aiXniZ+nr7FNom9o09x5s88cK4ri2kVatDh1iv/yZbq2wXxc0wa8Yc
         cHZcsSIUiBjK2ULvQG32uPUAKXWQ6oah5d8BEIHEwOoAX7xWR5EkPq0sBQ0Q9uzRD0jQ
         eaJQ==
X-Received: by 10.60.155.177 with SMTP id vx17mr766061oeb.9.1369806970391;
        Tue, 28 May 2013 22:56:10 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id pm16sm39618512oeb.3.2013.05.28.22.56.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 22:56:09 -0700 (PDT)
In-Reply-To: <7v4ndmybwl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225746>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > We are not in am mode.
> 
> That may make sense, but shouldn't this part be like so from the
> very beginning?  In other words, this looks like an "oops, 1/5 was
> buggy and this is a hotfix".

How can 1/5 be introducing a bug? It's merely splitting the code without
introducing *ANY* functional changes.

The bug is already there in 'master'.

-- 
Felipe Contreras
