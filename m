From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/12] t4150: am.messageid really adds the message id
Date: Mon, 06 Jul 2015 10:38:13 -0700
Message-ID: <xmqqoajp1916.fsf@gitster.dls.corp.google.com>
References: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
	<1435861000-25278-2-git-send-email-pyokagan@gmail.com>
	<559585BC.4060601@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 19:38:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCALV-0003HX-A4
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbbGFRiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:38:17 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35432 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbbGFRiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:38:16 -0400
Received: by igcqs7 with SMTP id qs7so15251159igc.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=j0hl5jtgFyMrv3IJv3Q9jc1N1l7M5898qoAo5BvblBM=;
        b=ZRZDdo0V9qLk9sY6cOhI2NsQvtSnKMXlTdh4jtg32OIu/QnDA/YpuaQDMkpaznDg0d
         PH3w9RVcbWlvyGPa6Xr47OnTgvL/FPHivAmpij7T5c+85xmWo4hgFeCOlfk3vK1NAalX
         dwPsjJ4Nv8KW5y8/5oLR2rQnsi6bMsIdvtc2zYpDs6hFCz6Y4573heGZTdlStaeH0LtG
         dw4L/LP2zWuoyo2bLILrwmOeuvKu/Yeu/GFaJnLjbHCJf312tnc5A7nVMKJ8aDHj4FD4
         BMx69jhLuWWhjYEfG2S8TmbRHO3C0T5bUkuVU5IKxBTQERYfbOnEfczAe6qt4jjiUl2C
         0uXA==
X-Received: by 10.50.114.5 with SMTP id jc5mr43656310igb.43.1436204295784;
        Mon, 06 Jul 2015 10:38:15 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ad70:2147:d1ba:ffd8])
        by mx.google.com with ESMTPSA id p8sm10093694iga.13.2015.07.06.10.38.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 10:38:15 -0700 (PDT)
In-Reply-To: <559585BC.4060601@redhat.com> (Paolo Bonzini's message of "Thu, 2
	Jul 2015 20:41:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273439>

Thanks, both.
