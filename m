From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [WITHDRAWN PATCH 1/2] Add --topo-order flag to git-rev-list
Date: Sat, 2 Jul 2005 17:56:01 +1000
Message-ID: <2cfc4032050702005656b389e@mail.gmail.com>
References: <20050702060936.13011.qmail@blackcubes.dyndns.org>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: torvalds@osdl.org, jon.seymour@gmail.com,
	Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Jul 02 09:48:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Docjl-0008C2-U5
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 09:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVGBH4D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 03:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVGBH4D
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 03:56:03 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:51092 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261474AbVGBH4B convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Jul 2005 03:56:01 -0400
Received: by rproxy.gmail.com with SMTP id i8so352379rne
        for <git@vger.kernel.org>; Sat, 02 Jul 2005 00:56:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O1ABrCrhpr/Wd2RGoodwkNcfbX38NWL+GqOT3VQjFdFeDz9Im2p5D06AaPgswdg7gDEHnlZHAFj6AqsSUDbpC6Pm+/SxWa3siNsbHAlhM+Ab+33P4L9cXTWJFqdLchL/+gqj2NnpMJV7WGUX7jT2G24NSL0GIL0je0e6mDGrLFc=
Received: by 10.38.65.5 with SMTP id n5mr1411274rna;
        Sat, 02 Jul 2005 00:56:01 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Sat, 2 Jul 2005 00:56:01 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <20050702060936.13011.qmail@blackcubes.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Actually, I need to withdraw this patch.

The way show_commit_list works defeats the approach I was using to
perform a topological sort - since show_commit_list does more than
show the list, it also performs a chronological sort on the list,
thereby undoing the topological sort that is attempted.

jon.
