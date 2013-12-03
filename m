From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Segfault when fetching from current git.git on GitHub
Date: Tue, 3 Dec 2013 19:56:31 +0100
Message-ID: <CAN0XMOKPWm1CzS3289SHpH=N0osFszuvnK6e9BVxwtQe3b2YJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 03 19:56:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnv9B-0008Pk-No
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 19:56:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753750Ab3LCS4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 13:56:33 -0500
Received: from mail-we0-f178.google.com ([74.125.82.178]:43209 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630Ab3LCS4c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 13:56:32 -0500
Received: by mail-we0-f178.google.com with SMTP id u57so8183248wes.23
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 10:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=h8Czl9TCec7Gy4oehcY1xFT8k/APiiusNIas7vNBM1U=;
        b=Vju6FyVY1WsyD7a+H1ZJdOs1E5YQRw8NpupYheImewvfmaBcQjEWEQViA0UEbJODBD
         B/NhyMAsHOwnCAbptzDpQPFanP2og6ozt/eSQpQSwqT/tlOwdYYeMACxUXaVa0aS2gDC
         7nJnj9WFtnK/NQIIguTkvOZ5hqqeZYsk/xmDsIVmCveh+i9dS0+73oaSwWBbAJVNORjE
         MGX9HtBgakdZW85UME/fzypn0E99CoAwB7WEUU1iEiIbq3MKJ1FXue6xiiI56cHX02wn
         JdqM/xzbqxdpJ1liFDqpiRC7DQQcVV2hs752AS5xA52kgQHaGCAg9xz3yYS+RFQWSTBG
         tc2w==
X-Received: by 10.180.105.199 with SMTP id go7mr3767096wib.53.1386096991463;
 Tue, 03 Dec 2013 10:56:31 -0800 (PST)
Received: by 10.194.165.163 with HTTP; Tue, 3 Dec 2013 10:56:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238714>

Hi,

I've fetched from the current git.git on GitHub minutes ago and got a
segfault. I could reproduce it with the Git version of the current "next" branch
(1.8.5.392.gf545f4d) with the steps below. The segfault does not appear with
version 1.8.5.

Steps to reproduce:
git init tmp
cd tmp
git remote add origin https://github.com/git/git.git
git fetch -v

Full stacktrace: http://pastebin.com/zK8epKWj
ProcMaps and ProcStatus from Ubuntu's Apport: http://pastebin.com/ZpPk1WSA


Ralf
