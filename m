From: Etienne Girard <etienne.g.girard@gmail.com>
Subject: Git-p4 fails with NameError with python 2.7.2
Date: Tue, 20 Oct 2015 12:34:38 +0200
Message-ID: <CAJA=mv5Kdsn1YEo4sUAwpTv=0Jc8Xg5V2WPMoCmsxNL4Hnk=kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 20 12:34:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoUFg-00047u-0M
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 12:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258AbbJTKek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 06:34:40 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:34750 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279AbbJTKej (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 06:34:39 -0400
Received: by iow1 with SMTP id 1so16903989iow.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 03:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=RllBlEizp+JMHjC6J1obdNFy5GXJ/uDLAO2eGfl4XIQ=;
        b=Lg0H42rRn9teYWrNLOXGVSpMkmjRUWDai1MhmmSZB1ssrOmOrJfDGUR87XGJ4p3a7k
         0NGdc7KsLMl8CIUhArDCYnTGFvbXo4JOC0DGhUpSlyejuXoOmPd7mE03pXZTWwMadAmW
         4ivrJaA4wxvUW4ePJZCPPvwc0MWESzjuYosJ7gDevNNGQz8b66Wo7SELWvG3OA1YC0PZ
         oby25Y98wr0OSef3xIveERKnx8Rg8Qqh/ACx4ZGWYiKilLC1eSrr3kcaVLKEoJblQJ5G
         VPrknMUDfQ9kJzZWYFG2R2vBVDNYS6UCN08lG0uW5AT1wjCh01OaXn5XyS8v5kuiH3l9
         5ZKg==
X-Received: by 10.107.154.213 with SMTP id c204mr2831705ioe.80.1445337278339;
 Tue, 20 Oct 2015 03:34:38 -0700 (PDT)
Received: by 10.64.87.170 with HTTP; Tue, 20 Oct 2015 03:34:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279904>

Hello,

Git-p4 fail when I try to rebase with the error: "NameError: global
name 'ctypes' is not defined". The error occurs when I use python
2.7.2 that is installed by default on my company's computers (it goes
without saying that everything works fine with python 2.7.10).

I'm a beginner in python, but simply importing ctypes at the beginning
of the script does the trick. I was wondering if submitting a patch
for this issue is worth the trouble, when a satisfying solution is not
using a 4 years old version of python.

Best regards
