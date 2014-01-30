From: Arshavir Grigorian <grigorian@gmail.com>
Subject: Questions on local clone and push back
Date: Wed, 29 Jan 2014 21:43:33 -0800
Message-ID: <CACdn6eksz0q1+_JHwF=wKP_ziUFzhB5ij93A3-BEap3kosipFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 30 06:43:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8kPb-0002nc-I4
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 06:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbaA3Fnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 00:43:35 -0500
Received: from mail-wg0-f46.google.com ([74.125.82.46]:61022 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbaA3Fne (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 00:43:34 -0500
Received: by mail-wg0-f46.google.com with SMTP id x12so5260912wgg.25
        for <git@vger.kernel.org>; Wed, 29 Jan 2014 21:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=leH6QKX2f5EqV1zgQIHIkPkd53jlxH4nzR4H6gw3poQ=;
        b=WwS7d0VwPa0/AD8u8h4uC3nIBIftotRAk9VhQ67e8yKUk2NS44gA+/y1/XoZZXEem6
         CevvWXz3KyR9GlCkqgyEGQyp2jfnK0l6tn4PPh/DABZmeiBx8C+WN693azgEsounOd70
         91LAYk2+BImpPAMiabNdH76tyLru+CKQWGF2nFUPGveT5T2Fvb6QogzH0DSswVmCsGYd
         vuR8ewRwqObylRWRUwWYZATpBt6oZXRjKY3HJgpwri3mWGttjaMBS6dYL8VCuwEycfLR
         qntXPa+ZRNUYyVyRFDkrdDlrDSUB77putJHj5Xi6UBoNHueEEuw9UwPdB23obmuMaVgG
         eizw==
X-Received: by 10.180.101.230 with SMTP id fj6mr21609539wib.27.1391060613481;
 Wed, 29 Jan 2014 21:43:33 -0800 (PST)
Received: by 10.180.19.7 with HTTP; Wed, 29 Jan 2014 21:43:33 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241239>

Hi, I have the following use case - I have a set of files that are used for
various adhoc projects, each project is in its own directory, and the files
sometime need to be customized/enhanced for a specific project. Ideally
some of these enhancements should be merged to a "central" place. I realize
that this is not the most optimal setup for software development, however
these aren't software projects per se and this setup works very well.
To this end, I am thinking of creating a git repository in one directory
(central location), then cloning it (-l -n -s) into another directory in
hopes of making enhancements there and eventually pushing / merging some of
those enhancements back to the central location.

Questions: 1) is this a good approach to achieving what I need 2) I was
getting an error when I tied to run "git push" about the branch being
checked out and 3) how do I selectively push / merge only certain commits
back to the "source" repository / branch?

I am using pushing / merging interchangeably because I don't know which
action is more appropriate in this situation.

This is my first time using git so any insights would be much appreciated.
TIA
