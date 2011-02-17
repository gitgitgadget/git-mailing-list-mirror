From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git merge auto-commit doesn't fire pre-commit hook
Date: Wed, 16 Feb 2011 23:48:46 -0500
Message-ID: <AANLkTi=DF6HiMcKA5r_HMTD3roneGZdfqFKZ_sYCy1wG@mail.gmail.com>
References: <1F3B7FF9-6348-4197-A6B7-23C4DA144920@adscale.co.nz>
 <AANLkTimCdQL879kBZiktB49eSvoAGT0pX5DKX0SHFOVB@mail.gmail.com> <6F190320-19AF-4F4A-9AE9-0DDA0839C5FD@adscale.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Liam Clarke <liam.clarke-hutchinson@adscale.co.nz>
X-From: git-owner@vger.kernel.org Thu Feb 17 05:49:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppvnu-0003bk-GL
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 05:49:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754740Ab1BQEtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 23:49:18 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50256 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754051Ab1BQEtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 23:49:16 -0500
Received: by iyj8 with SMTP id 8so1972246iyj.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 20:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=+Srb156i1x5fZ7FMzSrE8kbwsDN4EDo3X7w7bA7mFfw=;
        b=soHeqOdHrU4+Nzr13nvpLIneA/PKJt0aWb4MnQ5bZVe4+EB8JSQU7r2c6CIb+JS1a7
         LqN8TOnvhdSDIkL7fUXw9lU6kgV2uoZHlzdHJUIE1WrfUD3dciIOUFrSaGEQGJCDflIJ
         hhFaJuqprmva/dnih4g9Y48TG5O4fcxAyvRoE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=XY82pKEXwJdaL791ABzLI6ydJ+s6/rioqirco+usrCugjkjAu2ptMsOG7J2EVa19uG
         7PbQMEmW8RJdcGq+lWRxzlthPTu+BaupxlksozmNl3JG7WwDPrm5u2FYVIPK4Ajm/Jws
         eVGVDa9k6Kkwux9OLqdgL4jTnGhQE9ypFTmZc=
Received: by 10.231.14.8 with SMTP id e8mr1188284iba.117.1297918156309; Wed,
 16 Feb 2011 20:49:16 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Wed, 16 Feb 2011 20:48:46 -0800 (PST)
In-Reply-To: <6F190320-19AF-4F4A-9AE9-0DDA0839C5FD@adscale.co.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167038>

On Wed, Feb 16, 2011 at 11:44 PM, Liam Clarke
<liam.clarke-hutchinson@adscale.co.nz> wrote:
> Cheers Jay.
>
>> The bypassing of pre-commit hook was and remains to be a conscious design
> decision.
>
> That doesn't sound good for my purposes. It also renders Git merge behaviour significantly surprising. :(

I agree. Note that the grandparent statement belongs to Junio, but he
also indicated at the end of the message that he didn't care too
deeply.

Personally, I think the commit hooks should fire whenever a commit is
made, regardless of the source. Maybe the hooks should move to the
low-level commit_tree, or maybe merge should invoke commit instead of
commit_tree.

j.
