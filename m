From: Stephen Boyd <sboyd@quicinc.com>
Subject: Re: [BUG/TEST 0/2] bugs with cherry-pick renames
Date: Mon, 4 Mar 2013 10:48:52 -0800
Message-ID: <5134EC94.6010602@quicinc.com>
References: <1360643262-1472-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 04 19:49:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCaRt-00046E-7t
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 19:49:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144Ab3CDSsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Mar 2013 13:48:54 -0500
Received: from sabertooth01.qualcomm.com ([65.197.215.72]:37412 "EHLO
	sabertooth01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758706Ab3CDSsx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Mar 2013 13:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1362422933; x=1393958933;
  h=message-id:date:from:mime-version:to:subject:references:
   in-reply-to:content-transfer-encoding;
  bh=gta5IbVxOx4wH3Z7RIPYK/IiP8k4oXmD2V9ZBdGxgDc=;
  b=HqJLqZjPswz70a33CdaJ2YrbncvvU6/31TN/xlCbwdocZZ/IzXlrOQHc
   9QKMJt3YSqoG+DdYXQQ24d8n7cQLvVcYttKoZjrjLhdR50hOK1O5To42a
   o9lVJr6RcYLKUJwIkMbqTuiTe6eZfsLuwd5ZtKk+1rQENnaYu5wA8a+8y
   Q=;
X-IronPort-AV: E=Sophos;i="4.84,781,1355126400"; 
   d="scan'208";a="27795480"
Received: from ironmsg02-lv.qualcomm.com ([10.47.202.183])
  by sabertooth01.qualcomm.com with ESMTP; 04 Mar 2013 10:48:52 -0800
Received: from nasanexhc08.na.qualcomm.com ([172.30.39.7])
  by ironmsg02-lv.qualcomm.com with ESMTP/TLS/RC4-SHA; 04 Mar 2013 10:48:52 -0800
Received: from [10.46.166.8] (172.30.39.5) by qcmail1.qualcomm.com
 (172.30.39.7) with Microsoft SMTP Server (TLS) id 14.2.318.4; Mon, 4 Mar 2013
 10:48:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <1360643262-1472-1-git-send-email-sboyd@codeaurora.org>
X-Originating-IP: [172.30.39.5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217406>

On 02/11/13 20:27, Stephen Boyd wrote:
> I ran into these bugs the other day and didn't have time to 
> investigate further. So I wrote test cases for them instead.
>
> Stephen Boyd (2):
>   t3501: Expose bug with cherry-pick into dirty trees w/ renames
>   t3501: Expose addinfo_cache error message in cherry-pick
>
>  t/t3501-revert-cherry-pick.sh | 60 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>

Any comments? Anyone else running into these bugs?
