From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: git-svn and logging.. new to git
Date: Thu, 6 Mar 2008 07:37:53 +1100
Message-ID: <ee77f5c20803051237y571efa54nc80f157015859cc6@mail.gmail.com>
References: <fqloop$ll$1@ger.gmane.org>
	 <ee77f5c20803050401o7f33522dj6dd0f0f1c0a78f96@mail.gmail.com>
	 <fqmg8v$rmm$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Kenneth P. Turvey" <kt-usenet@squeakydolphin.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 21:39:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX0No-0006pe-Oh
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 21:38:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754413AbYCEUh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 15:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754467AbYCEUh6
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 15:37:58 -0500
Received: from wr-out-0506.google.com ([64.233.184.232]:33118 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754413AbYCEUh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 15:37:57 -0500
Received: by wr-out-0506.google.com with SMTP id 50so2424971wra.13
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 12:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=3AywBCAvDhusANUuwh31Tio3mCiSH4Cu+Gq4YNDVczU=;
        b=xONvj7HLAYmuitK1BHTvhCdXqAcHGyFrU0v1DtFVtYvHH31hKIDELbFOqTnBQqquyBoXp3tWEZFywIJr8kk1aKAzukzrnc9Zjq13+vuVgwRH3w8H9vuiucqpEqYcFwxjxeNVq8EztTTAIun8rPzUbZwwGW7zRytLOCLwqgHh51k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E5NtH8oQmEJLhbvNN/8HPHnDtdIWTGwYb/VjDZErf39NfFmW9OnsYg04s/aUXTVu5q77zmQco+Rt2xknEr602fi3aMjuRT22JEZVnktGT4y8wumfcu/odl60c0rSGnIgNIPRUo5tV+5CfKrBn/vurcrJPFM1nNFGilt7XWttacw=
Received: by 10.141.107.13 with SMTP id j13mr1728790rvm.276.1204749473985;
        Wed, 05 Mar 2008 12:37:53 -0800 (PST)
Received: by 10.140.135.17 with HTTP; Wed, 5 Mar 2008 12:37:53 -0800 (PST)
In-Reply-To: <fqmg8v$rmm$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76260>

On Thu, Mar 6, 2008 at 3:03 AM, Kenneth P. Turvey
<kt-usenet@squeakydolphin.com> wrote:
> On Wed, 05 Mar 2008 23:01:34 +1100, David Symonds wrote:
>
>
>  > git-svn creates a whole bunch of remote branches -- does "git branch
>  > -a" show them up?
>  >
>  > Also, you can probably leave out the --trunk, etc., and just use
>  > --stdlayout.
>
>
>
> Thanks.  That's good information to have.  Is there a way to just do a
>  straight import like in svnimport?  Is svnimport still available
>  somewhere or has it been completely superseded by git-svn?

I believe git-svn completely replaces svnimport. Check the git-svn
manpage, which is quite extensive.


Dave.
