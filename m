From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: git-reset man page
Date: Sat, 10 Nov 2012 10:55:13 +0100
Message-ID: <CAB9Jk9AdTBJotrB0fndZawMWH6hS4PW_5bHwecwY5Vz7=TnYAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 10 10:55:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TX7mn-0003X1-Vz
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 10:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805Ab2KJJzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 04:55:15 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:34992 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704Ab2KJJzO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 04:55:14 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so3046163qcr.19
        for <git@vger.kernel.org>; Sat, 10 Nov 2012 01:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=FMdLJdMR8XX4neTowWntlV8qV7qTLwEc04Io0ec4y0s=;
        b=ICXSWNWWdEkjj7yYdOQNadRo9gpX4wk8j65iuGCcU1WaKRIvWaqLiOaRiT87rE+aDV
         Us8E+/LKZETnEoBFQJPvkDCuQjkSb6W1IqOUl9IWhPU63VqNGQt5nlfNg8J2Q6/TclDF
         jyIu2qYH/pCxHTNQtRJzPfGoe5O1sronYESNmb+pR3B/hbp/LiqwBSY3oOAqmHG5UXH0
         9GKXaj+Hdkgf9pLxvcpPFhidsiG5I2tHxq3PCEyAVgTP6WDWgpON6suquLPpJccuc34Y
         +1zpoqKaCMGMi5gQjJts5YpAxUgoAgEZT9ACLjz+SbOPd4QBLhLfEqBUoh/a4x57rLvy
         Q7Kw==
Received: by 10.224.70.140 with SMTP id d12mr18693634qaj.53.1352541313208;
 Sat, 10 Nov 2012 01:55:13 -0800 (PST)
Received: by 10.229.77.96 with HTTP; Sat, 10 Nov 2012 01:55:13 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209266>

Hi

the man page of git-reset, synopsys, does not allow for an
argumentless call, and the description does not tell either what is
the meaning of it.
Suggested changes:

first line of synopsis:

      gitt reset [-q] [<commit>] [ [--] <pathspec> ...]

Description: append to the end of the first paragraph:

     "If no <pathspecs> are specified, all the index entries are reset."

I would suggest to change <paths> with <pathspec> in all the man page
because paths in the glossary are called pathspecs.

-Angelo Borsotti
