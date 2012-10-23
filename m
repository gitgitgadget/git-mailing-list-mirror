From: Uri Moszkowicz <uri@4refs.com>
Subject: Long clone time after "done."
Date: Tue, 23 Oct 2012 13:30:56 -0500
Message-ID: <CAMJd5AQBbnFqT5xrFuPOEsJevwDE=jUgBVFZ5KqTZk5zv5+NOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 20:31:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQjGE-0005bp-7f
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 20:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666Ab2JWSbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 14:31:18 -0400
Received: from mx71.nozonenet.com ([204.14.89.24]:38438 "EHLO
	mail3.nozonenet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756657Ab2JWSbR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 14:31:17 -0400
Received: (qmail 15194 invoked by uid 399); 23 Oct 2012 14:31:17 -0400
Received: from mail-vc0-f174.google.com (smtp@4refs.com@209.85.220.174)
  (de-)crypted with TLSv1: RC4-SHA [128/128] DN=unknown
  by mail3.nozonenet.com with ESMTPSAM; 23 Oct 2012 14:31:17 -0400
X-Originating-IP: 209.85.220.174
X-Sender: smtp@4refs.com
Received: by mail-vc0-f174.google.com with SMTP id fk26so4574323vcb.19
        for <git@vger.kernel.org>; Tue, 23 Oct 2012 11:31:16 -0700 (PDT)
Received: by 10.52.27.133 with SMTP id t5mr18066513vdg.111.1351017076661; Tue,
 23 Oct 2012 11:31:16 -0700 (PDT)
Received: by 10.59.0.70 with HTTP; Tue, 23 Oct 2012 11:30:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208238>

I have a large repository which I ran "git gc --aggressive" on that
I'm trying to clone on a local file system. I would expect it to
complete very quickly with hard links but it's taking about 6min to
complete with no checkout (git clone -n). I see the message "Clining
into 'repos'... done." appear after a few seconds but then Git just
hangs there for another 6min. Any idea what it's doing at this point
and how I can speed it up?
