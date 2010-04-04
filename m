From: hoijui <hoijui.quaero@gmail.com>
Subject: git-gui bug: multiple files selection using [Ctrl]
Date: Sun, 4 Apr 2010 20:02:16 +0200
Message-ID: <h2jf27d62f81004041102med1633b9h1d149dc52b598f8b@mail.gmail.com>
References: <w2of27d62f81004041057h59d440bare6a91a57b0788224@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 04 20:02:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyU9Q-0004Mb-Dq
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 20:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158Ab0DDSCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 14:02:19 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:39370 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696Ab0DDSCR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 14:02:17 -0400
Received: by bwz1 with SMTP id 1so2445335bwz.21
        for <git@vger.kernel.org>; Sun, 04 Apr 2010 11:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:received:message-id:subject
         :from:to:content-type;
        bh=O3t8tUKhgo0bKZv+p4fqqGqvb0+4mXTLoGCqkbW0W+k=;
        b=MXCqoJFZkB/AyFbkH0Oks2F5ut8ZqGMb1PmpSL3NOkbR7/4TIOKhulz+BRkiWernkW
         GlZ0mAp7EAcGHp4iRnmeTyPvCE6D9jcvCNofJ1v+OHaAATLiX+7bNn2MJmWOWhLWtkDg
         MCqqQmmV1YaNjlroLK5jY7lDbqalrj57L9X9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        b=E7gKtoGfsSTSRuKvDAVbQMqo/wirhXx9HRxGW61Y1rlyxJxh3irrcCzQfqOH6Dj3+2
         V4AzCN857lHilgiUHXbFPDD+CXALblpV5Tz1r+mec03FmEwwBpgbGPb63BL3Wt/g3aQG
         syv2MFsS8GmdZOz19NgFM+56qlW3U48CXyVIo=
Received: by 10.204.57.145 with HTTP; Sun, 4 Apr 2010 11:02:16 -0700 (PDT)
In-Reply-To: <w2of27d62f81004041057h59d440bare6a91a57b0788224@mail.gmail.com>
X-Google-Sender-Auth: 4f27f2ee111d40e0
Received: by 10.204.152.17 with SMTP id e17mr5608348bkw.105.1270404136125; 
	Sun, 04 Apr 2010 11:02:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143936>

Hello :-)

tested with: v1.7.0.4-297-g6555b19

how to reproduce:
1. open git-gui on a repo which has multiple files with unstaged changes.
2. select one file with unstaged changes using [left-mouse-click]
3. select one or more files with unstaged changes using [Ctrl] +
[left-mouse-click]
4. [Ctrl]+t
The files selected in step 3 will be staged, the one selected in step
2 will NOT be staged, even though it should be.

robin
