From: Koosha Khajehmoogahi <koosha.khajeh@gmail.com>
Subject: Multi-threaded 'git clone'
Date: Mon, 16 Feb 2015 14:16:46 +0100
Message-ID: <CACSCj9yoso1oLHzySx1F3O+DFAPiz-XEz1YNCEUMu1pj7KmX7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 16 14:17:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNLYR-0008PC-Ak
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 14:17:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932907AbbBPNR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 08:17:29 -0500
Received: from mail-qg0-f50.google.com ([209.85.192.50]:61663 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932600AbbBPNR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 08:17:27 -0500
Received: by mail-qg0-f50.google.com with SMTP id e89so23212682qgf.9
        for <git@vger.kernel.org>; Mon, 16 Feb 2015 05:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=lz0dBJJ1p5w8iAgRH937itQkOVCMncl+I9wY96jIsxU=;
        b=s+aUD3sXomqaZwGg/XiGnSC5tUnMWDZj5Y2OrPVw4u5memFkKaZzJd91a8LUovAST6
         VI0FAxdH/kWJtTMN0C0I5OvD7LIm2Q76V5SaYSeBVcrNEqjnn4wSbL8HhU33hEuinzdE
         OTcfmkFjQPeh28gPM1eWgO221IgSxZRrPuTx/NJ6Su9Bw8dzwZk5DjKXwCZ0Kkss08Ir
         521ZrLOuefA/sOQGOP9pkFSwl7Hifd/eY2GaFyngQurkNypM0ZxQCDYLYc6ZxC7Tw6WE
         Bwt8YfGbxeRsQUp5tvqKg7S+v7HMXKPjaLcfpKqmv33Xa8Ga1dfaypCx6mlopwwdS586
         hxtQ==
X-Received: by 10.140.94.236 with SMTP id g99mr370644qge.70.1424092646175;
 Mon, 16 Feb 2015 05:17:26 -0800 (PST)
Received: by 10.140.92.179 with HTTP; Mon, 16 Feb 2015 05:16:46 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263898>

Greetings,

Cloning huge repositories like Linux kernel takes considerable amount
of time. Is it possible to incorporate a multi-threaded simultaneous
connections functionality for cloning? To what extent do we need to
change the architecture of the current code and how large would be the
scope of the work? That just seems an interesting idea to me and would
liked to share it with the community.

Regards

-- 
Koosha
