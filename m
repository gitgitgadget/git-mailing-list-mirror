From: "=?ISO-8859-1?Q?Niklas_H=F6glund?=" <nhoglund@gmail.com>
Subject: Update hook in Cygwin
Date: Wed, 8 Mar 2006 12:16:56 +0000
Message-ID: <ad8ce5c20603080416g5ed6d77el@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Mar 08 13:17:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGxbA-000754-Oj
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 13:17:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbWCHMQ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Mar 2006 07:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbWCHMQ6
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 07:16:58 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:7751 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932505AbWCHMQ5 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Mar 2006 07:16:57 -0500
Received: by nproxy.gmail.com with SMTP id a27so120093nfc
        for <git@vger.kernel.org>; Wed, 08 Mar 2006 04:16:56 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=H1xhHkWuxtN6OZsCugdROeRTjrV09M82IFo1Z/MubKt8R9hpUq+yl+As3aPNLEi8qMHNcjMdUD0Z424v/UDKvQpiMogaRS+VTMiGueVqKFs1I66PsZy+PW2ViUDcMaqdpCFSEnL0bKzw4HP1Y4I7Tj7sKoGkOwoWOQXDpAv2BRE=
Received: by 10.49.67.12 with SMTP id u12mr319067nfk;
        Wed, 08 Mar 2006 04:16:56 -0800 (PST)
Received: by 10.48.206.11 with HTTP; Wed, 8 Mar 2006 04:16:56 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17370>

Hi.

After creating a couple of repositories and pushing and cloning them,
I get the following:

$ git push --all origin
...
hooks/update: line 88: mail: command not found

This is in cygwin. I'm rather glad I don't have the mail command
installed, as I don't want mails going anywhere.

The update hook contains the following comment:

# To enable this hook:
# (1) change the recipient e-mail address
# (2) make this file executable by "chmod +x update".

But my impression after a cursory look at it is that it would always
call "mail" whenever it is run, and since all files are executable in
Windows (AFAIK), it would always be run.
