From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2] fix "builtin-*" references to be "builtin/*"
Date: Tue, 18 Jun 2013 11:16:12 -0700
Message-ID: <20130618181612.GC408@google.com>
References: <1371577498-7928-1-git-send-email-hordp@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, phil.hord@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 20:16:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up0S6-0003C4-Bn
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 20:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933174Ab3FRSQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 14:16:18 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:56546 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932253Ab3FRSQR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 14:16:17 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so4243617pab.41
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 11:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Of8KYCdSW0kDRR9FQ5CKu905FbQC+f1Xo0WXLhNFRt0=;
        b=EjLOUWlFsDvqjNjqi5cQr9g2/mLcVI9HCiGIWshQCgtmht7OUoDWtAJ84wRpVZswPv
         wgpwKHJrbKOH/7TXhI3PEUQXreRYgxaGkpNji750xuod52Onbx4P3ZVgVWc4i6yENTq9
         RGASCPnScT5opavauQwIPxjS4+bQJxpHttbyZgFwjBbeIYXQ+5morBA8qroOwmd8K49y
         /ARtzW/huaW6AwTn8/E/Dhel2y3r6qUr9EvdtP7PfLzfnrf72MmeDvHSSxplgT9ZSKWj
         7XHTHVptbYBHqDiuQSp2XwkLeh4zo+VBtHz+JAt2U0davXRlYljHKcpFPhtN3irYxD/r
         DigQ==
X-Received: by 10.66.162.102 with SMTP id xz6mr3295043pab.0.1371579377288;
        Tue, 18 Jun 2013 11:16:17 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id e2sm19302132pbc.23.2013.06.18.11.16.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 11:16:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1371577498-7928-1-git-send-email-hordp@cisco.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228290>

Phil Hord wrote:

> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Yep, still looks good from a quick glance.

Thanks for the quick turnaround.
