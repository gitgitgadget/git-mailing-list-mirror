From: Jakub Narebski <jnareb@gmail.com>
Subject: Gitweb and submodules
Date: Fri, 27 Jul 2007 13:22:49 +0200
Message-ID: <200707271322.50114.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 27 13:30:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEO19-0004TP-B5
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 13:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756259AbXG0L36 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 07:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755404AbXG0L3y
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 07:29:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:57818 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756259AbXG0L3w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 07:29:52 -0400
Received: by ug-out-1314.google.com with SMTP id j3so693329ugf
        for <git@vger.kernel.org>; Fri, 27 Jul 2007 04:29:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MRoKDTCOHNgHLfXhUQoRbEJiIiKeC4a1TyElnamgZYrJc+nZKatDW8Nw8bdHc88rZcPouHU/CnfN0PSchB5nw1BKW674MN7XL0jZqCL4O6o65Uavo1zQ4FmwW1yy/4WiwPJ4KLuEKWUaz+gCnOx+rrDqiRn8qmFcE+WkhLa+Lr8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PLuV41/qhQ2/Zpgm8fh08EP42KrfH1TlvLi+9LTfpyfIzIGFXudXtt9mDAQjRQrodXOyUpyFDWuSn4GgRSOm6p3grnlhpmFdrJ/P/JPEEqOidG7NW6veDl23s8hpIIeGFYHeiA6X7Jmh6zxbREDko6zV22z/njsUYHj//1yo/iE=
Received: by 10.86.77.5 with SMTP id z5mr1912986fga.1185535791342;
        Fri, 27 Jul 2007 04:29:51 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id g1sm9788561muf.2007.07.27.04.29.49
        (version=SSLv3 cipher=OTHER);
        Fri, 27 Jul 2007 04:29:50 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53917>

I'd like to add submodule support to gitweb, among others marking 
submodules as such in the 'tree' view and adding 'log' view link to 
them.

But for that I need a question answered: how to find GIT_DIR of 
repository which contains submodule objects? We have to assume in 
gitweb that repositories are bare...

-- 
Jakub Narebski
Poland
