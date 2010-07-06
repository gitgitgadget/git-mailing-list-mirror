From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: messages confusing
Date: Tue, 6 Jul 2010 07:35:43 +0200
Message-ID: <20100706053543.GA13054@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 06 07:36:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW0pL-0007Yz-Ur
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 07:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525Ab0GFFfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 01:35:51 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52098 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684Ab0GFFfu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 01:35:50 -0400
Received: by bwz1 with SMTP id 1so3204025bwz.19
        for <git@vger.kernel.org>; Mon, 05 Jul 2010 22:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=8GM77GUUA8mY7NE+8fe9ggcZxm9TzBwFp5CDYxSN92A=;
        b=CzgjHdIPoFu5YY038uGrsoYILU09fAw+z3gFa8lLWWwQiOwhK2qynwym145btpmJVy
         DExqs2D+M98tsIPuQ+EUYFPgCtx+HRYNnWnFP86i+4beHZ2eGp+kKR0fD+OLxs6d+kqP
         k4vK1DdILFGBq6SkhFHyHI+mVxCo67k81jYHc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=Y7PPTdQbjC9BD3SVO2dcijZzZ1aDXmF+c17DU/QZMr47kwVdTFEsrzVm/ES6V0wRtn
         aIrZ+6MBoHa6dlcHN6uimakSLLuPoxwYiyeNWtdc9ut2bVB5F07Y/02LBHahhf11qViZ
         6WPxKg+nLctJ/eSKUIuMHVbgkShWyJEFfmqiU=
Received: by 10.204.47.99 with SMTP id m35mr3170413bkf.106.1278394548167;
        Mon, 05 Jul 2010 22:35:48 -0700 (PDT)
Received: from vidovic (aqu33-8-83-155-187-36.fbx.proxad.net [83.155.187.36])
        by mx.google.com with ESMTPS id f10sm21224814bkl.17.2010.07.05.22.35.46
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 05 Jul 2010 22:35:47 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150320>

Hi all,

I had those messages today

  % git merge origin/master
    Already uptodate!
    Merge made by recursive.
  %

with git version 1.7.2.rc1.210.g7b476 and I wonder if it is really
intended.  It did create an empty merge commit but I find both messages
together a bit confusing here.  Why would Git merge if uptodate?

I don't think I will have time to investigate in the comming weeks but
you should be able to reproduce it by following these steps (it is by
now, at least):

  % git clone git://github.com/nvie/gitflow.git
  % cd gitflow
  % git merge origin/master
  %

Thanks,
  
-- 
Nicolas Sebrecht
