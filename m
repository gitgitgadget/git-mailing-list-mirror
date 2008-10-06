From: "Adam Mercer" <ramercer@gmail.com>
Subject: files missing after converting a cvs repository to git
Date: Mon, 6 Oct 2008 17:02:44 -0500
Message-ID: <799406d60810061502y417ec53o1a1f5cef800dfe45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "=?UTF-8?B?77u/R0lU77u/77u/77u/77u/?=" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 07 00:04:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmyBP-00065b-1W
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 00:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606AbYJFWCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 18:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752738AbYJFWCr
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 18:02:47 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:50531 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580AbYJFWCq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 18:02:46 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2984271wfd.4
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 15:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=LUfL5pOZUCjvwelSLMeAl72P0Z6crTsclYtyD2jWJ88=;
        b=rTeGoZh9KvM1JCL1USe5dyr7OhEDuWUchChse5jgb7wKb49+AWVaaQT0ucdIvd+a9J
         CJx8OI7zPBAgoeRfpPcVM9kkFr1W9fXxWQTIxRVriRPt/N+BJNeeUs90zk7uXL+ZU+x7
         mUSqZm9f/1+Tzou044SWYDXHX4SBpqLfSMN2U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=l/nIhseORFrCz6YrpRDNhukk7lnOv8OdFminhXrdvjpBVhOqwrtV7BFJJyGmEUehN0
         mKAN39HkIYyxjzBQzHrJEf99c5xZyOUYZsEW914pSb1U/bmvgYBGUUO/7TDWmKnVszne
         syrCcKQAdvJjtPmujOWxrWO3KdFq61YAqegxk=
Received: by 10.140.188.19 with SMTP id l19mr3414219rvf.79.1223330564318;
        Mon, 06 Oct 2008 15:02:44 -0700 (PDT)
Received: by 10.141.28.18 with HTTP; Mon, 6 Oct 2008 15:02:44 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97636>

Hi

One of the prrojects I am involved with is currently looking into
migrating from cvs to git, therefore we have been investigating this
by setting up a git repository that tracks cvs, however there are some
very strange things going on and I was hoping someone could offer some
insight into what is going on.

I use the following git cvsimport command to import the repository:

$ git cvsimport -v -a -i -k
-d:pserver:user@server:port/path/to/cvs/repo -C /path/to/new/git/repo
module

this ran successfully with no warnings or errors. However, when I
checkout the new git repository that are several files missing from
the git checkout that are present in the cvs checkout.

Does anyone know why this would happen, or how to find out? This is a
major problem because we will be unable to migrate to cvs until this
can be solved.

Cheers

Adam
