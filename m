From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v9 4/7] git-reflog: add exists command
Date: Tue, 21 Jul 2015 12:51:10 -0700
Message-ID: <55AEA2AE.10600@alum.mit.edu>
References: <1437493504-3699-1-git-send-email-dturner@twopensource.com> <1437493504-3699-5-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 21 21:51:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHdZP-0007Hu-CL
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 21:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753805AbbGUTvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 15:51:15 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:56068 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752207AbbGUTvO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jul 2015 15:51:14 -0400
X-AuditID: 12074411-f797e6d000007df3-da-55aea2afe143
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id EE.C5.32243.FA2AEA55; Tue, 21 Jul 2015 15:51:12 -0400 (EDT)
Received: from [172.20.208.234] ([66.251.117.141])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t6LJpAFv027191
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 21 Jul 2015 15:51:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1437493504-3699-5-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42IRYndR1N2waF2owbXLTBbzN51gtOi60s3k
	wOSx4Pl9do/Pm+QCmKK4bZISS8qCM9Pz9O0SuDN635QU9DFX/PvRwNzAeIipi5GTQ0LARGLD
	h4/sELaYxIV769m6GLk4hAQuM0pcmXeaBcLZxCTRv/sFK0gVr4CmxJzNLYwgNouAqsT/9z1g
	k9gEdCUW9TQD2RwcogJBEq9f5kKUC0qcnPmEBcQWEXCQuLzrKDOILSxgJXH461JGiPnNjBIb
	76wGm8kp4CHx5ftVsIuYBfQkdlz/xQphy0tsfzuHeQIj/ywkc2chKZuFpGwBI/MqRrnEnNJc
	3dzEzJzi1GTd4uTEvLzUIl1TvdzMEr3UlNJNjJCAFNzBOOOk3CFGAQ5GJR7eC21rQ4VYE8uK
	K3MPMUpyMCmJ8sYvXBcqxJeUn1KZkVicEV9UmpNafIhRgoNZSYT3RCRQjjclsbIqtSgfJiXN
	waIkzsu3RN1PSCA9sSQ1OzW1ILUIJivDwaEkwbsTZKhgUWp6akVaZk4JQpqJgxNkOJeUSHFq
	XkpqUWJpSUY8KCLji4ExCZLiAdr7EaSdt7ggMRcoCtF6ilGXY8GP22uZhFjy8vNSpcR5d4AU
	CYAUZZTmwa2ApZ9XjOJAHwvzNoFU8QBTF9ykV0BLmICW3Jq1BmRJSSJCSqqB0S7W/LXqjhnK
	TdZrLxwWinq966/dt91TGHqe79XYtvyhQe6UPTcmvV3vl/cnq4jfL9791zORlCx+rvP6qxa+
	X5irb9B7/LBDN7vD9XuCUyfkiv3RixJ3uNOm1xzc/ffJiZQIp91vFYs+HZzO1Gcj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274408>

On 07/21/2015 08:45 AM, David Turner wrote:
> Theis are necessary because alternate ref backends might store reflogs

s/Theis are/This is/

> somewhere other than .git/logs.  Code that now directly manipulates
> .git/logs should instead go through git-reflog.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
