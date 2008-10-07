From: Knut Eldhuset <knut@3d-radar.com>
Subject: Different svn-id URLs in history
Date: Tue, 07 Oct 2008 12:58:41 +0200
Message-ID: <48EB40E1.40506@3d-radar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 07 13:09:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnAPs-0000iX-3I
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 13:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851AbYJGLGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 07:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753618AbYJGLGg
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 07:06:36 -0400
Received: from epost.nunatak.no ([193.200.93.202]:53008 "EHLO epost.nunatak.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753486AbYJGLGf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 07:06:35 -0400
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Oct 2008 07:06:35 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by epost.nunatak.no (Postfix) with ESMTP id BE809121C9D2
	for <git@vger.kernel.org>; Tue,  7 Oct 2008 12:58:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.419
X-Spam-Level: 
X-Spam-Status: No, score=-2.419 tagged_above=-10 required=6.6
	tests=[AWL=0.080, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from epost.nunatak.no ([127.0.0.1])
	by localhost (epost.nunatak.no [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4122EHxDEQHg for <git@vger.kernel.org>;
	Tue,  7 Oct 2008 12:58:35 +0200 (CEST)
Received: from [192.168.169.42] (unknown [194.19.26.200])
	by epost.nunatak.no (Postfix) with ESMTP id 598E0121C932
	for <git@vger.kernel.org>; Tue,  7 Oct 2008 12:58:35 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97690>

Hi,

After cloning my svn repository, I notice that the svn-id URL is 
different when going back in history:

git-svn-id: https://server/trunk@300

vs

git-svn-id: https://server/trunk/some_folder/project/src@250

If i checkout the first version, I get a working copy that has the 
folder "some_folder" in it. If I checkout the latter version, I get a 
working copy with the contents of the folder "src". Why is this? I 
thought I always was supposed to get a wc with the whole tree.

Regards,
Knut Eldhuset
