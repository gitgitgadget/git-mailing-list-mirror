From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: A few usability question about git diff --cached
Date: Thu, 4 Oct 2007 14:27:41 +0200
Message-ID: <4d8e3fd30710040527j61152b2dh1b073504ba19d490@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 04 14:27:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdPo2-0007tM-03
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 14:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756144AbXJDM1p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2007 08:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756054AbXJDM1o
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 08:27:44 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:20771 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756005AbXJDM1o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Oct 2007 08:27:44 -0400
Received: by an-out-0708.google.com with SMTP id d31so25810and
        for <git@vger.kernel.org>; Thu, 04 Oct 2007 05:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=bqPejAn10XRJu1Ncxg4YtmHweHWrLu7MyOAFTGgvtYU=;
        b=Gr8CTgI3yTszDUKp0Y0l1CsRg+Z4S5d+j/Ia+IAqN+QyARsgN9MhzTdUE7pKjKZvvLMbU/p7Ixnxq3Wsg2g1o8traKERLHl/Vcs2qv3RDDFn2Ilekl+ELoUy20eSpO/w3RfHEy8yo27IvCAErnXnJse/LFtSbrJS1jLwdmbE+9E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ub+nGfSPFLmnx4bokiMDvtblkGD8cqZNvTlF1vh1p9JDbfpWPRCJzMYsrWfhS5UCdRk419kRFtNlOb7oLgjA0u7+itLAxTdcImfexEdBMv3trQ6o0JLKYwttHHrdBH+HUb1DsRtGgyllu1O8KcW9vjl652qwXMhb/U05h7ETST4=
Received: by 10.142.99.21 with SMTP id w21mr608560wfb.1191500861858;
        Thu, 04 Oct 2007 05:27:41 -0700 (PDT)
Received: by 10.143.43.21 with HTTP; Thu, 4 Oct 2007 05:27:41 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59941>

Hi all,
I'm having and interesting discussion with an happy mercurial users
which started reading the git documentation. He raised aquestion that
I'm not able to answer:

> $ git diff --cached
>
> (Without =97cached, git-diff(1) will show you any changes that you've
> made but not yet added to the index.) You can also get a brief summar=
y
> of the situation with git-status(1):

Why do we have the option "--cached" and not "--index"?

I believe that, just reading the documentation, is not very easy to
fully understand the role of the index and then we have an option
"--cached" that refers to the index.
Is it a good idea to add and document an option "--index" and remove
from the doc the option "--cached"?

Thanks.

Regards,
--=20
Paolo
http://paolo.ciarrocchi.googlepages.com/
