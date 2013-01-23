From: Hans-Juergen Euler <waas.nett@gmail.com>
Subject: git-svn does not like format=4
Date: Wed, 23 Jan 2013 11:43:47 +0100
Message-ID: <CAK3CF+5uD92pdEaoq4e1fwi_YxkM3ddzAUqYKO1rW5BY9rPdCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 23 11:44:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxxoQ-0007zT-9Q
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 11:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351Ab3AWKnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 05:43:50 -0500
Received: from mail-wg0-f47.google.com ([74.125.82.47]:35362 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754939Ab3AWKnt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 05:43:49 -0500
Received: by mail-wg0-f47.google.com with SMTP id dq11so2065177wgb.2
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 02:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=KgDeXx4DKqgsfFmjC80zYSoXtAj8QBY0gKEwn93ln/o=;
        b=kmgynYS3Foi8KGuvYDT01Gw3LELbTQoBMYJZEaHwHGSskvPUuLuaQuz1HarR5AqMPy
         QXdej395ImcoQebjsEJ+xXgx+NWC3+WtnmetZD20kqPsGPOxtnldjsuLYPYzd2wMYYeS
         uJfcAK7l7MzYu3AgA6RtBH3om3onUWKGO1m8dd1JQuqz/mkQ6RgHWfTE4oTBa/RJhDmi
         2R9opLIxBwC5lLzO0A/olDXXBuQb7t5tnrseYHEw4pJhbMnzGDYjgx08OdVw0nY+rpuk
         TahcwcLQ813vAVhagX/aXIZluKWewngfyGef6FW+i/i0D9V4KgklrRUEbdcvCye+TZbP
         gNXg==
X-Received: by 10.194.158.100 with SMTP id wt4mr1568085wjb.37.1358937827984;
 Wed, 23 Jan 2013 02:43:47 -0800 (PST)
Received: by 10.194.221.232 with HTTP; Wed, 23 Jan 2013 02:43:47 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214309>

it's part of a sequence of problems you can find on
groups.google.com/d/topic/git-users/kfMFZ3uEFsM/discussion

windows 7 64 bit
Git version 1.8.0
git bash and git gui installed and using

using subversion
TortoiseSVN 1.7.11
Subversion 1.7.8
Was typically always up-to-date (within 2 months or so) with previous versions

using an external subversion provider for storing the information
externally. guess the version there is older but do not know

I have dumped the content of an external subversion repos and created
a local repos with aforementioned version.
when cloning the subversion repos with "git-svn clone" I received this
error message:
 Expected FS format '2'; found format '4' at
/usr/lib/perl5/site_perl/Git/SVN.pm line 148

Please let me know if you need more details.Thanks
