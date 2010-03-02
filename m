From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Identifying the branch a clone was cloned from
Date: Wed, 3 Mar 2010 00:15:30 +0100
Message-ID: <adf1fd3d1003021515t765b8acawa28196693da21681@mail.gmail.com>
References: <27761617.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: jateeq <jawad_atiq@hotmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 03 00:15:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmbJR-0006p5-V0
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 00:15:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196Ab0CBXPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 18:15:33 -0500
Received: from mail-bw0-f209.google.com ([209.85.218.209]:63376 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074Ab0CBXPc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 18:15:32 -0500
Received: by bwz1 with SMTP id 1so260675bwz.21
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 15:15:31 -0800 (PST)
Received: by 10.204.152.153 with SMTP id g25mr5190153bkw.158.1267571730479; 
	Tue, 02 Mar 2010 15:15:30 -0800 (PST)
In-Reply-To: <27761617.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141421>

On Tue, Mar 2, 2010 at 10:45 PM, jateeq <jawad_atiq@hotmail.com> wrote:
>
> Hey guys,
>
> I have a repository with over 10 branches. I clone from branch 2, and some
> time after the operation I need to find out what branch in the remote I
> cloned from. Anyone know the command for that?

If you mean from which branch you forked a given branch it is
specified in the branch.<name>.remote and branch.<name>.merge + some
logic. To get it you can use the branchname@{upstream} syntax (new in
1.7.0) or use this command:

git for-each-ref --format='%(upstream)' refs/heads/branchname

But maybe we can help more if you say what you want to accomplish with
this information and not this specific detail.

HTH,
Santi
