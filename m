From: "H. Peter Anvin" <hpa@zytor.com>
Subject: git am and the wrong chunk of ---
Date: Thu, 09 Aug 2012 17:13:51 -0700
Message-ID: <5024523F.3050208@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 02:13:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzcrW-00005K-1X
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 02:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760046Ab2HJANx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 20:13:53 -0400
Received: from terminus.zytor.com ([198.137.202.10]:44567 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755412Ab2HJANw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 20:13:52 -0400
Received: from tazenda.hos.anvin.org (c-67-188-81-177.hsd1.ca.comcast.net [67.188.81.177])
	(authenticated bits=0)
	by mail.zytor.com (8.14.5/8.14.5) with ESMTP id q7A0DpJ7024700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=OK);
	Thu, 9 Aug 2012 17:13:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203193>

Hello,

I have some contributors who consistently put their commentary *before* 
the "---" line rather than *after* it, presumably with the notion that 
it is some kind of "cover text".  This messes with "git am", and so I 
end up having to edit those posts manually.

I have tried git am --scissors and it doesn't seem to solve the problem.

Is there any other option which can be used to automatically process 
such a patch?

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
