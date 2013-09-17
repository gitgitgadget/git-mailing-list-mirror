From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: Delete branch during fast-import
Date: Tue, 17 Sep 2013 14:54:32 -0500
Message-ID: <5238b378b6616_1b88104fe74471e@nysa.mail>
References: <20130917174954.GA28563@home.jasonmmiller.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Jason Miller <jason@milr.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 17 22:00:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM1Rs-0005XO-Qa
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 22:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870Ab3IQUAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 16:00:30 -0400
Received: from mail-qc0-f170.google.com ([209.85.216.170]:41239 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753859Ab3IQUA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 16:00:28 -0400
Received: by mail-qc0-f170.google.com with SMTP id m20so3987615qcx.29
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 13:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=peMZndybIhROkPMiGaNi6gM5kluPnN2EX2PAx7OYUUY=;
        b=cRmaxCgQqznew526Gg1Cxt9FFuo7KZX4D2OfXE9o8ml08ak0GKYJ+gaUB0SkNHhVQ0
         R+mSHrx2rJfCZA7rPmoXcYi+4yXkO+AkLWNmMEu1fqWNi5yc4ZEZJcfYgEYtcujuFFQh
         o1VxkGK2HjbHA+fIbdHrAWTVE+otwSAn6r99vhaSiDT5A11z6BFZfY945+tOxEUZ2AQV
         sASbtvk23Ra+ZgJjHERA/WXH9L8OgdCepDrFI78iBNfvLyZMzrUXR8oWd35ZOodg3t57
         YhbE6zgOtNVxSbrC1HTzo8OfS++yST13f7dQisAi88wK8lad1Sc4bOTy4P563PE/46tm
         m3Rg==
X-Received: by 10.49.128.68 with SMTP id nm4mr17871418qeb.68.1379448028131;
        Tue, 17 Sep 2013 13:00:28 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id 5sm3678454qao.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 17 Sep 2013 13:00:26 -0700 (PDT)
In-Reply-To: <20130917174954.GA28563@home.jasonmmiller.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234911>

Jason Miller wrote:
> I'm trying out a rather large subversion import, and am trying to
> figure out if there is a way to delete branches during a fast-import.
> 
> Right now I can think of only 2 ways to handle this:
> 
> 1) End the import, do a git branch -D and then resume the import.
> 
> 2) Scan the entire repository history, identify
> deleted branches and handle them upfront so that they never have
> conflicting names.
> 
> Is there a better way?

Yes, support branch deletion natively:

http://mid.gmane.org/1377789808-2213-7-git-send-email-felipe.contreras@gmail.com

-- 
Felipe Contreras
