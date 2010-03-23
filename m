From: Ping Yin <pkufranky@gmail.com>
Subject: Re: [msysGit] Re: ANN: Git for Windows 1.7.0.2 preview 20100309
Date: Tue, 23 Mar 2010 23:06:49 +0800
Message-ID: <46dff0321003230806r53d61628k73865df0f5a08697@mail.gmail.com>
References: <alpine.DEB.1.00.1003091921140.18499@intel-tinevez-2-302>
	 <alpine.DEB.2.00.1003221012290.11364@ds9.cixit.se>
	 <alpine.DEB.1.00.1003221155200.7596@pacific.mpi-cbg.de>
	 <46dff0321003221854t2d95d18dx1a6cdf1174ea2efd@mail.gmail.com>
	 <a5b261831003230503k73f62a88lc5a9b31da3e9d893@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: msysgit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Pat Thoyts <patthoyts@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 16:07:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu5h5-0001SY-9o
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 16:06:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754486Ab0CWPGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 11:06:52 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:9239 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754465Ab0CWPGw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 11:06:52 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1565604qwh.37
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 08:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=BO78nDDLV5FMtlOx0plFNUxn1b0EvmmVPtOMNvw5E/I=;
        b=V7XMmAngeoJBjn5fmoWN8B3+IVcsfYpUAV31lS2NPum0gTuHgZK324EihYzobt5IF8
         no+TfM9H/0UhmFZqz0HTkC0aC87wE127+/uonioUp8laizRXapF1CCmJfLQKjEtf1bDv
         VX3ZCNzTXLPfawMiVLZP7qkpNwzohX18uLXs0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ZUpA2E3T5v1ho7jcv5RL1Vsio50ZMxlUraiS4i8lLDu5rRh228unAtz+4ychrgJjPK
         QpVi7scSm5X92kxtZxmYwftB9m9BVNXxBggLxH2ppS9Vef1mvVAih3h2ee4dYk1zTuEE
         kGkelePktEIpPHo5guu65i/53s9HXpAiS+P3E=
Received: by 10.229.219.143 with SMTP id hu15mr1043919qcb.12.1269356809720; 
	Tue, 23 Mar 2010 08:06:49 -0700 (PDT)
In-Reply-To: <a5b261831003230503k73f62a88lc5a9b31da3e9d893@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143023>

On Tue, Mar 23, 2010 at 8:03 PM, Pat Thoyts <patthoyts@googlemail.com> wrote:
>
> On 23 March 2010 01:54, Ping Yin <pkufranky@gmail.com> wrote:
> > With putty and pageant, the key with passphrase can be used.
> > Is there any way to use key with passphrase when using the msysgit ssh?
>
> Use ssh-agent.
>
> After you start the msys shell enter:
>
> eval $(ssh-agent)
>
> Then you can use 'ssh-add' to add a key to the agent. If it requires a
> password then it will prompt you at that point. Now any further ssh
> activity in the current session can acquire the pre-authenticated key
> from the agent.

Thanks. I'm sorry that i didn't make it clear. I know this works for
msys shell, but it doesn't work for git-gui.
