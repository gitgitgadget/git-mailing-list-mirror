From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: About detached heads
Date: Fri, 14 Mar 2008 20:16:07 +1030
Message-ID: <93c3eada0803140246k53408c74m21f9dc277857202d@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 10:47:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja6VP-0006Fd-7E
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 10:47:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbYCNJqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 05:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbYCNJqL
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 05:46:11 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:11894 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbYCNJqK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 05:46:10 -0400
Received: by fg-out-1718.google.com with SMTP id l27so127473fgb.17
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 02:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=xieW3Sj35jj8VXUCx9nGZQp44yl5bLEhAlUccl9bKcg=;
        b=USeJ2NFXdLOAyXXdlrl23kgihtPwu4NPU3aseV9qc6yHWKr8Tx+zNgsqLLdk6Wu9yQjBGTvbYH14WIl+qCfVlNpOHaQd1pIoXA6pvH8Lec9Q2bdLBhEEjjSxp3e/oChd/Jd+Y+81ikoTZ3rAeJxLyLPrFiY8FEv+YvkVSOJQe8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Jveg9Dn0Qrt54mT576zLTlx3RcAIkElZ16IfFzJFPhSPYLlKlQ/vDkabzh2/OS71guCqHVkqy5O4vfTtEoqS3Y5nHTn/YNIRkp/A3UW0XkLre5jY6QKdcy/3ZoispMxBOb5AirZqNfJrEXLJppp3NKNeutuJr3PiIy1tqSNBWJU=
Received: by 10.82.115.8 with SMTP id n8mr25694038buc.10.1205487967845;
        Fri, 14 Mar 2008 02:46:07 -0700 (PDT)
Received: by 10.82.114.1 with HTTP; Fri, 14 Mar 2008 02:46:07 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77196>

This should be simple! I have a series of commits:

           1---2---3---4---5

I want to go back to 3 but not branch, so I want

           1---2---3---4---5---3

?

         git checkout 3...

gets me the commit on a detached head, but I don't know how to put this back
as the HEAD.

I'm on git 1.5.0.5

Cheers,
Geoff Russell
