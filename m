From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] gitk: handle --full-diff correctly
Date: Mon, 29 Oct 2012 07:52:25 +0100
Message-ID: <508E27A9.60105@viscovery.net>
References: <1351185801-18543-1-git-send-email-felipe.contreras@gmail.com> <1351185801-18543-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 29 07:52:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSjDD-0004gA-8g
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 07:52:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682Ab2J2Gw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 02:52:27 -0400
Received: from so.liwest.at ([212.33.55.24]:16513 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113Ab2J2Gw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 02:52:26 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TSjCz-0000Ws-Va; Mon, 29 Oct 2012 07:52:26 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id B27FF1660F;
	Mon, 29 Oct 2012 07:52:25 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <1351185801-18543-3-git-send-email-felipe.contreras@gmail.com>
X-Enigmail-Version: 1.4.5
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208593>

Am 10/25/2012 19:23, schrieb Felipe Contreras:
> Otherwise the files are missing from the diff, and the list of files.
> 
> We do this by creating a limitdiffs variable specific for the view which
> can be turned of by using --full-diff.

It would be very helpful if you described the problem. "Try it yourself"
is not the answer. In particular, what does "correctly" mean in this
context? Isn't the subject more like "gitk: handle --full-diff" in the
sense that it wasn't handled at all previously and it did what it happened
to do?

The patch breaks gitk's builtin "limit to listed paths" option - with the
patch, the option is only honored at startup, but not when it is changed
during the session when --full-diff is not given. Don't know what should
happen if it is given.

-- Hannes
