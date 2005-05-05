From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Please rename cg-X* to something else
Date: Thu, 05 May 2005 15:31:39 -0700
Message-ID: <427A9ECB.8070409@zytor.com>
References: <1115329026.3838.8.camel@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 06 00:26:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTomw-0005QY-6a
	for gcvg-git@gmane.org; Fri, 06 May 2005 00:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbVEEWcI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 18:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVEEWcI
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 18:32:08 -0400
Received: from terminus.zytor.com ([209.128.68.124]:11234 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262099AbVEEWb4
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 5 May 2005 18:31:56 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j45MViM0032595
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 5 May 2005 15:31:44 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1115329026.3838.8.camel@dv.roinet.com>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Pavel Roskin wrote:
> Hello!
> 
> Since cg-X* scripts are not supposed to be used by the end users, I
> suggest that we rename them so something not starting with "cg-" or even
> "cg" so that tab completion in bash doesn't show them.  I suggest "_cgX"
> instead of "cg-X"
> 
> In the long term, the internal scripts should go to
> $prefix/share/cogito, but it would require generating other scripts from
> templates to substitute $prefix, which could be inconvenient at this
> stage.
> 

$prefix/libexec/cogito rather...

Pattern-substituting in bulk isn't really very hard.

	-hpa
