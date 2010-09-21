From: Kevin Ballard <kevin@sb.org>
Subject: Re: Shouldn't git fetch also fetch the tags?
Date: Mon, 20 Sep 2010 18:03:25 -0700
Message-ID: <4A6D7554-6CDD-4A92-9E90-27CF555A44CF@sb.org>
References: <AANLkTinb=g=Y=s9AqPtLEOqMxPJVqFxRa_2cB4=iNZ4k@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 03:03:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxrGg-0003Qo-TE
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 03:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301Ab0IUBD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 21:03:29 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:34514 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447Ab0IUBD2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 21:03:28 -0400
Received: by pxi10 with SMTP id 10so1294858pxi.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 18:03:28 -0700 (PDT)
Received: by 10.142.216.2 with SMTP id o2mr8437020wfg.142.1285031008459;
        Mon, 20 Sep 2010 18:03:28 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id o9sm7763184wfd.4.2010.09.20.18.03.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 18:03:27 -0700 (PDT)
In-Reply-To: <AANLkTinb=g=Y=s9AqPtLEOqMxPJVqFxRa_2cB4=iNZ4k@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156682>

`git fetch` will fetch any tags that are reachable from any refs that were fetched. It will not fetch tags that are not otherwise reachable. `git fetch --tags` explicitly instructs git fetch to fetch all tags.

-Kevin Ballard

On Sep 20, 2010, at 4:00 PM, Felipe Contreras wrote:

> Hi,
> 
> Usually when I do 'git fetch' the tags are fetched too, however, there
> is one repo:
> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.35.y
> 
> Where it doesn't happen, and I manually have to 'git fetch --tags'.
> 
> What's going on?
> 
> -- 
> Felipe Contreras
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
