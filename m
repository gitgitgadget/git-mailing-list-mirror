From: "Brendan Macmillan" <melbourne.research@gmail.com>
Subject: Re: commit takes 8 secs; but instant when offline - can I fix this?
Date: Mon, 3 Nov 2008 03:34:48 +1100
Message-ID: <7d856ea50811020834n3a252ae2r21d36b24c10eebbf@mail.gmail.com>
References: <1225634894605-1445352.post@n2.nabble.com>
	 <200811021514.00057.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Thomas Rast" <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Nov 02 17:36:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwfvn-0002Ff-Pa
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 17:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779AbYKBQeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 11:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753785AbYKBQeu
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 11:34:50 -0500
Received: from ti-out-0910.google.com ([209.85.142.188]:54571 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722AbYKBQeu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 11:34:50 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1151776tic.23
        for <git@vger.kernel.org>; Sun, 02 Nov 2008 08:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=JvG1m+dM3fVzNk2axdS1RfDD0GtapQyjux7THc0Rr+0=;
        b=WIOfcn9yxz41UJmrtCURu3HR2etyFLrHpejVpEWEEl40NeRd2dLJFUF2RI7OoqdqW4
         1avnqqXH1M0TAZYJWdvoI5N3dulLCLCZFM/zUxpC2Q8WPMojZJpttiiGrR4NcjsBlDxZ
         enOijPONQjyfQamwcm8MXfusczOy2icR+WQIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ZuCRByK2DaTsJXMN5LiIM3ijGsn0q7e8fgr+XU85U3HvxSHq3D+ziUiqOglRSEgsrN
         c4dnrMuz5+jKZkvI5C4VKizlQGd9r58rS6DVZcL32nDcdsK0ix4a6uYNmygiOVSdL2Ug
         nKYe5arB5nrcRHz6TwQyBfKmB1Oz7UDU+TBtU=
Received: by 10.110.37.17 with SMTP id k17mr6820419tik.26.1225643688257;
        Sun, 02 Nov 2008 08:34:48 -0800 (PST)
Received: by 10.110.17.16 with HTTP; Sun, 2 Nov 2008 08:34:48 -0800 (PST)
In-Reply-To: <200811021514.00057.trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99854>

Many thanks for the explanation, and it's now instant.

To ~/.gitconfig, I added:

[user]
  email = myemail@address.com


On 03/11/2008, Thomas Rast <trast@student.ethz.ch> wrote:
> 13ren wrote:
>  > With the network plugged in, git-commit takes 8 seconds.
>  >
>  > When I unplug the network, commit is instant...
>
> Configure your user.email (and user.name), see man git-config.  If the
>  email is not set, Git tries to figure out your hostname, which
>  depending on DNS misconfigurations can apparently cause such delays.
