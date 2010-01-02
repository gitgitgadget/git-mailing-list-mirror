From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v3 2/3] Smart-http tests: Break test t5560-http-backend
	into pieces
Date: Sat, 2 Jan 2010 12:59:28 -0800
Message-ID: <20100102205928.GM6914@spearce.org>
References: <905315641001021244o522ac092g7fdaaab83a2609e2@mail.gmail.com> <1262465119-96115-2-git-send-email-tarmigan+git@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tarmigan Casebolt <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 02 21:59:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRB4b-0004wG-E0
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 21:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318Ab0ABU7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 15:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752056Ab0ABU7j
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 15:59:39 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:34590 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab0ABU7i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 15:59:38 -0500
Received: by yxe17 with SMTP id 17so12884195yxe.33
        for <git@vger.kernel.org>; Sat, 02 Jan 2010 12:59:38 -0800 (PST)
Received: by 10.150.119.35 with SMTP id r35mr13233897ybc.314.1262465970768;
        Sat, 02 Jan 2010 12:59:30 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm15881370iwn.3.2010.01.02.12.59.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 02 Jan 2010 12:59:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1262465119-96115-2-git-send-email-tarmigan+git@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136051>

Tarmigan Casebolt <tarmigan+git@gmail.com> wrote:
> This should introduce no functional change in the tests or the amount
> of test coverage.
> 
> Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
> ---
>  t/t5560-http-backend.sh          |  147 +-------------------------------------
>  t/t5561-http-backend-noserver.sh |   52 +++++++++++++

These should be reversed.  We'd want to find out the backend doesn't
work by itself before we see it fail under Apache.

Otherwise, Acked-by: Shawn O. Pearce <spearce@spearce.org>

-- 
Shawn.
