From: "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>
Subject: .git inside a .git: is it safe?
Date: Mon, 12 Mar 2007 22:56:30 +0100
Message-ID: <8b65902a0703121456s56008088ra14452ef7f325cf3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 12 22:56:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQsVY-0000Gy-5s
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 22:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbXCLV4c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 17:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbXCLV4c
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 17:56:32 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:61756 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932409AbXCLV4b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 17:56:31 -0400
Received: by an-out-0708.google.com with SMTP id b33so1624758ana
        for <git@vger.kernel.org>; Mon, 12 Mar 2007 14:56:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iY91tkT9HF7Ul9Q83leC/ykUS2mvzCYK3tg6JOqLjh5zPygVOn1pxuEXu3VcbkQC2SaelsI052LeJ2N67PBLFEpXMikL4vU+BMHyRBPsukCRQ+LV+0vNnwwbP7bHzu28gANximZz6btZssvkJAzm2NbEOEYzqcOJ81awjOSjX0w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NhRiIQZeDaGHyvj1y6X+OBCCxoWh6+1Zer1STtJ3M/05naO3smPXCHayv9CgCZ/7xFG3Z5tUwE825oIlMlBv5+VxxkPspxiv/4vDZRm3Wg1pg1KGG+2Nbyy1mNbm9Hqy6DteuzmwXlMutWl82Tb1xfYOY03YKHb2j/g9L7/V8oY=
Received: by 10.100.121.12 with SMTP id t12mr222186anc.1173736591006;
        Mon, 12 Mar 2007 14:56:31 -0700 (PDT)
Received: by 10.100.135.16 with HTTP; Mon, 12 Mar 2007 14:56:30 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42083>

Hi,

I'm actually working on the packaging of a project. To do so, I use
two Git repositories:
- one to follow the main project
- one to manage my updates on this project.

But, the matter is I cannot merge the both root. I need to have the
main project sources in a subdirectory of my own project. My workspace
is as follow: myproject/sub/tree/mainproject

With SVN, I think such things are handled with svn:external.

Actually, with Git, I frequently copy the mainproject inside its
subtree in my workspace.


But, I recently discover that everything seems fine if I include the
Git repo of mainproject inside the Git repo of my project. The layout
lloks like this:
myproject
|- .git
|- sub
  |- tree
    |- mainproject
      |- .git


It seems to work. But do you think such layout is "safe" ?

-- 
Guilhem BONNEFILLE
-=- #UIN: 15146515 JID: guyou@im.apinc.org MSN: guilhem_bonnefille@hotmail.com
-=- mailto:guilhem.bonnefille@gmail.com
-=- http://nathguil.free.fr/
