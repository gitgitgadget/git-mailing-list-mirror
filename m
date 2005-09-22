From: Robert Watson <robert.oo.watson@gmail.com>
Subject: uncommon shell code
Date: Thu, 22 Sep 2005 15:32:43 +0100
Message-ID: <72499e3b05092207326abadd91@mail.gmail.com>
Reply-To: Robert Watson <robert.oo.watson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Sep 22 16:37:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIS81-0003ee-5q
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 16:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbVIVOcq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 10:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbVIVOcq
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 10:32:46 -0400
Received: from qproxy.gmail.com ([72.14.204.198]:12889 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030363AbVIVOcq convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2005 10:32:46 -0400
Received: by qproxy.gmail.com with SMTP id v40so58170qbe
        for <git@vger.kernel.org>; Thu, 22 Sep 2005 07:32:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gqPgKnOiY5fscq+iScAZ5ySa6m+1/wk1/zCmkA04ycTw+Kwe4ULXPliPlGTrcNIbtStjDbj3CoodR66t6abKR7fCJn50LrQDufeaP0m/pXezUr+RwH6TlsQBTDNSEJbBno0k/fqGc4LUxxhd8V/nPk6LKHsm8JWnz6t7Y8Zy0qI=
Received: by 10.64.195.14 with SMTP id s14mr167339qbf;
        Thu, 22 Sep 2005 07:32:43 -0700 (PDT)
Received: by 10.64.203.14 with HTTP; Thu, 22 Sep 2005 07:32:43 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9121>

Hi,

I found the following shell code in git-tag.sh (and others):

while case "$#" in 0) break ;; esac
do
  ...
done

Why not use the straight forward code:

while test "$#" -ne 0
do
   ...
done

Are there any functional difference between them?

Robertoo
