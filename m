From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: Re: git pull origin fails
Date: Sat, 28 Apr 2007 23:19:27 +0530
Message-ID: <cc723f590704281049h75ddb563tfc33ebddf37214ee@mail.gmail.com>
References: <cc723f590704281037v5d2142d7u2edf7e503cb3ce19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 28 19:49:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hhr36-0007KQ-Qa
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 19:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163281AbXD1Rt3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 13:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163287AbXD1Rt3
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 13:49:29 -0400
Received: from nz-out-0506.google.com ([64.233.162.231]:42490 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163281AbXD1Rt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 13:49:28 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1512851nzf
        for <git@vger.kernel.org>; Sat, 28 Apr 2007 10:49:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A2MNhEbVSr/8yIopRjTISnJDMkGmNusjgJmtHaAc0PEuu9Qe5xNv5RmWzURaWK5KBnAt8aPqomrrF4WKOcFGCVjwEx0jpJFQhwVGj5NlEmpIFHHVYELWVRJjdK7rwjAjo7WGYJwbtJY4i2EHqGb2+4F278YWkcEr7bAhKIJ2a7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cEVJ271471wksA9ZBfg5FpaW+kxIRNtXmBVHl31Q5FOGu7GgpqGJ6pK3Bt5VV6nqpMXDUpPwbdGHU0WBf6lrzlKtz/mk5oiwqXlGXa9xB+DiGNvm/6sPotyIUUMpy3HfseAgcKW3pMmuQTiRiF18laY+vXi2f5Nbd2AuMMxmbpA=
Received: by 10.115.77.1 with SMTP id e1mr1439401wal.1177782567254;
        Sat, 28 Apr 2007 10:49:27 -0700 (PDT)
Received: by 10.114.240.11 with HTTP; Sat, 28 Apr 2007 10:49:27 -0700 (PDT)
In-Reply-To: <cc723f590704281037v5d2142d7u2edf7e503cb3ce19@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45790>

False alarm. I guess i had some wrong values for remote in  my .git/config file

-aneesh

On 4/28/07, Aneesh Kumar <aneesh.kumar@gmail.com> wrote:
> git version 1.5.2.rc0.1.g2cc31-dirty gives me the below error when
> doing a git pull origin
>
>
> Warning: No merge candidate found because value of config option
>          "branch.master.merge" does not match any remote branch fetched.
>
>
> I was able to do
> git fetch origin
> git merge origin/master
>
>
> -aneesh
>
