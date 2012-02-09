From: Domenico Andreoli <cavokz@gmail.com>
Subject: Merging tags does not fast-forward with git 1.7.9
Date: Thu, 9 Feb 2012 10:54:15 +0100
Message-ID: <20120209095415.GA19230@glitch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 10:54:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvQht-0004Bf-Mt
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 10:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757229Ab2BIJyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 04:54:21 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:46650 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701Ab2BIJyU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 04:54:20 -0500
Received: by eekc14 with SMTP id c14so516701eek.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 01:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:subject:message-id:mime-version:content-type
         :content-disposition;
        bh=gF/qUpe3kUbsAiX5wfVvKvoZT6YRm6rEGK5ptv95g5o=;
        b=tWdzYPbCRvnqczdlcyO9TChpHmDFQhhqGQgkgHNvHSY3NpeSSNQ6/m3Va/VzRdZZ1K
         yD+IYR6Qw2HAB0IdEqmYZUA1ok9VZkuNXKFv9vCQx3kYtXrP59/YjM8TuaOtNAN7ATD6
         vqLdzajfznGivpbFTZCUsaJg/9atiCAPV2nSQ=
Received: by 10.213.2.74 with SMTP id 10mr266473ebi.11.1328781258827;
        Thu, 09 Feb 2012 01:54:18 -0800 (PST)
Received: from glitch (178-85-163-250.dynamic.upc.nl. [178.85.163.250])
        by mx.google.com with ESMTPS id o49sm7980931eei.0.2012.02.09.01.54.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Feb 2012 01:54:18 -0800 (PST)
Received: by glitch (Postfix, from userid 1000)
	id B090EBA07DB; Thu,  9 Feb 2012 10:54:15 +0100 (CET)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190283>

Hi,

  with the recent changes in tag merging (I updated git to 1.7.9),
my usual "git merge v3.X-rcY" command does not fast-forward any more.
Of course the initial head is something like "v3.X-rcZ" without any
change so that it should (and usually did) fast-forward to the new head.

The editor is instead fired off and I have to fill the details of a
merge commit, diverging from mainline as soon as I save and exit.

Is there any simple and clear explanation for this? Thank you.

cheers,
Domenico

ps: I admit I didn't follow the details about tag signatures so probably
I missed something that I shouldn't.
