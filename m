From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Request: timeout option for remote operations, esp. "git fetch"
Date: Thu, 07 Nov 2013 09:07:40 -0800
Message-ID: <527BC8DC.7010108@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 07 18:07:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeT3g-0001Ss-8P
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 18:07:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754552Ab3KGRHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 12:07:49 -0500
Received: from terminus.zytor.com ([198.137.202.10]:42257 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753459Ab3KGRHs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 12:07:48 -0500
Received: from tazenda.hos.anvin.org ([IPv6:2601:9:3340:50:a42d:7aff:febf:9551])
	(authenticated bits=0)
	by mail.zytor.com (8.14.7/8.14.5) with ESMTP id rA7H7jj4032160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Thu, 7 Nov 2013 09:07:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237417>

When a remote server is unavailable or very slow, some git commands can
stall out indefinitely.  It would be a very good thing if remote
commands -- but especially git fetch -- could be given a timeout.

	-hpa
