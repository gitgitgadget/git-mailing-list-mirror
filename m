From: Jon Seymour <jon.seymour@gmail.com>
Subject: git-ls-files --added?
Date: Sun, 24 May 2009 17:54:05 +1000
Message-ID: <2cfc40320905240054j2c08da8bt4df95c6f1bc9e254@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 24 09:57:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M88aW-00064K-S0
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 09:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbZEXHyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 03:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751596AbZEXHyF
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 03:54:05 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:59696 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbZEXHyF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 03:54:05 -0400
Received: by gxk10 with SMTP id 10so4658073gxk.13
        for <git@vger.kernel.org>; Sun, 24 May 2009 00:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=fnvRFD5gr4teaQ+VOCjk8Naz2JIljPLjExfp09JDc+k=;
        b=qssGt/hCpXEZGBxZ9CoxkcYDBPbeXcsYxJWRGc/K0bF9HsiON8ZJ4AVlDRd+5aGvYP
         rsxeGBtax3kx1hYSVxVeNMM9MBuOWQUUAEGOlz+89vClJDOoNj4ZFlMyZWKW549hNhel
         W9dJeui+f7PaG2/ucyH0b+5pWwekt2GgwuNNI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=eFpt1w1p1VVgkwixky1wmHNZXoFBhaCEFvN6EtdmvH0U9ZG8BCCF0BnTfI/Sz3qBo0
         FQvkiREHEwhr+uOKLpI3Ofj66PNfrKjlEdhiUDJAuU+/g9h9ZSDnYI04/OCVCtgBGhP4
         6EeDPnCQ+ehvvVlFC54OLcEKANYTya551onB4=
Received: by 10.150.201.4 with SMTP id y4mr11475470ybf.63.1243151645983; Sun, 
	24 May 2009 00:54:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119814>

Hi,

Is there a reason why git-ls-files does not have an --added option?

I'd like to get a list of new files, due to be committed. Currently, I
have to parse the output of git status to get that, but it seems like
a reasonable function for git-ls-files.

jon.
