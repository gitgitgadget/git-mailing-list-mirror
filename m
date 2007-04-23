From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Ignore section 5 man pages
Date: Mon, 23 Apr 2007 16:54:27 -0700
Message-ID: <462D4733.3000901@zytor.com>
References: <20070423235003.GA29849@Hermes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 01:54:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg8Mc-0003k8-H3
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 01:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbXDWXyc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 19:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbXDWXyb
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 19:54:31 -0400
Received: from terminus.zytor.com ([192.83.249.54]:51312 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030202AbXDWXyb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 19:54:31 -0400
Received: from [172.27.0.16] (c-67-169-144-158.hsd1.ca.comcast.net [67.169.144.158])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l3NNsRXA013892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Apr 2007 16:54:28 -0700
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
In-Reply-To: <20070423235003.GA29849@Hermes.local>
X-Virus-Scanned: ClamAV 0.88.7/3152/Mon Apr 23 15:34:59 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=2.0 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_96_XX,RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no
	version=3.1.8
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.1.8 (2007-02-13) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45382>

Brian Gernhardt wrote:
> We now have a gitattributes(5) file, so let git ignore that just like
> all the other man pages.
> 
> Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
> ---
> 
>  Documentation/.gitignore |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/.gitignore b/Documentation/.gitignore
> index b98d21e..d067481 100644
> --- a/Documentation/.gitignore
> +++ b/Documentation/.gitignore
> @@ -1,6 +1,7 @@
>  *.xml
>  *.html
>  *.1
> +*.5
>  *.7
>  *.made
>  howto-index.txt

We can't just add *.[1-8] to the list?

	-hpa
