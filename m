From: "Francis Moreau" <francis.moro@gmail.com>
Subject: git describe origin ?
Date: Sat, 7 Jul 2007 17:51:58 +0200
Message-ID: <38b2ab8a0707070851m25d615bdn4f7286cbadaf1316@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 07 17:52:11 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7CZu-00088C-16
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 17:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbXGGPwA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 11:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbXGGPwA
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 11:52:00 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:9835 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbXGGPv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 11:51:59 -0400
Received: by wa-out-1112.google.com with SMTP id v27so703304wah
        for <git@vger.kernel.org>; Sat, 07 Jul 2007 08:51:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ezk+qWfDR5AqKxTZsW6kucR07MIm8huRHeI+UlBUAeOkwoIjwY7Wha0sBZdiT/oXjtK/t3qprpVUj/Xu4K8vF0HGynFGNwQOoI0y7p3nnjcweJAXg+yUbCbG/rnPtQ1NF7VRBJ0ektfutIr5gVDOqQm/rkmohV01VZmnlFnTYXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oaMyZnUhcjzt6tJNEUvlBdMqYekQ07W/U5/dVN0WriT84dfBE5VSfVkn1EmViuPsXwYwl89UnmLOmHSGYIHfIADEnzM7tejGuwvl02wR9rc42QYk7OdN1ehtfSu9IkgX4SqpqYqwEisUTm/7+0hYant0N6ikeYcqZ1dWLzSKNC8=
Received: by 10.114.181.1 with SMTP id d1mr1645219waf.1183823518496;
        Sat, 07 Jul 2007 08:51:58 -0700 (PDT)
Received: by 10.115.47.12 with HTTP; Sat, 7 Jul 2007 08:51:58 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51819>

Hi,

I was wondering what does 'git describe origin' command mean on a git
repo. Does it mean ?

    a/ git describe origin/HEAD
    b/ git describe origin/master
    c/ something else

I also played with git remote and did something silly like:

$ git remote add bob /tmp/dummy # dummy does not exist
$ git remote show bob
fatal: '/tmp/toto': unable to chdir or not a git archive
fatal: The remote end hung up unexpectedly
ls-remote --heads /tmp/toto: command returned error: 1

Maybe the output could be improved to be more readable.

Thanks
-- 
Francis
