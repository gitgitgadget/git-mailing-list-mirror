From: robert mena <robert.mena@gmail.com>
Subject: Pointers to setup an internal git repository with access control
Date: Tue, 30 Aug 2011 08:01:44 -0400
Message-ID: <CAAZ43xZPsw2CnqOtb6wO7dRC1eMd0eweQ30w-wfzUHL5cqw=Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 30 14:01:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyN0o-0006MH-Dd
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 14:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398Ab1H3MBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 08:01:46 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47595 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389Ab1H3MBq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 08:01:46 -0400
Received: by fxh19 with SMTP id 19so5285782fxh.19
        for <git@vger.kernel.org>; Tue, 30 Aug 2011 05:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=CZ2XUaQNeTMuCUYfh1corrwYEpc8nv3kaAnzh6qwvZk=;
        b=ZENjwyjSqJk/qfN6QHBmCK1cewRTJ1NxY3GSdomSs4Odw+rdDrZ3l4qu5HGzS2qiEz
         ti+YBNdtR6axi59bro2Uvq6qHy8WYA/5c0wAcb7N6X4qoXXSqZKsibjaQAmpGC8agHtP
         LxzPMCGZVqhZNXzwAiMc+ST1mDcpbrx2KCbio=
Received: by 10.223.56.20 with SMTP id w20mr1027315fag.117.1314705704625; Tue,
 30 Aug 2011 05:01:44 -0700 (PDT)
Received: by 10.223.119.140 with HTTP; Tue, 30 Aug 2011 05:01:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180403>

Hi,

I am trying to migrate from SVN to git and so I am looking for tools
that help me create an interal repository.  I currently use SVN over
HTTPS/Dav using the access.conf to be able to control which uses can
read/write to the repos or given branches.

Ideally I am looking for tools that enable me to do the same with git.

Regards.
