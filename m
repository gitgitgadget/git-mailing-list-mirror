From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Request: git fetch --timeout
Date: Thu, 01 Nov 2012 14:59:30 -0700
Message-ID: <5092F0C2.1090802@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 22:59:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TU2nm-0007vn-CU
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 22:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992489Ab2KAV7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 17:59:37 -0400
Received: from terminus.zytor.com ([198.137.202.10]:48343 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936106Ab2KAV7g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 17:59:36 -0400
Received: from anacreon.sc.intel.com ([134.134.139.76])
	(authenticated bits=0)
	by mail.zytor.com (8.14.5/8.14.5) with ESMTP id qA1LxZx8024092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Thu, 1 Nov 2012 14:59:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
X-Enigmail-Version: 1.4.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208892>

Right now, there are events which can cause git fetch to hang forever.
This is really problematic in automatic use.

A git fetch --timeout which would exit with a nonzero exit code if no
forward progress is made would be really helpful.

	-hpa
