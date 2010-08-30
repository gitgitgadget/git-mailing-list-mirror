From: viresh kumar <viresh.kumar@st.com>
Subject: git send-email doesn't take To: addresses from the patch
Date: Mon, 30 Aug 2010 12:35:55 +0530
Message-ID: <4C7B5853.7010001@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 30 09:06:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpyRX-0001I2-Kf
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 09:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801Ab0H3HGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 03:06:04 -0400
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127]:35880 "EHLO
	eu1sys200aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751537Ab0H3HGD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 03:06:03 -0400
Received: from source ([138.198.100.35]) (using TLSv1) by eu1sys200aob109.postini.com ([207.126.147.11]) with SMTP
	ID DSNKTHtYWGVjYtTpKIlp4QnjIs0XwnhN0PhU@postini.com; Mon, 30 Aug 2010 07:06:02 UTC
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8F64DA6
	for <git@vger.kernel.org>; Mon, 30 Aug 2010 07:05:57 +0000 (GMT)
Received: from Webmail-ap.st.com (eapex1hubcas2.st.com [10.80.176.10])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4CE6F53F
	for <git@vger.kernel.org>; Mon, 30 Aug 2010 07:05:57 +0000 (GMT)
Received: from [10.199.82.92] (10.199.82.92) by Webmail-ap.st.com
 (10.80.176.7) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 30 Aug 2010
 15:05:56 +0800
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154771>

Hi,

I am using git-1.7.2 and use following command to generate a patch

$ git format-patch --to abc@xyz.com HEAD^

Now when I use git send-email to send this patch, it is not taking the
To: embedded in the patch as its destination, instead it asks for one
and if not provided it keeps this field empty.
On the other hand git send-email is taking the Cc addresses from
the patch perfectly in to account.

How can I use git send-email to pick To: addresses directly from the
patch.

regards
Viresh Kumar
