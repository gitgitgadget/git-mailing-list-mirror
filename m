From: =?Big5?B?pEG7xL5Z?= <ch3cooli@gmail.com>
Subject: Launch separate program for HTTPS prompt
Date: Tue, 23 Oct 2012 22:39:20 +0800
Message-ID: <CAHtLG6QY-PYUKbNUicox_Ayh70bUSJOL7LGZrQQMqgbVBDmEiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 16:39:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQfdm-00052A-CS
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 16:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211Ab2JWOjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 10:39:22 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:45674 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648Ab2JWOjW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 10:39:22 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so396812lbo.19
        for <git@vger.kernel.org>; Tue, 23 Oct 2012 07:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=gPqLL+FTnXScp9EAVOUtlWAzUIE5icqnRi+jDxCWCz4=;
        b=iUXPzZynDiorAE1RFlJqsYuzKBYJBLUT/rTdzplNLUC874ScvevCf+c3GSxkTN8Irn
         NiBInjQ4hyPFod7l7ox6cJ2MbQqvdrRHTAx/rmTiVBWrdhdnlcnYNRp4KAxw0u8U8k5G
         mTbphre50JhBDp0tFHKiD5I18cJDy7c/doXtlClXKyUjjVlOzWgof5gMwg+gC1oECmsI
         WSWsynjBXKerhSWWXB7Aew38wdOM5V/J2LDTSCnXrXwX3r5AREAaxeGVv5Oox2ij+nLN
         yh3hy7c7GbLE+I9n6QPH2IUyF80zlVojniSg/AnM3EmjUCpaIyRNcBIk5thMcKTBr5iX
         gXiQ==
Received: by 10.152.148.8 with SMTP id to8mr11750842lab.2.1351003160372; Tue,
 23 Oct 2012 07:39:20 -0700 (PDT)
Received: by 10.112.47.71 with HTTP; Tue, 23 Oct 2012 07:39:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208230>

Hi,

Could you launch a separate program for HTTPS prompt like SSH_ASKPASS?
This allows GUI programs to answer the trust or not, not via stdin.

Regards,
ch3cooli
