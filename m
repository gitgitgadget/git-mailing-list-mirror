From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: see commit messages on git pull
Date: Wed, 4 Feb 2009 13:39:41 +0100
Message-ID: <adf1fd3d0902040439g47bdfd60s3c365efb221cab72@mail.gmail.com>
References: <200902041245.11242.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Koch <thomas@koch.ro>
X-From: git-owner@vger.kernel.org Wed Feb 04 13:41:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUh43-0001a0-Tt
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 13:41:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbZBDMjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 07:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbZBDMjo
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 07:39:44 -0500
Received: from mu-out-0910.google.com ([209.85.134.188]:38692 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbZBDMjo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 07:39:44 -0500
Received: by mu-out-0910.google.com with SMTP id i10so386400mue.1
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 04:39:42 -0800 (PST)
Received: by 10.103.102.17 with SMTP id e17mr296073mum.119.1233751181754; Wed, 
	04 Feb 2009 04:39:41 -0800 (PST)
In-Reply-To: <200902041245.11242.thomas@koch.ro>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108347>

2009/2/4 Thomas Koch <thomas@koch.ro>:
> I'd like to see the commit messages of the fetched commits, when I do
> git pull. Is that possible?
>
> It would also be fine to have sth. like git log --since-last-pull ?

I have this alias:

alias.last=log @{1}.. --decorate --reverse --stat -C --no-merges

It uses the reflog to show the commits between the old HEAD (@{1}) and
the current HEAD. You can also specify the branch that you want to see
with branch@{1}..branch@{0}.

HTH,
Santi
