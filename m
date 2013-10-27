From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH v3 00/10] transport-helper: updates
Date: Sun, 27 Oct 2013 02:23:45 -0400
Message-ID: <526CB171.5090300@bbn.com>
References: <1381561533-20381-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 27 07:24:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaJli-0006cr-0T
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 07:24:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104Ab3J0GXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 02:23:50 -0400
Received: from smtp.bbn.com ([128.33.0.80]:57327 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993Ab3J0GXt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Oct 2013 02:23:49 -0400
Received: from socket.bbn.com ([192.1.120.102]:57034)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VaJlL-000N9Q-QN; Sun, 27 Oct 2013 02:23:47 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 077014007B
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <1381561533-20381-1-git-send-email-felipe.contreras@gmail.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236777>

On 10/12/2013 03:05 AM, Felipe Contreras wrote:
> Hi,
> 
> Here are the patches that allow transport helpers to be completely transparent;
> renaming branches, deleting them, custom refspecs, --force, --dry-run,
> reporting forced update, everything works.

These patches don't cleanly apply to master anymore; would you be
willing to rebase and post a new version?

I wanted to test these changes via git-remote-bzr on a bzr repository
I'm working on, but unfortunately git-remote-bzr doesn't yet support
force pushes.  I may look into adding force push support to
git-remote-bzr, unless you beat me to it.  :)

In general these patches look good to me and I'd like to see them merged
to master.

Thanks,
Richard
