From: Howard Miller <howard@e-learndesign.co.uk>
Subject: How do I get a list of tracking branches
Date: Thu, 21 Jan 2010 09:25:37 +0000
Message-ID: <26ae428a1001210125j156b61afs64bb915a934530c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 21 10:25:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXtIQ-0007Rb-1C
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 10:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818Ab0AUJZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 04:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754777Ab0AUJZk
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 04:25:40 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:51773 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754769Ab0AUJZj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 04:25:39 -0500
Received: by ewy19 with SMTP id 19so2141524ewy.1
        for <git@vger.kernel.org>; Thu, 21 Jan 2010 01:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=19tQ4eUQo7eDM67MjsPu47LvWQYjrgSKBsS5o1ral5k=;
        b=PoBK1nhCbHwYN79Wjy2KP/8gv2f+jmsz0koEmH2C6ysfXXKCxyJj6sYcBVCZ5pyS5c
         YvLeU5ugZ7pVNVB5lmoWhTxt8og68zFkhXu+MPREIo/ao+nedRI6I20u9b1vaQkI7qVZ
         zH26iYrYuqH7rtwe1gLTTUKnglonGm1v9TZZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=KPcEI04fB4H8g4Yu5GAxS3l9jqrCkT2mRZ0mnLWI8KgWYTwhU/ly5XiOpU9WRYas+1
         JyCPwzdwNW8SU44n6+s3EtzmD/TCSoPk+/CgWv//qanCjedDK41BRsSuFM2DbIQQr6Hm
         FJmMMmuxbgrf/XDdxuuzbIe1NHn0L5e9rIKM8=
Received: by 10.213.110.2 with SMTP id l2mr849813ebp.94.1264065937894; Thu, 21 
	Jan 2010 01:25:37 -0800 (PST)
X-Google-Sender-Auth: 1cc6905ab9cb6b4b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137644>

Hi,

I know I can go and look at the config file and get this info but is
there a simple command that shows which local branches are tracking
remote branches? It seems like a very obvious thing to want to know
but I can't find it. 'branch -av' even shows 'n behind' and/or 'n
ahead' but not *what* it is behind or ahead.

Thanks!
