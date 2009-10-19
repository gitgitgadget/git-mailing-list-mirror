From: Nasser Grainawi <nasser@codeaurora.org>
Subject: Re: git-pack-objects gitattributes?
Date: Mon, 19 Oct 2009 12:47:51 -0600
Organization: Code Aurora Forum
Message-ID: <4ADCB457.8050601@codeaurora.org>
References: <4AD3B4F8.6030007@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Oct 19 20:48:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzxGx-0003nl-Hw
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 20:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756366AbZJSSrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 14:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756012AbZJSSrt
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 14:47:49 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:10042 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbZJSSrt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 14:47:49 -0400
X-IronPort-AV: E=McAfee;i="5300,2777,5776"; a="25596246"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 19 Oct 2009 11:47:53 -0700
Received: from [129.46.10.111] (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id A63A510004C8
	for <git@vger.kernel.org>; Mon, 19 Oct 2009 11:51:10 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <4AD3B4F8.6030007@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130725>

Nasser Grainawi wrote:
> Hello,
> 
> I'm trying to avoid doing delta compression on a number of large binary 
> files. I got a suggestion to use $GIT_DIR/info/attributes and a line 
> like this:
> *.bin -delta
> 
> This doesn't seem to show a big improvement (and honestly I can't find 
> where in the git-pack-objects source the value of this attribute is used).
> 
> Could someone shed some light on this attribute and any other 
> improvements I could make for efficiently serving up a repo over 
> git-daemon with near-weekly revisions of 100MB+ files?
> 
> Thanks,
> Nasser

ping? any help? anyone?
