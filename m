From: Lars Hjemli <hjemli@gmail.com>
Subject: [ANNOUNCE] CGIT 0.8.3.2
Date: Sat, 19 Jun 2010 16:42:39 +0200
Message-ID: <AANLkTildyP1bpFuyBTA1FpP1kn2u0z1vJKRDSPenF0Tk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 19 16:42:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPzFv-0001RV-Ls
	for gcvg-git-2@lo.gmane.org; Sat, 19 Jun 2010 16:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756080Ab0FSOml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jun 2010 10:42:41 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:60060 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756054Ab0FSOml (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jun 2010 10:42:41 -0400
Received: by gxk26 with SMTP id 26so413656gxk.19
        for <git@vger.kernel.org>; Sat, 19 Jun 2010 07:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=bjuG5bg7x6ddKIcrVe3Bj5grwTTTd3kDep4MxXY6yp4=;
        b=Oi9cZBBp0ElOqE3syO4DWF7lpeceycsfZySil4fyR2ACZxLJFevgzkiEF24SeAIYPx
         ApoFPC9R7coMiKHQdAEPqC+MDO3Tepr5bqV1/PeQIaWIwgSxy9ZbfMQ3M5uL7hkHKSg5
         SGoWLybRD5s2QH14Zanb1O0oYZbibvvO3Wc5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=hdnqtr4w9+/ZGo9VkZwywHTdZXPwy8lUj/mFyRJdsSGaUGX7HuxhcxiX1zpiUcsysk
         uXL+tmaNlCclBbn0ah3K7cVKCGnjsVfHOZNoEtT4MvOOf3krkauJkkqD9Pcbb1PUdjdY
         IqNh7/bxTwZ4bepyV58nYgGH0lvwXE9B7yH90=
Received: by 10.229.226.135 with SMTP id iw7mr1383538qcb.63.1276958559759; 
	Sat, 19 Jun 2010 07:42:39 -0700 (PDT)
Received: by 10.229.231.142 with HTTP; Sat, 19 Jun 2010 07:42:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149380>

A fresh bugfix-release of cgit (a web interface for git repositories)
is now available at http://hjemli.net/git/cgit.

Changes since 0.8.3.1
=====================

Daniel Milde (1):
      Clear the whole context

Florian Pritz (1):
      ui-shared.c: fix segfault when repo is empty

Lars Hjemli (2):
      shared.c: avoid memory leak during diff
      CGIT 0.8.3.2
