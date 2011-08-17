From: viresh kumar <viresh.kumar@st.com>
Subject: Issue: Mails sent twice if patch is mentioned twice while sending
 mail.
Date: Wed, 17 Aug 2011 11:41:41 +0530
Message-ID: <4E4B5B9D.1070901@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Shiraz HASHIM <shiraz.hashim@st.com>,
	Vipin KUMAR <vipin.kumar@st.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 17 08:11:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtZM2-00048N-ID
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 08:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624Ab1HQGLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 02:11:49 -0400
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:42568 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750813Ab1HQGLt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Aug 2011 02:11:49 -0400
Received: from beta.dmz-ap.st.com ([138.198.100.35]) (using TLSv1) by eu1sys200aob105.postini.com ([207.126.147.11]) with SMTP
	ID DSNKTktbouI30P0qLhomT5WAcqbLB2S6+QRK@postini.com; Wed, 17 Aug 2011 06:11:48 UTC
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 30F7E11C
	for <git@vger.kernel.org>; Wed, 17 Aug 2011 06:11:43 +0000 (GMT)
Received: from Webmail-ap.st.com (eapex1hubcas1.st.com [10.80.176.8])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D1845393
	for <git@vger.kernel.org>; Wed, 17 Aug 2011 06:11:43 +0000 (GMT)
Received: from [10.199.16.92] (10.199.16.92) by Webmail-ap.st.com
 (10.80.176.7) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 17 Aug 2011
 14:11:43 +0800
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.12) Gecko/20101027 Lightning/1.0b2 Thunderbird/3.1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179502>

Hello,

I found something which look wrong to me, but may not be wrong.
Suppose if we do:

git send-email --to=abc@xyz.com 0001-xyz.patch 0001-xyz.patch

What should be the desired behavior of this command, Should we get
mail only once or twice?

Currently we are getting it twice.

-- 
viresh
