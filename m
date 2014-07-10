From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gitignore: add .version as this is generated during a
 make
Date: Thu, 10 Jul 2014 16:13:34 -0700
Message-ID: <20140710231334.GE12427@google.com>
References: <1405032485-26117-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 01:13:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5NX3-0005VG-Fp
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 01:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbaGJXNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 19:13:38 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:64129 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbaGJXNh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 19:13:37 -0400
Received: by mail-pd0-f179.google.com with SMTP id w10so314310pde.38
        for <git@vger.kernel.org>; Thu, 10 Jul 2014 16:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=L/deSHGtzJv+pj/nRDkOcEqrTOO6YK9d+3m2NPXiI2Q=;
        b=ax+woBCsWEixG/saG3u/QbvXioXgWu/dr5iuGNUyUOpy6f4NQebSLKcGRKRGwt/tKv
         kjMsw719stP9V1+ARfrSv/pI1d7n7VHq2f+e38OVY8qjl2UHK5qzMe8ijcRShPs0O9yz
         TfyJUSnEcol6kHyfT0PsijIbWWFq/2WZsvAJyXvqYlhgJzGeXoyc+nLLnuPWrZKQmawo
         TuVUbVn3+ephVUcItAMIFPP5s9NMGCjmfHyYkAE3KgWgYxlLAM7tjrQLALD6q4aQMgRc
         Wo2J4L68IRGbSQ1oaGDO4TG29+jT3Ui+0/ZQmIj7JwocwWGsYs3OecA9dSYWVx0Kv0Hx
         E2wg==
X-Received: by 10.68.130.6 with SMTP id oa6mr49975488pbb.102.1405034017017;
        Thu, 10 Jul 2014 16:13:37 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:5c9f:79c0:7861:b689])
        by mx.google.com with ESMTPSA id nj8sm330705pbc.39.2014.07.10.16.13.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 10 Jul 2014 16:13:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1405032485-26117-1-git-send-email-jacob.e.keller@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253230>

Hi,

Jacob Keller wrote:

> Subject: gitignore: add .version as this is generated during a make

What program generates that file?  When I build on a Debian machine, I
get

	$ make
	[...]
	    SUBDIR templates
	$ ls -la .version
	ls: cannot access .version: No such file or directory

Curious,
Jonathan
