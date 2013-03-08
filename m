From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: question re tags
Date: Fri, 08 Mar 2013 17:30:20 +0100
Message-ID: <1362760220.3681.1.camel@centaur.cmartin.tk>
References: <25720629.116.1362755762863.JavaMail.User@LANE15-HP>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Stean <john.stean@lane15.co.uk>
X-From: git-owner@vger.kernel.org Fri Mar 08 17:37:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UE0Im-00037s-RY
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 17:37:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934420Ab3CHQhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 11:37:23 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:48450 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933140Ab3CHQhW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 11:37:22 -0500
X-Greylist: delayed 379 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Mar 2013 11:37:22 EST
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id C345BDE066;
	Fri,  8 Mar 2013 17:31:01 +0100 (CET)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V1mv2pyVRJUm; Fri,  8 Mar 2013 17:31:01 +0100 (CET)
Received: from [192.168.1.2] (p57A1F6E7.dip.t-dialin.net [87.161.246.231])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 8CE64DE062;
	Fri,  8 Mar 2013 17:31:01 +0100 (CET)
In-Reply-To: <25720629.116.1362755762863.JavaMail.User@LANE15-HP>
X-Mailer: Evolution 3.6.3-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217668>

On Fri, 2013-03-08 at 15:16 +0000, John Stean wrote:
> Ive been tagging some commits using tortoise git , for example with
> "v1.0", "v1.1" etc. In tortoise git log the tag sits alongside the
> commit as I expect.
> But when I do a git describe it outputs the first tag along with the
> latest commit. What am I doing wrong?

Those tags are probably lightweight tags, so by default git-describe
doesn't take them into account. You can pass the --tags flag to tell it
to consider lightweight tags as well.


   cmn
