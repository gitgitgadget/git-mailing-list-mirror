From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: NYU Open Source Programming Class Releases JavaGit API 0.1.0
 Alpha
Date: Mon, 04 Aug 2008 20:03:58 -0400
Message-ID: <489798EE.7050402@gmail.com>
References: <5dfc0b810808040948x6cd1f29fhaf2bf85a09cfd404@mail.gmail.com> <20080804175403.GG27666@spearce.org> <alpine.DEB.1.00.0808050127510.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	James Linder <james.h.linder@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 05 02:05:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQA33-0003DP-GQ
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 02:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756222AbYHEAEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 20:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756031AbYHEAEE
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 20:04:04 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:11032 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754339AbYHEAEC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 20:04:02 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1312185ywe.1
        for <git@vger.kernel.org>; Mon, 04 Aug 2008 17:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=zyV/5dYH9t+7nbl0cHIUZRIJHmCZbKkadSW802le5Zg=;
        b=uCuCIn7NvUteMU2UKxc593yh4Jludhr/IfAp1AOJxOpr0o9j5ibMbuBdCglXttv214
         pj3ssI/prjkVYh2qdQz5hWoDzaoDCF9RfYYWaqRhg1u3Xe+vXGEbecBjzzi4sB0yc9iA
         9EuGTWX6OkAJtUWRZ2zhejmX63o6NjaO3c1Kk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=wo+H9WQC9RdbTKYi6IVlxh0S1ACHwJ5f/AKUXuDOF6jVIY/SCjkH/Lm79BkqpL7pP1
         jZIF75Yn3rdW/FoRWNN/mEFIDy/KW9EbML9do7/WiV9A60b2iZkCa6oL7XdRKXm9lLAt
         pB0l7Y/p5JnBgbj8E/NpfV1Np5/LZmUt39mI4=
Received: by 10.150.11.14 with SMTP id 14mr340617ybk.109.1217894640406;
        Mon, 04 Aug 2008 17:04:00 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.100])
        by mx.google.com with ESMTPS id 9sm800067yxs.5.2008.08.04.17.03.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Aug 2008 17:03:59 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <alpine.DEB.1.00.0808050127510.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91393>

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 4 Aug 2008, Shawn O. Pearce wrote:
> 
>> James Linder <james.h.linder@gmail.com> wrote:
>>
>>> Jgit/Egit, on the other hand, appear to be tightly integrated with 
>>> Jgit primarily supporting Egit.
>> That's not really true.
> 
> I started using jgit in a project that is not yet totally public.  It is 
> awesome.  (I mean jgit is awesome, even if my project does make me happy, 
> too.)
> 
> And I absolutely share the puzzlement of Shawn why anybody would try to do 
> their own thing in Java, instead of contributing to jgit.
> 
> Especially the fact that "JavaGit" seems to repeat the all-to-obvious 
> error of Eclipse: to make a platform-independent library that depends on 
> platform dependent components.
> 
> I find that kind of thinking so strange, to the point that I am really 
> amazed enough to want to analyze the brain of the people inventing such 
> things.
> 
> But hey, maybe there is a deeper point in it that escapes me.

You mean like "Why is a project with the goal of bringing the power of 
git to Java developers hosted in svn instead of git"?
