From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: add option to disable automatic dependency
 generation
Date: Thu, 17 Nov 2011 23:00:03 -0600
Message-ID: <20111118050003.GB25145@elie.hsd1.il.comcast.net>
References: <CACsJy8BZMDyf4MCiKxPJ5Z+XS+C-MC82SpMFyWgiXmb9xCnScw@mail.gmail.com>
 <20111118034142.GA25228@elie.hsd1.il.comcast.net>
 <CACsJy8A44PFtYrm8NQU+48sVkOe8mjJyO9opO5-TwRtAd-TKsQ@mail.gmail.com>
 <20111118045742.GA25145@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Fredrik Kuivinen <frekui@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 06:00:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRGYl-0002Vq-8Z
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 06:00:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940Ab1KRFAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 00:00:13 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36114 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739Ab1KRFAM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 00:00:12 -0500
Received: by ghbz2 with SMTP id z2so126039ghb.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 21:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=duk8UeFquoySa6nDhWH5eGLD20qjiknMQyPqSKidBi8=;
        b=QlHInB7WPTXpYhxp4k/Vo9Bw78tvnfPmniE24gyS5OdG86wS1XMfUlvJy98ug3OSWs
         NnQlyOgdNec/lscwHCLRZpDM8aZ6rb6zSwRpiV6O6mJV0LsDuJKNUcz+V7tl3blhRY8g
         nNqZAlR2fG3sn1rjPfyDkD+xFl+/yeHI5ojnM=
Received: by 10.236.76.136 with SMTP id b8mr2381559yhe.9.1321592412010;
        Thu, 17 Nov 2011 21:00:12 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id i50sm9382534yhk.11.2011.11.17.21.00.10
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 21:00:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111118045742.GA25145@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185632>

Jonathan Nieder wrote:

>  - If COMPUTE_HEADER_DEPENDENCIES is empty and NO_COMPUTE_... is
>    nonempty, the build uses gcc's on-the-fly dependency generation
>    feature.

Erm.  This should say:

  "- If COMPUTE_HEADER_DEPENDENCIES is nonempty and NO_COMPUTE_... is
     empty,"

Sorry for the noise.
