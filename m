From: Orgad and Raizel Shaneh <orgads@gmail.com>
Subject: git rebase -i does not rebase if all lines are removed
Date: Tue, 17 Jul 2012 13:46:10 +0300
Message-ID: <CAGHpTBKn+avCrWegktoJRurG+oycq6Sb9CiRDCBQG=hSMUkjiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 17 12:46:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sr5IH-00017w-Lh
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 12:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864Ab2GQKqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 06:46:13 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:47613 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421Ab2GQKqL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 06:46:11 -0400
Received: by lbbgm6 with SMTP id gm6so449710lbb.19
        for <git@vger.kernel.org>; Tue, 17 Jul 2012 03:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=ninIqWePyojHbrpIOyOLkqfwtgckyvxrpZaFnBMVVRU=;
        b=cYGHmNY1TzSmVMyL64OLar8bRQohTaADulu5tKZZ5V61lZZ3qpjx6QmBPYB1h4B43b
         2L/IjklzTazeP59TSO//LAkzaJxurOL82nbHHUnvkRi2GVhrMeVTy7hSSCBedu9Wx3UE
         3tuC7Y61N2oBbl4DO+m+gPVUrb67jAyeSMV9zQUtWh231Hso1+PSYHplzNsLeG9LG+Zi
         ZHkZk0RhgOH+3z0xP6dlZyN2zKQq514R7H/rtH7C/1CvKQ5E8KB+ZFX4rL/7qWh3GN09
         meTZDxiFekCXuJjQuQBbeH+CmpKnlAKgN6IUt4fWiJFPNojBFv7jPe37pKgI/MiRQE9c
         QcQw==
Received: by 10.152.144.234 with SMTP id sp10mr2012483lab.51.1342521970377;
 Tue, 17 Jul 2012 03:46:10 -0700 (PDT)
Received: by 10.114.17.35 with HTTP; Tue, 17 Jul 2012 03:46:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201599>

Make a commit on top of master.

git rebase -i origin/master

Remove the commit.

Git prints "Nothing to do" and does not rebase.

Running 'git rebase -i' when there are no local commits has 'noop' in
the first line, and with it the rebase is successful. Why is this
'noop' mandatory?

- Orgad
