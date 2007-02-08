From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: [BUG] Empty reflogs and "git log -g"
Date: Thu, 8 Feb 2007 02:21:33 +0100
Message-ID: <8aa486160702071721s401ea38fxa8eb71bb694a6915@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 08 02:21:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HExym-000525-6p
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 02:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933316AbXBHBVh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 20:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933350AbXBHBVh
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 20:21:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:43017 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933316AbXBHBVg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 20:21:36 -0500
Received: by ug-out-1314.google.com with SMTP id 44so346095uga
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 17:21:34 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=U0I+9xYERbV4CM6x0L3A2Ve3tvXwQfal1M48OUL28HavpgIkilVQVC6PW9ojj416TYM3rFxR1i0DfSLvkEWB6upxzl2k7r4pQWgVareZgWwIC3ausfp88QQC4XQQzboNeltWY+PamS3Y9rPHtbVJJAVHJk/3TrYUW2Nx2aSN7oQ=
Received: by 10.78.181.13 with SMTP id d13mr50339huf.1170897693489;
        Wed, 07 Feb 2007 17:21:33 -0800 (PST)
Received: by 10.78.68.8 with HTTP; Wed, 7 Feb 2007 17:21:33 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39026>

Hi *,

  when a reflog entry do not have a reflog message the refs@{num}
syntax gives a different result than with 'git log -g'. Actually 'git
log -g' just skips this ref.

Regards,

Santi
