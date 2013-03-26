From: Matt McClure <matthewlmcclure@gmail.com>
Subject: patch series vs. multiple files changed in a commit; storytelling
 history vs. literal creation history
Date: Tue, 26 Mar 2013 17:21:43 -0400
Message-ID: <CAJELnLE0FLrSYGHgS-cZmyQWO122-MuN7AeczUUVVposUg+qjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 26 22:22:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKbJt-0003Vc-85
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 22:22:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984Ab3CZVVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 17:21:44 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:41158 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab3CZVVo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 17:21:44 -0400
Received: by mail-pa0-f45.google.com with SMTP id kl13so1817025pab.32
        for <git@vger.kernel.org>; Tue, 26 Mar 2013 14:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=OfwknhNN2iZ60jF22y3Tf5W5U7lU6XPnmc+vm0YHX/Q=;
        b=M3vj31AwzDAvkzRx5PRR7h+YvWhss71F34P76jh9bT/h/D0mZbZE8OEiLn2PGbuwrX
         BJf9bmzG5px67277AuWLxpRNJ8izC0glfU19DlwoYz8FGmti5haN4NwIJplyQjI+Pddh
         E+6Ya4PeSn83m4Swo5Qlcl4CvCgag5x/P7X3CIceCSxZtZDx16gVdKDQpZRzogifV0cs
         fRW8n+fWCBGP+8+y0yNh/Nledwo6Tllc5DjQQlyvxy+UwYf8wU+f4+QrEcLNGf0yVdZB
         EHlsdBfWrfMJc1xaNpqt3I6l5aeKC87ezmrs8jNJmx85NKk3vb4m782/aDK2dlsc00Wg
         d48A==
X-Received: by 10.68.243.66 with SMTP id ww2mr25340271pbc.109.1364332903792;
 Tue, 26 Mar 2013 14:21:43 -0700 (PDT)
Received: by 10.68.0.66 with HTTP; Tue, 26 Mar 2013 14:21:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219208>

I've read Documentation/SubmittingPatches, followed some of the
discussion on this list, and looked over some of the recent commit
history. I'm impressed by the strong culture of review that produces
readable patches and commit messages, but I think there are some gaps
in my understanding of the prevailing process here.

Most of the code I've worked on has been closed source, and the commit
histories tend to reflect what I'd call the literal "creation
history". Reading the Git history, my impression is that it reflects a
different "storytelling" history. In some cases, that might be the
same as the creation history, but in general the emphasis is on
telling a coherent story of the changes to the other developers rather
than communicating all the messy details of how you arrived at the
order of that story. Is that right?

What are the Git project's rules of thumb for when to create a patch
series vs. putting changes to multiple files in a single commit/patch?

As a patch series evolves before landing on an upstream branch, do you
typically make corrections to the original series in new commits, or
update the respective commits from the original series in a new series
of analogous commits?

-- 
Matt McClure
http://www.matthewlmcclure.com
http://www.mapmyfitness.com/profile/matthewlmcclure
