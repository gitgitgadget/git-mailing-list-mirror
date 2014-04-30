From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: [ANNOUNCE] tig-2.0.1
Date: Wed, 30 Apr 2014 08:26:01 -0400
Message-ID: <CAFuPQ1K91K20kbuTVO8ZnKz8kPDBZ26fSe0fWQM2XsWqkmhMGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 30 14:26:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfTal-0008MC-3X
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 14:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933589AbaD3M0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 08:26:22 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:51421 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932715AbaD3M0V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 08:26:21 -0400
Received: by mail-oa0-f43.google.com with SMTP id eb12so1842619oac.16
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 05:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=+SU9/PPnz/NFEfexvFGjRupQRnGLMJ2S2aXHOJjukcY=;
        b=UF9pFQdwszIBzJIb6B+EZALosIh9I1W5mVYyQTIbWp5nKeexFQRg5lg0P1WTp335Bl
         46izQws2JHK1rHIPZJjnodhh1+g1eaEfZg0wMHLdPSL1mkPgbiWpuqz9AEn3s+0J11X1
         rWFjiYxOnATqgU+maI0CDuqyhC9L8FrmBlZOPf2AyJG1B97LAmJwP8gutIeyWjOqw5u4
         VeotrVn+cHkufCmJsIt3/Qu8SRAWOG73XOb/rvhjgoYFBSkHjZwKA7mU4Yi/oR4ZSr+R
         IxuuXePE8yL2GZReiJHk0O2hH1NO+3CSkb5GsmkhdDEMlZqMpllfF05nk6zGA3EdBcS9
         g1lw==
X-Received: by 10.60.103.210 with SMTP id fy18mr1258183oeb.75.1398860781156;
 Wed, 30 Apr 2014 05:26:21 -0700 (PDT)
Received: by 10.76.8.3 with HTTP; Wed, 30 Apr 2014 05:26:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247708>

Here's a small bugfix release to fix some *blush* last minute changes.

Release notes
-------------
Bug fixes:

 - Fix compilation in watch.c.
 - Fix parsing of key bindings mapped to '^' and '<'. (GH #280, #282)

Change summary
--------------
The diffstat and log summary for changes made in this release.

 Makefile    |  2 +-
 NEWS.adoc   |  8 ++++++++
 src/keys.c  | 10 ++++++++--
 src/watch.c |  2 +-
 4 files changed, 18 insertions(+), 4 deletions(-)

Avinash (1):
      Prevent throwing errors if single '^'(circumflex) is used in config

Jeff King (1):
      Fix compilation error in watch.c

Jonas Fonseca (2):
      Improve pretty printing of ',' in the help view
      tig-2.0.1

Yasuharu Ozaki (1):
      fix <LessThan> binding support

-- 
Jonas Fonseca
