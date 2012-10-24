From: Uri Moszkowicz <uri@4refs.com>
Subject: Large number of object files
Date: Wed, 24 Oct 2012 00:21:11 -0500
Message-ID: <CAMJd5AS1=Cf--0=1Xynxf1J-22fxBq05XjNGMcUep+ndAOO7ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 24 07:21:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQtPV-0001Wr-VS
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 07:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753637Ab2JXFVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 01:21:34 -0400
Received: from mx71.nozonenet.com ([204.14.89.24]:40498 "EHLO
	mail3.nozonenet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750719Ab2JXFVd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 01:21:33 -0400
Received: (qmail 19710 invoked by uid 399); 24 Oct 2012 01:21:32 -0400
Received: from mail-ie0-f174.google.com (smtp@4refs.com@209.85.223.174)
  (de-)crypted with TLSv1: RC4-SHA [128/128] DN=unknown
  by mail3.nozonenet.com with ESMTPSAM; 24 Oct 2012 01:21:32 -0400
X-Originating-IP: 209.85.223.174
X-Sender: smtp@4refs.com
Received: by mail-ie0-f174.google.com with SMTP id k13so170021iea.19
        for <git@vger.kernel.org>; Tue, 23 Oct 2012 22:21:32 -0700 (PDT)
Received: by 10.50.169.35 with SMTP id ab3mr1426301igc.8.1351056092044; Tue,
 23 Oct 2012 22:21:32 -0700 (PDT)
Received: by 10.64.15.7 with HTTP; Tue, 23 Oct 2012 22:21:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208285>

Continuing to work on improving clone times, using "git gc
--aggressive" has resulted in a large number of tags combining into a
single file but now I have a large number of files in the objects
directory - 131k for a ~2.7GB repository. Any way to reduce the number
of these files to speed up clones?
