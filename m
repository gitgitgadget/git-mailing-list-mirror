From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] gitk: simplify file filtering
Date: Mon, 29 Oct 2012 07:46:36 +0100
Message-ID: <508E264C.5080005@viscovery.net>
References: <1351185801-18543-1-git-send-email-felipe.contreras@gmail.com> <1351185801-18543-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 29 07:47:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSj7l-0007hu-KA
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 07:47:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162Ab2J2Gqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 02:46:43 -0400
Received: from so.liwest.at ([212.33.55.24]:19572 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113Ab2J2Gqm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 02:46:42 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TSj7N-0007pV-F2; Mon, 29 Oct 2012 07:46:37 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 1E0351660F;
	Mon, 29 Oct 2012 07:46:37 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <1351185801-18543-2-git-send-email-felipe.contreras@gmail.com>
X-Enigmail-Version: 1.4.5
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208592>

Am 10/25/2012 19:23, schrieb Felipe Contreras:
> git diff is perfectly able to do this with '-- files', no need for
> manual filtering.

It would have been very useful if you summarized what the code did before
this change.

As for the change itself, it seems to make sense to use git diff's path
limiting instead of some home-grown method.

-- Hannes
