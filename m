From: Felipe Tanus <fotanus@gmail.com>
Subject: [GSoC] Improving parallelism
Date: Sat, 17 Mar 2012 19:18:09 -0300
Message-ID: <CANELHzNc+28ZDiZ69zv3X0DJMf0DTkiZXQD1-32Wsy-=vtWDhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 23:19:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S91xo-0000FV-On
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 23:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965210Ab2CQWSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 18:18:32 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:52670 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965079Ab2CQWSb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 18:18:31 -0400
Received: by wibhq7 with SMTP id hq7so2339404wib.1
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 15:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=gLUBcRyrFfBqWIG7Ti3cL/27FgOwdtCQNmb1ij0vdeQ=;
        b=WP/uUvZgfnKUZMwxBrEGJh+YoBYCIBed9fq4zx+qKkqp8dIEZXWUtkJI3WgPJUR0vY
         wl9oxJaSAJmhNxor/pM9cqm1FfnM07iUI2V3KOlcklhOUzlvp7rHVd+PhqTINKVnw6Fj
         Bv2IvwpbUqhnGzYBSTlSWydGRq28Nc7GQXp3eLLhgccK/5LmOVUcSa+VXxj6IZxJ6hvL
         8h5dV+ZHsOpFoUwMXWtFFkH9Et0EOZ2Ojru8bqKKoe91p4IAhv83E89I3tbgK6919GNx
         0C07wGD1G6YZfj/CZLJ9SDHAXdpvsoP3kECFz/RZxMQ91LqIFuD2CXVMXhJbAMRH2DW8
         PETw==
Received: by 10.180.83.72 with SMTP id o8mr8635286wiy.5.1332022710072; Sat, 17
 Mar 2012 15:18:30 -0700 (PDT)
Received: by 10.216.26.4 with HTTP; Sat, 17 Mar 2012 15:18:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193352>

Hi,

I'm looking forward to joining Google Summer of Code through git. Some
short words about me: I'm an undergraduate student of Computer Science
in UFRGS, Brazil, and also work part time in the onthegosystems
company from home. In the past couple of years, I participated in
GSoC: The first in the boost, and the last on macports; in both years
my projects were evaluated as successful. I'm a git user for nearly 3
years now, and this is my first e-mail to this mailing list. If you
want to know more about me or check some references, please visit my
Site at this mail signature. Also be welcome to make any questions.

My proposal will most likely follow one of the proposed idea entitled
"Improving parallelism in various commands". I'm very used to C
programming, and pthreads is my friend, so I'm the right guy for this
job. The downside is that I never looked at the git source code
before, and I expect the most challenging step from the project is to
find where parallelism can be further explored. For this, I count on
my skill in C programming, a good mentor to help me to go through the
code and evaluate my ideas.

I find the idea of the proposal straight-forward, and no doubts pop up
in my mind, except on what commands can I work on. The idea described
in the wiki tells that the commands "git grep --cached" and "git grep
COMMIT" need this improvement, and most likely "git diff" and "git log
-p" need too. That is a good start, but if you know already other
commands that might benefit from this parallelism, please tell me in
order for me to include in my proposal. I also plan to use the
community bonding time frame to look deeper in the code searching for
what can be improved, and In my schedule, I plan to have some time at
the start coding phase to keep looking into the code and decide with
my mentor what commands will need to be touched.

If you have any Idea which can turn this project better or just some
advice for my application, please share it through the list, then
other people can keep collaborating.

Regards,

--
Felipe de Oliveira Tanus
E-mail: fotanus@gmail.com
Site: http://www.inf.ufrgs.br/~fotanus/
-----
"All we have to decide is what to do with the time that is given us." - Gandalf
