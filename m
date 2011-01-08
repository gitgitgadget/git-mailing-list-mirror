From: Rich Eakin <reakinator@gmail.com>
Subject: different name and email address depending on folder
Date: Sat, 8 Jan 2011 11:52:22 +1100
Message-ID: <3178E076-FA22-4C3C-BEB2-2581A0E12086@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 08 01:52:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbN2x-0004Xp-Lm
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 01:52:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548Ab1AHAwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 19:52:32 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:40209 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259Ab1AHAwb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jan 2011 19:52:31 -0500
Received: by pxi15 with SMTP id 15so3147127pxi.19
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 16:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:content-type
         :content-transfer-encoding:subject:date:message-id:to:mime-version
         :x-mailer;
        bh=f7mqbaGbp0eHJK7CbROvLHiVJORY6yEpFYrPSwsM+yM=;
        b=pg/pwOdc5dgbYyzNEa2wEIathvscS2KG1CGtylLoSiR57iA9gjtgUosc+oYVkknZMF
         hdEsBeKz+Uus9snO3I97vMIsuPlyArVjbQxSoPe66FKzNrThoPJp52QEHVyLHq7xTBga
         xrZQosYqjDt5dcDB2QMrVvHO+vyLFWGsFbfDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        b=A2/pzuQMrCW6lz7xDBJ2P269fFq4TP5PqWEvmF7wY6vs1zG0QalCTYzcVY6auhBjr4
         9R46TgfBXR9HhP1HCqLq0fr4TSiVQBbaT98LuGaNFLMYMKJVBlFgooq+1mHVoajH8j7d
         RU+JHibxT/IWoUd2OfOopbo/HWsK/kc3IxfUA=
Received: by 10.142.51.21 with SMTP id y21mr2197896wfy.266.1294447951354;
        Fri, 07 Jan 2011 16:52:31 -0800 (PST)
Received: from [10.1.1.11] (d110-33-100-19.mas800.nsw.optusnet.com.au [110.33.100.19])
        by mx.google.com with ESMTPS id q13sm3388153wfc.17.2011.01.07.16.52.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Jan 2011 16:52:29 -0800 (PST)
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164797>

Hi,

I am using git for development with a company and myself on the same computer and the name / user fields need to be different for each.  As I keep all my company's repos in one directory and my private stuff in another, I was wondering if there is a way to tell git to use a separate user and email whenever I make commits from within a specified directory.  

If anyone can tell me how to do this, or some other way to achieve my needs, I am very thankful.

Best Regards,
Rich