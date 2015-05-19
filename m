From: Stefan Beller <sbeller@google.com>
Subject: test suite failure t5570, 8 with v2.4.1-168-g1ea28e1
Date: Tue, 19 May 2015 10:20:04 -0700
Message-ID: <CAGZ79kY61ZJHHG4jj2hZSzXZ58fh9R9b8hOijaCTGxTu8dtN=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 19 19:20:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YulBb-0003MB-L1
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 19:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbbESRUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 13:20:06 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:37978 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbbESRUF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 13:20:05 -0400
Received: by igcau1 with SMTP id au1so19574097igc.1
        for <git@vger.kernel.org>; Tue, 19 May 2015 10:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=g2ebaEjQzPf/6hjt9pfO8mxG5LMcw/hXkjLzP+aUfOI=;
        b=WFubJoMGYLtfJUEJvU4XKIu2kV0HJGHf3NJ/eo5uHmN9yofARIfkaOWAJUydV8vr7+
         2/Pb79R9oHTKHLiPvJwyaDjMaS6MPb/aNjL6c4IxyF/+0Wl/q3iU/cKDbiaTd3czX1k5
         y2ZO7tndwckWHr6lPu11hElvFUm+vlmbbCnGg9uUM2g8D3AUrh2WAcJRy97UY6QiftOV
         LcLRXQdSkoCgRkvd4XNJDCyr6L63+W8r8n/oUU1yfdB7igYe6DKqQokb+5aWm9/yHCqi
         V0MllPuMQaqs1m2p/w4qwAyKfuyY2SZcpkRQiY3WLF+8Cnly6leZq4C8wex720tQDRCw
         poGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=g2ebaEjQzPf/6hjt9pfO8mxG5LMcw/hXkjLzP+aUfOI=;
        b=ZK9t/F1Ij9W64dADS+K4UlGLk3e7lLRmL1jBylTAmr3YOyDtwnXkwPaT4jS/8Sor1f
         04S7BWiFqUnHhqAMbRaFrk3HXcm1Tmh9jcrx38qvvrK4cEi2i/hwLMrWxzuH+tOnizIV
         3cNeO0mSHXFbx9XOHIz5A2VyshkuI499DkceUmMfiDBCVH0e73PvplbashJbqGToidkA
         Muy1UW4SZeajKqG2PrnzQhE03lYfV/3qfwvOUwYLfrIyNQkN7kyM8tGXnVQmOL07M7cU
         CF+nlk8jlYpuRM5mpc6cxbuZlQFOKUg3/uyXnr7dzGZcfdL7n6sFjv4tx6imGwZX7KuN
         xnVQ==
X-Gm-Message-State: ALoCoQne2inGL7j7JBGZkm1lZJZ2r2JfkMJi2748iXsM5TR3cTH0aeSfe1BJw2ZDux3ngsn7bmww
X-Received: by 10.42.213.136 with SMTP id gw8mr41720750icb.95.1432056004672;
 Tue, 19 May 2015 10:20:04 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Tue, 19 May 2015 10:20:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269374>

Hi,

so today I am running make test (no special flags I am aware of) on my
ubuntu machine using
git v2.4.1-168-g1ea28e1 and t5570-git-daemon.sh (not ok 8 - fetch
notices corrupt idx) fails.

Any hints?

Thanks,
Stefan
