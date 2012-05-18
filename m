From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Are author names ending with a dot invalid?
Date: Fri, 18 May 2012 02:14:57 +0200
Message-ID: <CAMP44s2OoxUVFE57e8C2Km7rcGn88KkLXxdaA3s5RE6nZ7TU=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 18 02:15:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVAqv-0006Pw-Ia
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 02:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966588Ab2ERAPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 May 2012 20:15:21 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:60338 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761209Ab2ERAO6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 May 2012 20:14:58 -0400
Received: by lahd3 with SMTP id d3so1711061lah.19
        for <git@vger.kernel.org>; Thu, 17 May 2012 17:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=p0gExBQR3veMT1Hf0Cq9ZRFdHIz9NwqVgDPhC1Ci11c=;
        b=nT/HmjFtENLjsua7ZSEiC2Ploc03NSI+BkjdacJrGByQ9q10Ovg6LSPG0wDJcYkhfG
         jNFAsY5d8mtuZW7Xa4yphO+5ykF6jn2Wqw++7aQjQ1zP19qMl/cBLYcy4nZ7upMAKbXi
         kzMSy0uM6SMfkE4OhWAFYBI+YH2gsMkm9k74cASYbWVF8w3CfJXWZoJVhDaqfAhsCrol
         sRh0V25pl556/AP2fkPq20nbSlpAO856fa6C2xXDj6AWscIuaANuMbOFgBKCjZ8x+IE0
         zX2xP0oM3igID/fLVfF2QyxNQm+n+RuCma8BxK/+zv+5x8ntbdpzZz4Ewp0zLvVx4+1A
         xWvA==
Received: by 10.112.101.105 with SMTP id ff9mr3913903lbb.44.1337300097412;
 Thu, 17 May 2012 17:14:57 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Thu, 17 May 2012 17:14:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197933>

Hi,

It looks like authors ending with a dot ('Foo Jr. <foo@bar.com>') are
converted without a dot ('Foo Jr <foo@bar.com>') is that intentional?

Cheers.

-- 
Felipe Contreras
