From: E R <pc88mxer@gmail.com>
Subject: is there a 'git find'?
Date: Tue, 4 Aug 2009 23:14:29 -0500
Message-ID: <3a69fa7c0908042114v7097e87esbe18f49eef9267f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 06:14:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYXtg-0003JY-0r
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 06:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbZHEEOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 00:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbZHEEOa
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 00:14:30 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:41730 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbZHEEO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 00:14:29 -0400
Received: by yxe5 with SMTP id 5so3645443yxe.33
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 21:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=1Hfub5QkqYSgCHns/npgwrvse7kZbPYJkHnxy2VGIhA=;
        b=aAitW5mBV/MfeSwAlxzOHHthNBvHg+b3vQ4C72tUd+5q75z5w3Eb/mGAolJsqaXCn+
         xnZjP4hok+JOaGyU4DTUZKM/m189YmQjlGGjQd7e9iyIY97hijXUuSKOLXXz5rRFqsYF
         lJp/syt4hHLYo4ql0LQ1IuBQUHUjwK9hqjoQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=fviZIuWIjpu+UHFd0WLFwDeZPFMwwnEU1OJxhT4GeWSSx90yXOyrgzuP/hQrC+TYDA
         Hx3LDuQ6ojCnrAjQ126u4EdiuScgYiMO0ZRtq3yxuujOTPolXvbf9tB9cJRrzNIlWwoe
         3MR6lcRpMLn2J1kyg6Q/ZSncwYMYQM2Vuz4EA=
Received: by 10.151.103.2 with SMTP id f2mr13394443ybm.333.1249445669340; Tue, 
	04 Aug 2009 21:14:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124848>

Hi,

Within a specific commit I'd like to find all the files whose path
names match a regular expression.

Without checking out the commit, is there a way to do this? I'd like
to add this feature to gitweb.

Thanks,

ER
