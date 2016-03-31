From: Miklos Vajna <vmiklos@collabora.co.uk>
Subject: Signed-off-by vs Reviewed-by
Date: Thu, 31 Mar 2016 14:35:07 +0200
Message-ID: <20160331123507.GC19857@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 14:35:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1albou-0001Bu-3l
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 14:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756807AbcCaMfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 08:35:15 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47985 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756511AbcCaMfM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 08:35:12 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(Authenticated sender: vmiklos)
	with ESMTPSA id DC927263C1F
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290378>

Hi,

Some projects like LibreOffice don't use Signed-off-by, instead usually
use Gerrit for code review, and reviewers add a Reviewed-by line when
they are OK with a patch.  In this workflow it's a bit unfortunate that
adding a Signed-off-by line is just a command-line switch, but adding a
Reviewed-by line is more complex.

Is there anything in git that could help this situation? I didn't see
any related config option; I wonder if a patch would be accepted to make
the "Signed-off-by" line configurable, or there is a better way.

Like, would a patch that adds e.g. a core.signedOffString configuration
option to make the string customizable welcome?

Thanks,

Miklos
