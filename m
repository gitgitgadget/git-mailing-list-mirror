From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/9] transport-helper: updates
Date: Sun, 22 Sep 2013 21:32:41 -0500
Message-ID: <523fa84970494_57ae47e7441217@nysa.mail>
References: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com>
 <523F9E34.8030805@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 23 04:39:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNw3s-0006aJ-2T
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 04:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330Ab3IWCjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Sep 2013 22:39:40 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:54194 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202Ab3IWCjj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Sep 2013 22:39:39 -0400
Received: by mail-ob0-f180.google.com with SMTP id wm4so3057277obc.11
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 19:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=5wcQeJRny47pKAzFJE+7KNDIMNr8JXv3/UUmjFciRKg=;
        b=ryRGQKbwJOfGT6Pif/neRCZZ+qjzmmkCbc9eLfTFLomRLB1ZIlf0InDFThOzZVD0Om
         VOitvVuel0rPDKnk81CMbmXCtqjCTF8asHfgLzEYLTrhzyCizSf5q6Yx9eg8zsFR8P/L
         Gh+e5LrTV+nNOCudKRNP+Vh1NlWSO1Xkla3znHUwywW2rSXnijmxVL5bQzvxxDuB4quA
         RgEjr0yJLDQyxPWJmzhGGpryOpaXEAMuJgsnzlFwzNYNRpDeGZOTyQBL+8jtb5Tu3rv2
         RxQ6Mvo2uR6yw7zEddI6gM2ixCLz0eFP1/eWSXcBusxthZKkK5mul4JXJoDg5PkD/Hyo
         i3vA==
X-Received: by 10.182.45.195 with SMTP id p3mr4103581obm.29.1379903979298;
        Sun, 22 Sep 2013 19:39:39 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id it7sm11750496obb.11.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 22 Sep 2013 19:39:38 -0700 (PDT)
In-Reply-To: <523F9E34.8030805@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235179>

Richard Hansen wrote:
> On 2013-08-29 11:23, Felipe Contreras wrote:
> > Here are the patches that allow transport helpers to be completely transparent;
> > renaming branches, deleting them, custom refspecs, --force, --dry-run,
> > reporting forced update, everything works.
> 
> What is the status of these patches?

Ask Junio. All the valid feedback has been addressed, there's no reason not to
apply them.

> I would like to be able to 'git push old:new' and 'git push -f' to a
> bzr repo, and these are a prerequisite.  I imagine changes to
> git-remote-bzr will also be required; I'm willing write up such
> changes to git-remote-bzr, but only if there's interest in picking up
> this patch series.

There's no need to modify git-remote-bzr, if theese patches are applied,
old:new would work for all remote-helpers.

-- 
Felipe Contreras
