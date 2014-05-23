From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Get rid of the non portable shell export VAR=VALUE
 costruct
Date: Fri, 23 May 2014 09:18:23 -0700
Message-ID: <20140523161823.GB4065@google.com>
References: <1400840131-966-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, tboegi@web.de, dak@gnu.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 23 18:18:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnsAw-0002Pr-HK
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 18:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399AbaEWQS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 12:18:27 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:40746 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162AbaEWQS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 12:18:26 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so4293802pab.36
        for <git@vger.kernel.org>; Fri, 23 May 2014 09:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fik1TgzOAyAGTaRsEhCLgYJ7iojFuxeHQSYY9CGdQRE=;
        b=aTNM96DHWZYUVqzNByin7LvtEijKjQ+pz2e1BU0iBV5FnCLM0GCTc8fx9ZH/MBNWV+
         o3y78kfPckZ2GowdI0d6mF6Edh9Uh1hovTYwpeXSmcMIjhahj1dj16zXtJlKtIRRsBUv
         tYfTc5mxg4rsgEdsqJY0HjIrnAiLm8X9xugyeUwcJGrUBh/qTTzBVA3H6/whW/R91N51
         Rdn6SL8E+Pmydi7Ce7pLBleKRdmo/8mZTiEMtdUuWvzRtgVALbdc3tCJrZU2ILFE+HOG
         4eWCcc5iWdJBTw3KMgudHbnWIba7dKkhjBFuTbtczFWg+GzIS9/qHgFgh/zi629zOVms
         ugzg==
X-Received: by 10.68.213.97 with SMTP id nr1mr7286209pbc.52.1400861906044;
        Fri, 23 May 2014 09:18:26 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ie9sm16132495pad.29.2014.05.23.09.18.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 23 May 2014 09:18:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400840131-966-1-git-send-email-gitter.spiros@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249995>

Elia Pinto wrote:

> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  contrib/subtree/t/t7900-subtree.sh |    3 ++-
>  git-remote-testgit.sh              |    3 ++-
>  git-stash.sh                       |    3 ++-
>  3 files changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
