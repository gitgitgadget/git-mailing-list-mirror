From: Frank Li <lznuaa@gmail.com>
Subject: unmerged flag at git diff-index
Date: Wed, 21 Jan 2009 10:13:30 +0800
Message-ID: <1976ea660901201813r7b03525ax39fd0e1ecfb1700e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 21 03:14:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPScJ-0005IC-SI
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 03:14:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754565AbZAUCNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 21:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754191AbZAUCNc
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 21:13:32 -0500
Received: from mail-gx0-f21.google.com ([209.85.217.21]:53622 "EHLO
	mail-gx0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093AbZAUCNb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 21:13:31 -0500
Received: by gxk14 with SMTP id 14so3270189gxk.13
        for <git@vger.kernel.org>; Tue, 20 Jan 2009 18:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=jTIgZ9kG6/MVgti8ACGvYCIkrCAmg/+lWLUGfYaUcNM=;
        b=YI6ZeBjtj7PyLDsu4nzbsnYM0oAZUC3mMeBM/AwaCQEQX12ZZ7iRsTtB+E8Cr4ojgt
         ilY8vTnVDDoy+YD7JvVa5jveDi/r0JyeBs2nydRc2Tpf7T1XntqckxiYLTaadoKQ64w6
         dUBqsq+lj5RUwYdirmVB3q+5guG9EaEJsRexk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=ufScHQedjEKpY0YS2aJhK0TvlNDp0LAPJI2fbhgPnaecuOQZOkXX9hyjnAXZtg9DWA
         vPeKPuDQxD3DeXJL66I6F2lv+lxJbA54VnQCK9MJgT+ayzQCUkY+iTLSNkTiH4+u8qIl
         ODtaPBbW9qBPfD8DDVAttsXeR9C6ovjyc4rEs=
Received: by 10.151.14.5 with SMTP id r5mr12224495ybi.206.1232504010238; Tue, 
	20 Jan 2009 18:13:30 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106558>

There are conflict when I call git merge
git ls-files -u
100644 54d05e1c40c686027b611b702e014284e9ab9a31 1       a.c
100644 a8a1b77c0d92f33491a0a69a8645f02ececb1eb6 2       a.c
100644 642ba972b2234f63048abcca544b3926f94e04ee 3       a.c

but when use git diff-index HEAD
:100644 100644 a8a1b77c0d92f33491a0a69a8645f02ececb1eb6 0000000000000000000000
0000000000000000 M      a.c

a.c flag is M: Modification of the contents or mode of a file.

I think it should be U: file is unmerged(you must complete the merge
before it can be commited)
