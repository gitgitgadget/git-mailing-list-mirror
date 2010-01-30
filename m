From: "fkater@googlemail.com" <fkater@googlemail.com>
Subject: migrating to git: keep subversion revision numbers (as tags?)
Date: Sun, 31 Jan 2010 00:08:29 +0100
Message-ID: <20100130230829.GA3544@comppasch2>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 31 00:08:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbMQj-00033V-7s
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 00:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754104Ab0A3XIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 18:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753058Ab0A3XIf
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 18:08:35 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:63822 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047Ab0A3XIf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 18:08:35 -0500
Received: by fxm20 with SMTP id 20so3073579fxm.21
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 15:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=ZhqJt2UnTQbmD3Bdwr9FoAIwMNZ+j55W3ohmp1tMCMQ=;
        b=tKOKDbMOESo1WuBIrCml9ZgXWzcnmSPd0fRJ1S0dP13wBVL9z7nm6ndE7Ur+IwBE+7
         aYbQ9TEqOmHe7afmoYenTO/XSpOJjrICaOeueufskfcLezraxM6JG1rUf3d7VtQcTu+o
         /+GVuh5yLgh1V7XmhnZ8NMucrhaJ50lN0ufrI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=RvF0jzrkxiRPGPBwF/qD/iIL2t/oaVm2m9tT4IYx48AbO9wKjp2iZ9tYeSTVlFY2jj
         uSdzwI85cvuo1MYZOtPjtHNE3aF/i9VojzsotPM5tt6fFcF2OzgFHHGfCnPn9Sbj5bqA
         kFgyYS1cCQgkBIhziKbjcLQd+JQ5ogWVNc2ks=
Received: by 10.103.122.22 with SMTP id z22mr1223904mum.68.1264892911233;
        Sat, 30 Jan 2010 15:08:31 -0800 (PST)
Received: from googlemail.com (p4FC1D569.dip.t-dialin.net [79.193.213.105])
        by mx.google.com with ESMTPS id j2sm14758741mue.2.2010.01.30.15.08.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 30 Jan 2010 15:08:30 -0800 (PST)
Received: by googlemail.com (nbSMTP-1.00) for uid 1100
	(using TLSv1/SSLv3 with cipher RC4-MD5 (128/128 bits))
	fkater@googlemail.com; Sun, 31 Jan 2010 00:08:30 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138517>

Hi,

I would like to completely migrate from subversion to git
(and NOT have subversion enabled anymore). However, I need
to be able to lookup the old subversion revision numbers
later from the git repository. The default seems to be
though, that they are replaced by git sha-1 keys.

It would be completely o.k. here to use git tags for all
those subversion revision numbers (if possible), so, to
create a tag for each subversion revision. However, I have
neither seen any option in git nor found a script which does
that upon cloning (converting) a subversion repo into a git
repo.

Is there a way to do so?

Thank You
 Felix
