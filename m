From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: A Basic Git Question About File Tracking
Date: Mon, 3 Oct 2011 20:22:44 -0500
Message-ID: <20111004012244.GB13836@elie>
References: <j6dlhf$dp3$1@dough.gmane.org>
 <20111004011035.GA13836@elie>
 <4E8A5DF0.6040003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jon Forrest <nobozo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 03:22:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAtif-0006TR-LR
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 03:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153Ab1JDBWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 21:22:48 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42103 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108Ab1JDBWs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 21:22:48 -0400
Received: by yxl31 with SMTP id 31so4084531yxl.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 18:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=W1VZDimQnvGAjh10Q0nKp625Pkl0XjN0G9dAr4mdEMs=;
        b=ivpnNJjFolZfZSznFCtttwIcq64T1C04Re4GwnpZPeytob2ZO7wVND1xFO42SmnMYs
         9Xn5Ps4kO7kxuptfnEKIiqSGWwXSS+jPVsNr2DcRcqV0gXgcBfs0HzGfcKD6FqKgdjwO
         /zFpbB5ZcTjUmTfCUb7gHYour/uwEKUkAvsYg=
Received: by 10.236.115.70 with SMTP id d46mr3304190yhh.83.1317691367538;
        Mon, 03 Oct 2011 18:22:47 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id p8sm17776399yhe.17.2011.10.03.18.22.46
        (version=SSLv3 cipher=OTHER);
        Mon, 03 Oct 2011 18:22:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E8A5DF0.6040003@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182722>

Jon Forrest wrote:
> On 10/3/2011 6:10 PM, Jonathan Nieder wrote:

>> "Untracked" means "not in
>> the index", nothing more, nothing less.
>
> But your definition doesn't include files that
> have been committed. In the following trivial case
> in a new git repository
>
> cp /etc/passwd x
> git add x
> git commit -m"fooling around"
>
> is "x" tracked? Your definition says it isn't
> but "git status" makes me think it is.

Yes, "x" is tracked.  Moreover, "x" is in the index.  You can
list files in the index with the "git ls-files -s" command.

Does that help?

> Sorry to be so pedantic.

No problem --- it's good to clarify these things (especially if it
results in finding documentation that should be clarified, too).

Jonathan
