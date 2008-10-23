From: "Felipe Carvalho Oliveira" <felipekde@gmail.com>
Subject: Re: Tip: avoiding net overhead using git over sshfs
Date: Thu, 23 Oct 2008 09:51:40 -0200
Message-ID: <a2075f4c0810230451lefff6ffnc283f4078eff9f9c@mail.gmail.com>
References: <a2075f4c0810221826w511a3b87r6fea4fb0dee24e1f@mail.gmail.com>
	 <490036A2.20608@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Michael J Gruber" <git@drmicha.warpmail.net>,
	"Matthieu Moy" <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Oct 23 13:53:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsykW-0002UA-LF
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 13:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbYJWLvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 07:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbYJWLvn
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 07:51:43 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:13622 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbYJWLvm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 07:51:42 -0400
Received: by rv-out-0506.google.com with SMTP id k40so305817rvb.1
        for <git@vger.kernel.org>; Thu, 23 Oct 2008 04:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=jaACQIwWV8K/fWAXdD0qcpzgBlbgcUC3LKQWcWQ0KNs=;
        b=IcKFdNGmd08u48/RTanpFisTsuRwBQxWfqq5JNGktSfa7OOhkpoEYYNc/BcsBDac4t
         4l4DR445Ut6wvu6MSO44W7D3MoOBSx+yFGlwuVQUabKgTfCRTR70tRPdmUnLUpJJ2XcT
         ycHUL5mdv4bYfWDxzm2v1HFIDGRjicPF1+sFY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=OgiM3PDDAOSWkX0KCIZXBKgQ+rttsyJ22vvFMK/uUaQWDwPw+ln1SPiVZUIlXc2LuY
         Cq9Mx8a6Ps/8pGkWctTck2Tgw63UlCMAmWVydjsefiaBEpvnXY3cUx9SIkCj0eZKGC3s
         eIbO5SC4JYAadvM9UgyeKi38Hi83OCBmi5+hs=
Received: by 10.141.113.6 with SMTP id q6mr309101rvm.36.1224762700819;
        Thu, 23 Oct 2008 04:51:40 -0700 (PDT)
Received: by 10.141.116.9 with HTTP; Thu, 23 Oct 2008 04:51:40 -0700 (PDT)
In-Reply-To: <490036A2.20608@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98951>

On Thu, Oct 23, 2008 at 6:32 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> I'm sorry but I'm afraid I'm missing the point: If you don't have shell
> access then you can't use ssh(fs), can you?
> Maybe you mean you can't set up git daemon or gitweb.cgi on the server?

Yes, i can't set up any git daemon or any other software.
I have just sftp acess. And sftp is a "dumb protocol" to use git.

On Thu, Oct 23, 2008 at 7:00 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> I think you'd better work locally, and push to the sshfs directory
> from time to time. Then, you'd both have working tree and .git locally
> and fast, while keeping the safety of replicating to your ssh server.

I can't use git-push as I explained before.
I use git as a deployment tool in this case.
I work locallly and use git-pull to sync my local repo and the
"production"(server).
Git works better than a manual (S)FTP sync.


I hope I'm more clear now.

--
Felipe
