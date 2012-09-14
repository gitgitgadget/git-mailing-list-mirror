From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: [PATCH] test-generation: compute generation numbers and clock
 skews
Date: Fri, 14 Sep 2012 23:55:57 +0200
Message-ID: <5053A7ED.9080403@elegosoft.com>
References: <7vtxvece1p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 00:06:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCe2H-0000d9-CV
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 00:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754427Ab2INWGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 18:06:44 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:58571 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752814Ab2INWGn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 18:06:43 -0400
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Sep 2012 18:06:43 EDT
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 6BF53DE8A9;
	Fri, 14 Sep 2012 23:59:30 +0200 (CEST)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XcEmFUUsOZuR; Fri, 14 Sep 2012 23:59:30 +0200 (CEST)
Received: from [192.168.1.3] (p5DD153D4.dip.t-dialin.net [93.209.83.212])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 4BE72DE8A7;
	Fri, 14 Sep 2012 23:59:30 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120828 Thunderbird/15.0
In-Reply-To: <7vtxvece1p.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205537>

main() is missing a return here:
test-generation.c:105:1: warning: control reaches end of non-void function [-Wreturn-type]
