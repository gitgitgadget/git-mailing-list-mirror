From: Rustom Mody <rustompmody@gmail.com>
Subject: about crlf file-encodings and other options
Date: Thu, 16 Jul 2009 19:21:19 +0530
Message-ID: <f46c52560907160651u1cdc1779r511d227fa5c88956@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 15:51:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRRNM-00069H-JA
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 15:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757232AbZGPNvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 09:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757212AbZGPNvV
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 09:51:21 -0400
Received: from mail-pz0-f197.google.com ([209.85.222.197]:38057 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757203AbZGPNvU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 09:51:20 -0400
Received: by pzk35 with SMTP id 35so98530pzk.33
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 06:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=VJMaQ3mdJh8COMrY60BzOEpPUAphehYccI3fdzcZE2A=;
        b=YjdMmG3E7zxR3QnxBrE4C4HRuRR8uvxm9yWIU6prvDe+xM1YkEZ4NQIfuUc1S6knwF
         JuQh5658r3J3QwSrb+B0JHJ2QZ6St5yQArBskpkpdN3OKA6PVYNyc64gXmKwx8PLbfB1
         vOyO/yXRMymUNKCPGm706rmtFCFtVlVqqRgUg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=e1ypkYDUaG5WPbyaHAq6XFjTjlgT6sUJtAlgVXY937rfpwuh7nrSYDHp+VHI74GaW5
         VaTaTr7SOFWfBIl14p646UBlSU7ze/EkaX5JEHBvdJHF3+fBSkOFEXOHYyMxfntkHs7f
         ZrMTGxEEBgESNDGB9at3DDh2JKOKzL65o+SJo=
Received: by 10.114.122.9 with SMTP id u9mr14626628wac.206.1247752279968; Thu, 
	16 Jul 2009 06:51:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123402>

I am trying to figure out the best choices regarding file-encodings,
crlf choices etc.
I see some stuff in gitattributes and some in git-config.

So...
1. Is there some place I can find out whats the received wisdom
regarding crlf and file encoding choices
2. is there some one place where all the options for all the git
commands are listed?

For example I find in git-config the following

[branch "devel"]
        remote = origin
        merge = refs/heads/devel

Where does one find out about such options?
