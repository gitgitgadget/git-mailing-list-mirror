From: Leon Mintz <leon.mintz@gmail.com>
Subject: Feature request: post-receive rss generation
Date: Sat, 10 Aug 2013 01:34:16 +0300
Message-ID: <CAARypAa-0i+DMhCW24K6-q9WKAaptey2NKE6X=aHRgFySkXeaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 10 00:34:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7vGR-0004XP-Ck
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 00:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031412Ab3HIWeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 18:34:20 -0400
Received: from mail-ve0-f195.google.com ([209.85.128.195]:33505 "EHLO
	mail-ve0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031364Ab3HIWeS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 18:34:18 -0400
Received: by mail-ve0-f195.google.com with SMTP id m1so1562255ves.6
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 15:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=b0zwZhD/1X5QJjpOVjf0LGEYaaazd9i4AmZRlFT7CjY=;
        b=m3aa6ze9L/14in9aOnl+wZhYxC2fELqQyHXlJlj+68cv3sZfdWvTKyQS8Be02hBOeP
         rN78XwLBRkBaiq9M2VHTK61C99t/Wbu5pCi+vFK0OsrNO7PkY+L0imHfWmjyfD++ZnDH
         qImxyxWLR4K1yw9vDRwVTa1onHSDeOWn/GSONV8sXPO6U2iYJn2r5Xrn5TQKhfIXnFeV
         2b5pr6+tAbaY7PYboxFwWqnt3ngM1sOLkh1Vq2cemMaGWE+2FSJvojtm9RManzUs5DDC
         zkBGldFfrXuh/y3ms6n1j+IfRnN1lcRhDdb1gSrwMnx35rrgzwusuR4tk9ske4YkMpjZ
         Q/SA==
X-Received: by 10.52.244.34 with SMTP id xd2mr1372692vdc.87.1376087656482;
 Fri, 09 Aug 2013 15:34:16 -0700 (PDT)
Received: by 10.220.188.198 with HTTP; Fri, 9 Aug 2013 15:34:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232046>

Could you please add the following functionality:
I want to be able pass a command line argument to git, which will
generate an rss file with the latest changes.

Several codes already exist:
* git2rss (http://bent.latency.net/git2rss)
* git-rss (https://github.com/iarna/git-rss)

Thanks,
Leon
