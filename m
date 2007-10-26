From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: stg branch --create test v2.6.24-rc1 doesn't work
Date: Fri, 26 Oct 2007 16:12:53 +0530
Message-ID: <cc723f590710260342t5fd0bdc3nc1ea5198cea1a604@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: catalin.marinas@gmail.com, kha@treskal.com,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 26 12:43:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlMf5-0005Lg-1w
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 12:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbXJZKm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 06:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752364AbXJZKm4
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 06:42:56 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:14158 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365AbXJZKmz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 06:42:55 -0400
Received: by wa-out-1112.google.com with SMTP id v27so970596wah
        for <git@vger.kernel.org>; Fri, 26 Oct 2007 03:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=tK2TfwXor3fQfxv0tmgFHd2Fr5CQkWdaq+Oi4zW4d0U=;
        b=fp14EWjGtW/KO3SFiNnUtxVZorxx2+xzs5w7iqzu1FwqanpDZZsKgxqLVB9slM8iQXdXQdJMgRBMLiwAQSEJnkiXbG/U4sg2FfcSxtwg2C0+ynXFP9kaPQXE78VChFOiw13SZXNXMcGk8kt0dqLMlcQkzivjl4LQsxDo8FrOJQo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RxAQAhHZaOK9oDAaozdQY9drMnzRgt0dkzActQ14ek2uQMFHsheqNEsc3EfjZaeQE8zuh1vIlhdg41QuffGYCwWgNqflnA+MHPNsXfGJlR4ecyWsrTJfonrrzNHXi800RlKCkrHRoneZbGrzSpmGirVPsTZiwp5ckPYAEFHUGFU=
Received: by 10.115.94.1 with SMTP id w1mr3290156wal.1193395373905;
        Fri, 26 Oct 2007 03:42:53 -0700 (PDT)
Received: by 10.115.48.11 with HTTP; Fri, 26 Oct 2007 03:42:53 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62407>

$ stg branch --create test v2.6.24-rc1
Checking for changes in the working directory ... done
Don't know how to determine parent branch from "v2.6.24-rc1"
Branch "test" created
[test@linux-review-ext]$ git log


Throws an error/warning in the above command.

Also import then gives

[test@linux-review-ext]$ stg import
/home/opensource/patches/ext4-patch-queue/ext4_mballoc_freespace_accounting_fix.patch
Checking for changes in the working directory ... done
fatal: cebdeed27b068dcc3e7c311d7ec0d9c33b5138c2 is not a valid 'commit' object
stg import: git-commit-tree failed with code 128
