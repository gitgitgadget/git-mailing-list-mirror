From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 1/2] sh-setup: Write a new require_clean_work_tree function
Date: Fri, 1 Oct 2010 22:22:54 +0200
Message-ID: <AANLkTi=91-TJ=C1dUKRXKYWYShWZ-LuLFG3hq1Ms+C+Y@mail.gmail.com>
References: <1285877017-8060-1-git-send-email-artagnon@gmail.com>
 <1285877017-8060-2-git-send-email-artagnon@gmail.com> <7v4od7hsqt.fsf@alter.siamese.dyndns.org>
 <20101001045713.GE20098@kytes> <20101001053721.GB6184@burratino>
 <20101001072149.GA24171@kytes> <20101001074039.GC6184@burratino>
 <20101001125604.GA20713@kytes> <20101001182852.GA18692@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 22:23:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1m8X-0000Bj-PG
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 22:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832Ab0JAUXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 16:23:16 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48971 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466Ab0JAUXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 16:23:16 -0400
Received: by iwn5 with SMTP id 5so4229899iwn.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 13:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=DeA2/fYcG7lkBEhbI51LP4bcjth0ewHzUniCwpGRSLk=;
        b=BCk36bb113+/VmlmBLS4AnKPoB68Z4cWHuQ6PZcwsxuWl93UdRo0YR7nl9DYtDkfxQ
         +GrE7+RX2pJTW+M8Hq+1JVoUy/Q16rXuCGe7xmLPeNCaKMAiH+vNG+fMagB4FgMeCt+P
         VwlERD+eSnECoPPQpfp81rBFpAVreVwu6CgWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=mq0ftH0/vXyP7q4vP3BcCCx53b1gpZQ+L/a2J4wrL1Y6Egre8BcyeHN+NESFiA/s6l
         1LSFvpXKGI5kiRi56QB+EeT+9BEofXRgeYxq/jz4wimAtcVwvNdoF7suTlW3H29H4E1J
         at5ZrLs/ZsIgu66sr850ppDrhwFCmZimsx15Q=
Received: by 10.231.148.20 with SMTP id n20mr6139196ibv.196.1285964595410;
 Fri, 01 Oct 2010 13:23:15 -0700 (PDT)
Received: by 10.231.33.138 with HTTP; Fri, 1 Oct 2010 13:22:54 -0700 (PDT)
In-Reply-To: <20101001182852.GA18692@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157779>

Heya,

Wow, I totally did not notice this very interesting sub-thread!

On Fri, Oct 1, 2010 at 20:28, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ramkumar Ramachandra wrote:
>> +You can also create your own tag or use one that's in common usage
>> +such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".
>
> I like it.

Thanks, Jonathan, for the looking up this stuff from the kernel's
SubmittinPatches.

FWIW I like Ram's patch to SubmittingPatches too.

-- 
Cheers,

Sverre Rabbelier
