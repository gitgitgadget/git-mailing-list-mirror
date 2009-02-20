From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [tig PATCH] add missing NULL in blame_grep
Date: Fri, 20 Feb 2009 15:36:15 +0100
Message-ID: <2c6b72b30902200636xea24fdbs835f683aedab7a6e@mail.gmail.com>
References: <20090220032343.GA25022@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 20 15:43:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaWb3-0006xX-Px
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 15:43:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbZBTOls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 09:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbZBTOls
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 09:41:48 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:59934 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbZBTOlr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 09:41:47 -0500
Received: by bwz5 with SMTP id 5so2603679bwz.13
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 06:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=SMlfKD35Plu0mJmWn3jsbGadzJXsEPfe2yHh2vHaaWY=;
        b=hQDBohOqUmheAPYaXaLGBN2hDFuDstI8sCNnQfEDVdifmVg9bx1CYvPFyRs7DacGJC
         uCFpw1pzjejoTAA2C6ldl2/6HugpEEjLFEJSppIMeFFgzEtO5t7esmDUZlXu4AaQKO0b
         VXt4abPn0/vcTh6Fpr45LV58rsH+zTA629byU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=i2d263lz/d24ARc6+sUz48jXxmg1o8EKOYHLt104Cl0UoG51ipYfQLtjAL/nBBDEWY
         AvjEfkAJLkyQCwhAdmflDMymki+arSS9jtBvPeA0qboOWxCRpqS5F9+knQA2C9Cjq/tp
         mcvhxDLkrumXz6BGMJpGzDkouaEi/18NbgZWI=
Received: by 10.181.61.7 with SMTP id o7mr302085bkk.85.1235140575174; Fri, 20 
	Feb 2009 06:36:15 -0800 (PST)
In-Reply-To: <20090220032343.GA25022@coredump.intra.peff.net>
X-Google-Sender-Auth: fca31851d5e93c34
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110849>

On Fri, Feb 20, 2009 at 04:23, Jeff King <peff@peff.net> wrote:
> Commit 436674f introduced a grep_text utility function which
> takes a NULL-terminated list; the callsite in blame_grep
> forgot to put in a NULL, leading to segmentation faults.

Thanks for bailing me out yet again. :)

-- 
Jonas Fonseca
