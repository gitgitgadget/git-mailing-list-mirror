From: "Chris Ortman" <chrisortman@gmail.com>
Subject: [FEATURE REQUEST] git-svn format-patch
Date: Tue, 15 Jan 2008 07:59:58 -0600
Message-ID: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 15:00:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEmLD-00062n-QH
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 15:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbYAOOAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 09:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbYAOOAF
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 09:00:05 -0500
Received: from nz-out-0506.google.com ([64.233.162.228]:61627 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbYAOOAB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 09:00:01 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1249714nze.1
        for <git@vger.kernel.org>; Tue, 15 Jan 2008 05:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=nMZTMTAMoWxgazK7eeAOg4Ojbg8qyM1zB7Rdoef74mk=;
        b=Mr2jepA8cXcFBzTo0hfUt0WNakLS86dm6ct2aTMIXoVzCdS2V1Go5dfLR/sWoHUqnXrq/KCSj0aaOF2Wrep36quVmsB2egnhYJvnziYiB3Jk9570rBVAbJzbwzR4J8U9NclOck6+yjJUbY6QhYlxtPyYzLJ8VU0OPUQAY8Yv5R8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DSFv3/SnVAktwPlM/m0qqE+ZaXdh0eEdtoOC49OrjD++WRCCf/IVtdfQqXwK2Y+KclNYWYEpVHcZkpp34H9SWg8AhIO45BF8Sme2E4X5eDmK/9ieyDrpQtR0SEHuv2RTDFX/PFKM63DDK3GtSXk//+Kck/A+cnfuk3Aa83USdqo=
Received: by 10.115.92.2 with SMTP id u2mr1728406wal.139.1200405598651;
        Tue, 15 Jan 2008 05:59:58 -0800 (PST)
Received: by 10.115.17.6 with HTTP; Tue, 15 Jan 2008 05:59:58 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70524>

Something that would really benefit the folks who use git to manage a
subversion repository (such as myself) would be a special format-patch
command for git-svn that creates a tortoise svn compatible diff file.

Thanks.
