From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Use warning function instead of fprintf(stderr, "Warning:
 ...").
Date: Mon, 04 Jan 2010 17:02:48 +0100
Message-ID: <4B421128.5040807@kdbg.org>
References: <1262463886-8956-1-git-send-email-tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 17:03:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRpOo-0003Lh-IO
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 17:03:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420Ab0ADQDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 11:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753354Ab0ADQDN
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 11:03:13 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:17471 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753094Ab0ADQDN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 11:03:13 -0500
Received: from [77.117.74.72] (77.117.74.72.wireless.dyn.drei.com [77.117.74.72])
	by bsmtp.bon.at (Postfix) with ESMTP id 9457BCDF99;
	Mon,  4 Jan 2010 17:03:10 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1262463886-8956-1-git-send-email-tfransosi@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136122>

Did you actually test any of the changed warnings? You should see extra 
empty lines because warning() adds its own LF and you didn't remove any.

-- Hannes
