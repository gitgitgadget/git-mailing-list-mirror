From: Flo <sensorflo@gmail.com>
Subject: git-draw - draws nearly the full content of a tiny git repository as
 a graph
Date: Wed, 29 Jan 2014 22:21:20 +0100
Message-ID: <CAL44uTjD05k4T+wN+TF1oyS162x6OB67pL0MidG5zDYs7qu+5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 29 22:21:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8cZs-0003gP-Rl
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jan 2014 22:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbaA2VVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 16:21:41 -0500
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33260 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbaA2VVk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 16:21:40 -0500
Received: by mail-ig0-f177.google.com with SMTP id k19so5600889igc.4
        for <git@vger.kernel.org>; Wed, 29 Jan 2014 13:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=JsWVUoZ0h0zLzmrXiFSWGOyocRPtkhzY8iFHBiVOuN8=;
        b=z0+26gwNaTvtNN/nkr2f2LsKvYsNJpgcZa2GSgix8BX1vNlkWUQodYFpDlsJKiAGKQ
         AV29ZZt7otK4443sJtEsppnu3KnZpTeAKAisH+a5H9TW125yYD3VwiOjsDbUf5/pWe5x
         f40buDc09grsiCNtd8k78AHylhkyctwBgz7iCeV5jHg4zwvb+yHhxo4GBZE7LM2O4JCZ
         6Ocp+jeBS3c71QLGW5Nxb6hYVKJ3JYZ8lGbemG0QCYIe2S6nt3pqWR7YkOU7ceRLPjrr
         2GwQ22wr6aXYaK8gPilyJZ4oslIHns2iRrkGJXmt+Mg5He7uRAbACwN8P8BZa0L37qFi
         ysgw==
X-Received: by 10.43.180.133 with SMTP id pe5mr2780926icc.71.1391030500227;
 Wed, 29 Jan 2014 13:21:40 -0800 (PST)
Received: by 10.50.97.7 with HTTP; Wed, 29 Jan 2014 13:21:20 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241227>

I just want to present a small tool I wrote. I use it at work to have
a tool visualizing the Git basic concepts and data structures which
"are really really really simple" (Linus' words). That helps me
teaching my colleagues about Git and answering their questions when
Git did not behave as they expected.

https://github.com/sensorflo/git-draw/wiki
