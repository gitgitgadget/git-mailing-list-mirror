From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Tracking CVS
Date: Thu, 22 Jun 2006 08:41:16 -0400
Message-ID: <9e4733910606220541y15d66fa6t33ab0c80ae05f764@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jun 22 14:41:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtOUz-0006mV-Az
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 14:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbWFVMlS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 08:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWFVMlS
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 08:41:18 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:25822 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030197AbWFVMlR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 08:41:17 -0400
Received: by nz-out-0102.google.com with SMTP id z31so394512nzd
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 05:41:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=E5kGJ0NznSBKDramymM0ccuUR0oIuO2E5IV5g5cC9jlOJj4m8VJuhj9nrm0JWFH5pK4N96J3OPNzpKXsNgYh2BZ3H0aggq2VrHNpMgwnaabqNKuFvr1qLVK15dBY80tBXC93IbpQVKz7iWl+UnX7uFekqtFJ8J+mIX9kLLS6UaA=
Received: by 10.37.13.65 with SMTP id q65mr1932590nzi;
        Thu, 22 Jun 2006 05:41:16 -0700 (PDT)
Received: by 10.36.37.5 with HTTP; Thu, 22 Jun 2006 05:41:16 -0700 (PDT)
To: git <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22325>

I'm tracking cvs using this sequence.

cvs update
cg rm -a
cg commit
cg add -r .
cg commit

Is there a way to avoid the two commits? If you do the add with out
the intervening commit it just adds the files back.

-- 
Jon Smirl
jonsmirl@gmail.com
