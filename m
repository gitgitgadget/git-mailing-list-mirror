From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: format-patch signoff argument no longer works
Date: Wed, 31 May 2006 20:41:51 +0930
Message-ID: <93c3eada0605310411r712dab8au9b1c7d8ecb595a66@mail.gmail.com>
References: <93c3eada0605310332p19241861g466e1516a2aaf0df@mail.gmail.com>
Reply-To: geoff@austrics.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed May 31 13:12:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlOcG-0004W1-8r
	for gcvg-git@gmane.org; Wed, 31 May 2006 13:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWEaLLx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 07:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbWEaLLx
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 07:11:53 -0400
Received: from wx-out-0102.google.com ([66.249.82.195]:24090 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964987AbWEaLLw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 07:11:52 -0400
Received: by wx-out-0102.google.com with SMTP id h27so3995wxd
        for <git@vger.kernel.org>; Wed, 31 May 2006 04:11:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tRHjYNanxrD4HC3C9l4YQ7XcU2/M4+wF48wq5oFGr3ksqCJF93jukHlvDhMX5NRI+se3oBwDxb3OAXyequc8OwZRfpzl/ESfDPmbynPJNYmbKcsnonKtJC5T29IVG0V84RqTR7lMCEf+ZHPA19lqT4c7FL0jLpswiTfaYhSWPGs=
Received: by 10.70.96.18 with SMTP id t18mr33944wxb;
        Wed, 31 May 2006 04:11:51 -0700 (PDT)
Received: by 10.70.32.19 with HTTP; Wed, 31 May 2006 04:11:51 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <93c3eada0605310332p19241861g466e1516a2aaf0df@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21061>

Hi,

The --signoff argument no longer works in git-format-patch.  Was this
intentional?
It still appears in the documentation for the command.

It appears to have got lost when the shell script got converted to C.

Cheers,
Geoff Russell
