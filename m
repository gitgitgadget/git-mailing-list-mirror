From: Noel Grandin <noel@peralex.com>
Subject: feature request: excluding files/paths from "git grep"
Date: Wed, 25 Feb 2015 14:23:30 +0200
Message-ID: <54EDBEC2.8090107@peralex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 25 13:28:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQb55-0005a7-14
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 13:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332AbbBYM2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 07:28:43 -0500
Received: from mail.peralex.com ([41.164.8.44]:48006 "EHLO mail.peralex.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752735AbbBYM2m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 07:28:42 -0500
X-Greylist: delayed 313 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Feb 2015 07:28:41 EST
Received: from [192.168.1.95] (noel1.ct [192.168.1.95])
	by mail.peralex.com (Postfix) with ESMTPSA id 1CED0336F67
	for <git@vger.kernel.org>; Wed, 25 Feb 2015 14:23:26 +0200 (SAST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=peralex.com;
	s=default; t=1424867006;
	bh=ZTjtgVqgj6Kj/Ujs5q4ImvZluTOsKDemR+aI4iqyBYE=;
	h=Date:From:To:Subject;
	b=Qnfb0PLpd/7vigmGWYd31k0F8XnG60sVIY5sT7x+ZbFD6iTepAHagdMHOnU7Nsjd3
	 1dorzFg+VIrgwWREMg81Qrn4P0FkWJNPvy/YV/QPdgZW/Iv1eUAqcKIZvYdc5Jf6Pr
	 JtceiHrddRBA3Rw8sjXcODmUSLKJ3a8IR239ZgHs=
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.4.3 (mail.peralex.com); Wed, 25 Feb 2015 14:23:26 +0200 (SAST)
X-Scanned-By: MIMEDefang 2.74 on 41.164.8.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264389>

Hi

In our repo (LibreOffice) we have various test files which tend to show up on 'grit grep',
which just generate noise because
(a) they have lots of common keywords that one might search for in them
and
(b) they have very little in the way of linebreaks

So they tend to generate a lot of noise when searching.

What would be nice is a per-user/repo config setting that excludes certain files and paths from the 'git grep' search.

Does this sound reasonable/acceptable?

Thanks, Noel Grandin

Disclaimer: http://www.peralex.com/disclaimer.html
