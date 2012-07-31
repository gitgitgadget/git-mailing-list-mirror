From: Ammon Riley <ammon.riley@gmail.com>
Subject: Broken git-svn tests known?
Date: Tue, 31 Jul 2012 16:44:54 -0700
Message-ID: <CAMvPOPuxdtaQPD6T4M7knPFhQbWGk8psp+DKn4gaHxW48WPFOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 01 01:45:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwM7Z-0003Ii-ER
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 01:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756285Ab2GaXoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 19:44:55 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:46304 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755053Ab2GaXoz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 19:44:55 -0400
Received: by gglu4 with SMTP id u4so6730205ggl.19
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 16:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Zf09UG3vFsmw3ChhSe77diH5fIcOIzToPtRwBZKTCcY=;
        b=lVpPOAgOKo53TpUSUa96dhkUUguOsIFJSqAfCWiQSHrIV4MUjuIiZu8+VoZIC0Ccw6
         J9vtEuJaIHipjgxWuY7JBuiOt9Ywclg+a0maSKMGqsFx26NkwNzmH/HrraUZkqMdD+7m
         WbIQwHve3xFZvA9sXYxXN4/hjWh0XOwDPFpq5auhJ0ltPNPNVb25stmZ9g3j2z7olHWc
         hnH1cfwFnV9x24JhDj54EeZIFWVRkojWG6650EI2fIyHBLACmk45EHzQ46tvFsDtyvO3
         Fk3GgH+DK676ihVvtVlAi25lXm8wiZPk91oXKFikFEc8WVD8BRTsashBXpbFd6rgx3V/
         oyBg==
Received: by 10.66.73.7 with SMTP id h7mr7908976pav.34.1343778294282; Tue, 31
 Jul 2012 16:44:54 -0700 (PDT)
Received: by 10.143.79.1 with HTTP; Tue, 31 Jul 2012 16:44:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202697>

Hi,

On a freshly checked out copy of the maint branch (0e4c8822), the
t9100-git-svn-basic.sh tests are failing 21 of 25 tests. Is this
known, or am I missing some dependencies? Is it possibly due to
using subversion 1.7?

I've run into a small bug with git-svn, and wanted to make sure
the test suite still passed with my patch applied.

Cheers,
Ammon
