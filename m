From: Alexander Toresson <alexander.toresson@gmail.com>
Subject: git diff infinite loop at attempt to diff two specific commits
Date: Sun, 5 Jul 2009 19:37:44 +0200
Message-ID: <b33ba6660907051037ve9e4176s2a1edbda8af4068f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 05 19:37:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNVf0-0000En-G9
	for gcvg-git-2@gmane.org; Sun, 05 Jul 2009 19:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbZGERho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2009 13:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753217AbZGERhn
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jul 2009 13:37:43 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:54979 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050AbZGERhm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2009 13:37:42 -0400
Received: by bwz25 with SMTP id 25so533982bwz.37
        for <git@vger.kernel.org>; Sun, 05 Jul 2009 10:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=97ZS3wyDcfoI4Q1vlFuWNhrlBClKyANLcc0bIc0CCjQ=;
        b=ZJnUVywleSjw8VxS6XjpYUpj+d0J7HGeZ+2ArH6mDnfFkzlmU8Z4TgWOLRa7BJi2Dv
         h6BeXoOrU5QqApoat+S1sJ7up22cj6yQvTQAtNtgQ+S1iYsEl0GWyvHsB/y6WI3nZNtH
         70U1Xz3jbQF1yGjJTODHetaXH3NryIx1C7fIA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=h+5IAuJPB7gFKllsFGL9Xmh0x4q231efSp8sVC8uA6v7gtHX/byp466PcRxLv85RMH
         7DNK45Synwx+yQNmiO4kgvQxr+VmQAiK+OM9dGBl3WfCzdhmNBTX/6LCfMHxZyfJEYkE
         qKG+gwoQAfSuWUYARi46grTaNvqP2R6zTq0L8=
Received: by 10.204.71.68 with SMTP id g4mr3644846bkj.135.1246815464485; Sun, 
	05 Jul 2009 10:37:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122741>

Hello,

I've got problems with git diff, it hangs in an infinite loop when
attempting to generate a diff between two specific commits. Commands
to reproduce:

git clone git://eulex.zapto.org/nightfall.git
cd nightfall
git diff --stat 597711..61a139

(Note that the clone needs to fetch 16mb)

I'm running git 1.6.3.3.

Regards, Alexander Toresson
