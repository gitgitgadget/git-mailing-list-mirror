From: Jay Levitt <jay.levitt@gmail.com>
Subject: Suppressing the user.name warning
Date: Wed, 14 Dec 2011 16:50:21 -0500
Message-ID: <4EE91A1D.6080908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 22:50:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RawiZ-000104-GN
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 22:50:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758090Ab1LNVuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 16:50:23 -0500
Received: from mail-qw0-f53.google.com ([209.85.216.53]:65384 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757464Ab1LNVuW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 16:50:22 -0500
Received: by qadb15 with SMTP id b15so883737qad.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 13:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=jihMqNQHT+1KuEhp4+koGne0D3ap0Ql8GB9r+odQPmk=;
        b=m04prF+w1/OU8GPKBx1m7k8QuyLnVLfNpinagJAkWB+gLsHo3M/QSaWF+mR9W4f81m
         0p1mhFqp7NArA+sbyJsIOzT9tek0aRfchLhEm0DNHndj8uB7wpC4W4gYsIn4SufxFeB5
         YB4SukKZOHCJ/3kMV/YaE37dZsECh4oQi5DZA=
Received: by 10.224.197.3 with SMTP id ei3mr913993qab.49.1323899421978;
        Wed, 14 Dec 2011 13:50:21 -0800 (PST)
Received: from jay.local (c-24-63-250-125.hsd1.ma.comcast.net. [24.63.250.125])
        by mx.google.com with ESMTPS id h9sm8283151qac.13.2011.12.14.13.50.20
        (version=SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 13:50:21 -0800 (PST)
User-Agent: Postbox 3.0.2 (Macintosh/20111203)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187170>

Is there a way to suppress the user.name/email warning without configuring 
them in .gitconfig? I want to pass them in SSH as GIT_AUTHOR_NAME and 
GIT_AUTHOR_EMAIL; git uses the values, but still warns me every time.

Seems like if git can get that data in any form, it shouldn't complain about 
not having it.  No?

Jay Levitt
