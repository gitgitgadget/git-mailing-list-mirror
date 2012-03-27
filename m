From: Shiraz Hashim <shiraz.hashim@st.com>
Subject: query: picking dependant commits from a latest tree
Date: Tue, 27 Mar 2012 15:25:05 +0530
Message-ID: <20120327095504.GM1806@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <spear-devel@list.st.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 11:56:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCT8V-0003ju-8X
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 11:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757953Ab2C0J4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 05:56:14 -0400
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:51830 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757944Ab2C0J4N (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2012 05:56:13 -0400
Received: from beta.dmz-ap.st.com ([138.198.100.35]) (using TLSv1) by eu1sys200aob102.postini.com ([207.126.147.11]) with SMTP
	ID DSNKT3GOtrC9pZud+uWNdsUFwnIKsmc7hEHz@postini.com; Tue, 27 Mar 2012 09:56:11 UTC
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2C077DA
	for <git@vger.kernel.org>; Tue, 27 Mar 2012 09:47:38 +0000 (GMT)
Received: from Webmail-ap.st.com (eapex1hubcas1.st.com [10.80.176.8])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3E3D3127C
	for <git@vger.kernel.org>; Tue, 27 Mar 2012 09:56:03 +0000 (GMT)
Received: from localhost (10.199.82.228) by Webmail-ap.st.com (10.80.176.7)
 with Microsoft SMTP Server (TLS) id 8.3.192.1; Tue, 27 Mar 2012 17:55:06
 +0800
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194037>

Hi,

If I try to pick commits from a latest tree for a particular feature
then what is the best way to find out all dependant commits.

So for example for the commit which I want to pick there are 10 other
commits around that file but some affect other files which themselves
have several commits which I must apply.

Is their a way to do this efficiently ?

--
regards
Shiraz
