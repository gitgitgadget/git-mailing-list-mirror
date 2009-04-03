From: Changsheng Jiang <jiangzuoyan@gmail.com>
Subject: How to init a empty repo for pushing?
Date: Sat, 4 Apr 2009 02:17:33 +0800
Message-ID: <eafc0afe0904031117rbfd55cft5f40f1b45df1e454@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 03 20:25:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lpnzz-0003E3-V6
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 20:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934704AbZDCSRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 14:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757925AbZDCSRx
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 14:17:53 -0400
Received: from ti-out-0910.google.com ([209.85.142.188]:54981 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381AbZDCSRw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 14:17:52 -0400
Received: by ti-out-0910.google.com with SMTP id i7so1141454tid.23
        for <git@vger.kernel.org>; Fri, 03 Apr 2009 11:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:received:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=KuyVd6jaTT1OBLRoAjcxd68n+Y0GDXal/GwWwbMhi2A=;
        b=btuzVuiKZYU+CXfItSN7AWXH+D49BJ23EiDFKTAwNqLh1zh35QNu2zQHIuT4DLd+lo
         Hc8uSb6nfp02WXx+kR72m0MGVAmPHGuia6LHuzwPQA0LdvIZCCW55njIfxImTi25YGWE
         89mgRlJZagFT89H/6ScKAmHrq5W6yzuQ6tdg8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=GTIrMoJzllNSR6j1W7osJ/RUtwt11dhjX2yJdQ+t4lK21rCfpdbuyNqWTJKp+I5gge
         fpm7lE6m6pshTimiGUekPQHR9Wshh5V41smkG63xVcaJvbZvHyPn28KoOA/eVV/cmr7G
         HhtUVsRi0AWAuLBRii+09tODQpAB0cCAE1Wew=
Received: by 10.110.57.5 with SMTP id f5mr2078382tia.34.1238782669416; Fri, 03 
	Apr 2009 11:17:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115550>

Hi list,

I have a repository in my laptop, and need to push the repo to a
remote server using ssh protocol.

I know how to init a original repo. But the repo in the server is not
original, the laptop repo is.

Just 'git init' in server, then 'git push server' after 'git remote
add server ...'  in laptop gives error.

Thanks,
Changsheng Jiang
