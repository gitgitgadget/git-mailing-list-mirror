From: "=?ISO-8859-1?Q?Asbj=F8rn_Morell?=" <atmorell@gmail.com>
Subject: git: symbol lookup error: git: undefined symbol: deflateBound
Date: Thu, 14 Aug 2008 18:17:56 +0200
Message-ID: <809705790808140917qa28878blac13b76a7d213077@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 18:19:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTfXT-0002M3-Cp
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 18:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbYHNQR5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2008 12:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbYHNQR5
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 12:17:57 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:8297 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbYHNQR5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Aug 2008 12:17:57 -0400
Received: by rv-out-0506.google.com with SMTP id k40so480807rvb.1
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 09:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=ZTU+DEaVP0y3zovmghtyRnWy/hZFYRqx+qG80iBszkE=;
        b=pdg3f565AKpdn6HSjWG3aNqoQLLhV+QJuwNBYLfR0RH3qRbxj+5O0qN5Y1LXbSlQu4
         meqULsqfHtbSbvZBmgiLuudGKgxiLRdrsFnhEIn0LpBzUq8CfY3m3nUfHxjKZ5OpTs3C
         vF0jAkreLq+B8SeHEGmEoJhfxFLTymLE8N5y8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=OqohPty7eZKGtUWnHi0eYR/vns+TcLDfZP2BX8cuhUEXltnNCDorIKB/8HhZHNtSg2
         5Mvb172fp10Otc/cKhCQlnK+wFiILebXUjpopm2kuxK/wWshibOq44/372cGjwTknlq+
         /JgO2qlu6opwiO6tNcLhTJOch79dpDgt87GTE=
Received: by 10.141.48.6 with SMTP id a6mr803532rvk.236.1218730676523;
        Thu, 14 Aug 2008 09:17:56 -0700 (PDT)
Received: by 10.140.207.14 with HTTP; Thu, 14 Aug 2008 09:17:56 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92367>

Hello,

I have compiled and installed the latest version of git from source.
When I try to add a file to my repository I get this error:
git: symbol lookup error: git: undefined symbol: deflateBound

The second time I try to run the command git outputs this warning:
fatal: unable to create '.git/index.lock': File exists

Hmmm I am really lost. Tried different versions with the same result.
The strange thing is that I used git some month ago without any
problems. Could there be some old conflicting files on my system?
Maybe from a older version of git?

root@server [/home/test]# git-init
Initialized empty Git repository in /home/test/.git/
root@server [/home/test]# git add .
git: symbol lookup error: git: undefined symbol: deflateBound
root@server [/home/test]#

Best regards.
Asbj=F8rn Morell.
