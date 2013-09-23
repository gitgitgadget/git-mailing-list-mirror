From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH 0/9] transport-helper: updates
Date: Sun, 22 Sep 2013 21:49:40 -0400
Message-ID: <523F9E34.8030805@bbn.com>
References: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 23 03:49:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNvHX-0004Wb-QE
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 03:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753137Ab3IWBtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Sep 2013 21:49:43 -0400
Received: from smtp.bbn.com ([128.33.0.80]:21555 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753051Ab3IWBtn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Sep 2013 21:49:43 -0400
Received: from socket.bbn.com ([192.1.120.102]:55881)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VNvHS-0005rA-1V; Sun, 22 Sep 2013 21:49:42 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 7F9E93FF4D
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235176>

On 2013-08-29 11:23, Felipe Contreras wrote:
> Here are the patches that allow transport helpers to be completely transparent;
> renaming branches, deleting them, custom refspecs, --force, --dry-run,
> reporting forced update, everything works.

What is the status of these patches?

I would like to be able to 'git push old:new' and 'git push -f' to a
bzr repo, and these are a prerequisite.  I imagine changes to
git-remote-bzr will also be required; I'm willing write up such
changes to git-remote-bzr, but only if there's interest in picking up
this patch series.

Thanks,
Richard
