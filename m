From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 0/2] bisect: add support for bisecting bare
 repositories
Date: Tue, 9 Aug 2011 03:54:37 +0200
Message-ID: <20110809015437.GA29121@elie.gateway.2wire.net>
References: <1312852900-29457-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, chriscool@tuxfamily.org,
	j6t@kdbg.org, jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 09 03:54:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqbWy-0006sV-TQ
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 03:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177Ab1HIByq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 21:54:46 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:46087 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929Ab1HIByp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 21:54:45 -0400
Received: by yie30 with SMTP id 30so1282119yie.19
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 18:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=M6HcJZu0MDZDlF/+tKu7tZ37MHfqnZiMoLjlNyRe0Q4=;
        b=GfeRnHwhxj8zOc9dOmPnk5x+Ox3RM9wwLD1WQ+yFQgUw7tCTSTadihrkiFgqlsbUA8
         JMblI6JxXbqGsANu4XEtanXmUxKKBhPDgfxXH3EYsBYXDf05I7xaCgUqtNrnglFbrDM9
         90Klab5fUtzWJbO6KzTzLS9kJxbSuhz4wOYbY=
Received: by 10.236.125.230 with SMTP id z66mr425306yhh.110.1312854884559;
        Mon, 08 Aug 2011 18:54:44 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-69-68.dsl.chcgil.sbcglobal.net [69.209.69.68])
        by mx.google.com with ESMTPS id c63sm2806505yhe.32.2011.08.08.18.54.42
        (version=SSLv3 cipher=OTHER);
        Mon, 08 Aug 2011 18:54:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1312852900-29457-1-git-send-email-jon.seymour@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179017>

Jon Seymour wrote:

> This extension to js/bisect-no-checkout (currently in pu) adds
> support for bisecting bare repositories.
>
> It does this by relaxing the requirement that git bisect is invoked
> in a repository with a working tree and by defaulting to
> --no-checkout in the case of a bare repository.
>
> Two tests are included to demonstrate this behaviour.

Thanks!  I think the two patches should be squashed, with the above
as commit message.

With or without that change, for what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
