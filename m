From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Add warning when there are changes in the index and using -a with git 
	commit
Date: Wed, 21 Apr 2010 22:20:35 +0200
Message-ID: <v2m7fce93be1004211320r9adc0b14j11bd06c3b045e639@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 21 22:20:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4gPb-0004XV-8y
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 22:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756332Ab0DUUUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 16:20:38 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46696 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754824Ab0DUUUh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 16:20:37 -0400
Received: by wyb39 with SMTP id 39so4324559wyb.19
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 13:20:36 -0700 (PDT)
Received: by 10.216.170.71 with HTTP; Wed, 21 Apr 2010 13:20:35 -0700 (PDT)
X-Originating-IP: [80.13.22.90]
Received: by 10.216.87.18 with SMTP id x18mr157417wee.85.1271881235966; Wed, 
	21 Apr 2010 13:20:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145451>

Hi,

Many times I had the bad reflex of doing a git commit -as -m "blah
blah" when I was willing to commit only things I had staged in the
index.

It could be useful to add a warning and a prompt when using the -a
option with changes staged in the index to avoid errors.

Regards.

-- 
Sylvain
