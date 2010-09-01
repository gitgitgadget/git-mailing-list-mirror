From: viresh kumar <viresh.kumar@st.com>
Subject: Re: git send-email doesn't take To: addresses from the patch
Date: Wed, 1 Sep 2010 14:26:23 +0530
Message-ID: <4C7E1537.9030405@st.com>
References: <4C7B5853.7010001@st.com> <4C7E05B5.1050805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 10:56:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqj7W-0004Pr-9Q
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 10:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740Ab0IAI4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 04:56:32 -0400
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:39581 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752077Ab0IAI4c (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Sep 2010 04:56:32 -0400
Received: from source ([138.198.100.35]) (using TLSv1) by eu1sys200aob119.postini.com ([207.126.147.11]) with SMTP
	ID DSNKTH4VPGZZyQMLYKN1mGJlquvF9WzcQwg8@postini.com; Wed, 01 Sep 2010 08:56:31 UTC
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 941B1135;
	Wed,  1 Sep 2010 08:56:25 +0000 (GMT)
Received: from Webmail-ap.st.com (eapex1hubcas4.st.com [10.80.176.69])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 849BA878;
	Wed,  1 Sep 2010 08:56:25 +0000 (GMT)
Received: from [10.199.82.92] (10.199.82.92) by Webmail-ap.st.com
 (10.80.176.7) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 1 Sep 2010
 16:56:25 +0800
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <4C7E05B5.1050805@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155025>

On 9/1/2010 1:20 PM, Stephen Boyd wrote:
> Subject: [PATCH] send-email: Use To: headers in patch files
> 
> It's a minor annoyance when you take the painstaking time to setup To:
> headers for each patch in a large series, and then go out to send the
> series with git-send-email and watch git ignore the To: headers in the
> patch files.
> 
> Therefore, always add To: headers from a patch file to the To: headers
> for that message. Keep the prompt for the blanket To: header so as to
> not break scripts (and user expectations). This means even if a patch has a
> To: header, git will prompt for the To: address. Otherwise, we'll need to
> introduce interface breakage to either request the header for each patch
> missing a To: header or default the header to whatever To: address is found
> first (be it in a patch or from user input). Both of these options don't seem
> very obvious/useful.
> 
> Reported-by: viresh kumar<viresh.kumar@st.com>
> Signed-off-by: Stephen Boyd<bebarino@gmail.com>

Tested-by: Viresh Kumar <viresh.kumar@st.com>
