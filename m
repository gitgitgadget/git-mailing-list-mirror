From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v1] Documentation: git-rev-parse: clarify that --git-dir
 does not necessarily show relative paths
Date: Fri, 18 May 2012 04:31:59 -0500
Message-ID: <20120518093159.GA31412@burratino>
References: <20120517182304.GA14367@burratino>
 <1337333004-23164-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 18 11:32:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVJXp-00042q-2u
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 11:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967860Ab2ERJcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 05:32:12 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40988 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967861Ab2ERJcH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 05:32:07 -0400
Received: by yenm10 with SMTP id m10so2615361yen.19
        for <git@vger.kernel.org>; Fri, 18 May 2012 02:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NPlc4dGbWZ/1sXtfiJHrg+/GnFmfJ0ggqQbkA0Jbzl8=;
        b=dFiGOr3EzVXINYdKaznll+df1Ql3N6YBUFStl9w5FNFgITFbkVOUNxIy15B/1lOwGX
         JI8LxLn73g/LkaQr2jL2oUBdlRGzCbuW2m2k+WbcA8FQKIRiX80qmpUCynFd/hoOnxzJ
         26ckLmrwhdTFkWJAKHw/XvtAnmMv5FTyRrTnN7uqP91/dl0eu9etPntOSrMqkHwMlhlB
         xGCRxU3Myk0dCfW2r/iwNrTzwGLGl1MKOYp4ca9Erp5WkodGBORurCbx/SYoFXcHAVPB
         f/oUxG50B5ynKi9ZXJEJwALfgOIGHG7wr+lKPCJgfaIw5SUgOGJWyd96mtLDSRdxWBaV
         ynmQ==
Received: by 10.50.89.198 with SMTP id bq6mr7949736igb.28.1337333526790;
        Fri, 18 May 2012 02:32:06 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ch5sm5379461igb.0.2012.05.18.02.32.05
        (version=SSLv3 cipher=OTHER);
        Fri, 18 May 2012 02:32:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1337333004-23164-1-git-send-email-jon.seymour@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197945>

Jon Seymour wrote:

> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -137,7 +137,8 @@ shown.  If the pattern does not contain a globbing character (`?`,
>  
>  --git-dir::
>  	Show `$GIT_DIR` if defined. Otherwise show the path to
> -	the .git directory, relative to the current directory.
> +	the .git directory. The path shown, when relative, is
> +	relative to the current working directory.
>  +
>  If `$GIT_DIR` is not defined and the current directory
>  is not detected to lie in a git repository or work tree

Thanks for taking care of it.

I suppose I'd have used a subject line like the following for
brevity.

	rev-parse doc: --git-dir does not always show a relative path

For what it's worth, with or without that change,
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
