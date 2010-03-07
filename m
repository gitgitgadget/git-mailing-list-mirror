From: BJ Hargrave <bj@bjhargrave.com>
Subject: Re: git push question
Date: Sun, 7 Mar 2010 06:52:30 -0500
Message-ID: <00512306-B7AE-4A63-B5DD-492F3720A8CC@bjhargrave.com>
References: <b42431c81003070341u4a89578aw4357e7aef84ffb61@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Mahesh Vaidya <forvaidya@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 12:52:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoF2F-00049H-Q6
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 12:52:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882Ab0CGLwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 06:52:35 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57600 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159Ab0CGLwe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Mar 2010 06:52:34 -0500
Received: by gwb15 with SMTP id 15so2558436gwb.19
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 03:52:33 -0800 (PST)
Received: by 10.101.81.9 with SMTP id i9mr13351anl.129.1267962753471;
        Sun, 07 Mar 2010 03:52:33 -0800 (PST)
Received: from hargrave.hargrave.local (125.69.205.68.cfl.res.rr.com [68.205.69.125])
        by mx.google.com with ESMTPS id 6sm1393236ywc.12.2010.03.07.03.52.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 03:52:32 -0800 (PST)
In-Reply-To: <b42431c81003070341u4a89578aw4357e7aef84ffb61@mail.gmail.com>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141671>

On Mar 7, 2010, at 06:41 , Mahesh Vaidya wrote:

>    I have discovered that one can set up property like
>    "git config user.name piglet "
> and commit will show this fictitious name instead real name forvaidya@gmail.com
> 
>    How do I ensure that a correct name is stuck at the time
> receive-pack operation when user pushes changes to auth repository

You can write a pre-receive hook, which runs on the remote repository, to validate the all incoming commits have recognized committer names/e-mail addresses. If they don't, the hook can reject the receive-pack.

-- 

BJ
