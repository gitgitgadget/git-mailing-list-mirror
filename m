From: Brian Craft <bcboy@thecraftstudio.com>
Subject: command return values
Date: Sat, 10 Jul 2010 21:11:18 -0700
Message-ID: <AANLkTimQcqhD8FClAXef5dGAWRDbAGdVBmIVXxotzKoa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 11 06:11:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXnt9-0002IC-Kf
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 06:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763Ab0GKELV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jul 2010 00:11:21 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:52686 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735Ab0GKELU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 00:11:20 -0400
Received: by pvc7 with SMTP id 7so1377300pvc.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 21:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=/MVxtmoABiDrBSXxWgf+Kd3PrlU+hE1YE8gbItnLXvM=;
        b=rD0JutQCYWWwoBu3seSXOtbraZwTHPI1wNdJUUUEZ8oZZ9vst2J7Z/DE5b0HCrpFXc
         FCkgksXMzkaE814OX/wgOBm4XQo0cmpxPwsNXCcejAf7bjRM+L0hTFPvkBbeUytycvUw
         Ci2xhsgSf55h8Ub2tJUMDD6u3URkJxNAA0R/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=rKwSK/j/65EFSczfAtVP8BHHDFryYEJv04BRIbcyXO+0e3roDXitJq20ByHjyB1+Kk
         2q00P1tZulF61Sp/7Lkg2ffRGYOXoy2tTcDVcJD4NF/uzM9kkETAFaynDXgc73IbgJ+3
         IQSyy+qnBf8vde86CzZs3igp/6wzzADDThWcs=
Received: by 10.142.225.8 with SMTP id x8mr14309520wfg.290.1278821478824; Sat, 
	10 Jul 2010 21:11:18 -0700 (PDT)
Received: by 10.143.7.4 with HTTP; Sat, 10 Jul 2010 21:11:18 -0700 (PDT)
X-Google-Sender-Auth: TC1yPqskceIr5-txzkI5xivQguk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150740>

btw, the "faq" link on http://git-scm.com/ is broken.

I'm finding that "git clone" doesn't return useful error codes, e.g.
trying to clone from a bad repository.  Also, it doesn't abort if you
try to clone a branch that doesn't exist. The command succeeds,
leaving you with the wrong result. I haven't found a way to tell when
the command really succeeds, except for scraping the output.

What's the deal?

b.c.
