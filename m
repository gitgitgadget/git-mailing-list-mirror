From: Johan 't Hart <johanthart@gmail.com>
Subject: Re: Git as electronic lab notebook
Date: Sun, 20 Dec 2009 01:15:33 +0100
Message-ID: <4B2D6CA5.3070304@gmail.com>
References: <loom.20091219T130946-844@post.gmane.org> <8e04b5820912190538v2e9ef109me3a1515040127b39@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Johnson <thomas.j.johnson@gmail.com>, git@vger.kernel.org
To: "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 20 01:15:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NM9Sh-0003HD-UQ
	for gcvg-git-2@lo.gmane.org; Sun, 20 Dec 2009 01:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398AbZLTAPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 19:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbZLTAPq
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 19:15:46 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:39931 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbZLTAPp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 19:15:45 -0500
Received: by ewy1 with SMTP id 1so4971169ewy.28
        for <git@vger.kernel.org>; Sat, 19 Dec 2009 16:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=Yb0vyYAphkFpR2l5N7ju+aTG3Bl0C7x2aFzx5f7BrnU=;
        b=J1KnoiyQKuMsVsyANOxYpmF1kHSKFEZ2fq7Hxs2Ljiu4fz8OcxYjiTZYYW6W6XC9cv
         Oec/zEGMABiifSszEEAfxxxy5elhzkzBWcdv6VYWF+Ah4LH3HA3Dfqkmf+LXk0QhEHeo
         bJNGoU1PqXfVY7e1EnjeKOZE5vKdigSRg/v+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:newsgroups:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=wYHfLtmmhPXvFBrpQlGdovGlMvcFCOTCNu3fLw9yy8mNdXxtYKptr/N9qjGLrRF3xh
         8OiZ73ldKV5Ww87EBj8FPdj6LZQDa6ZtC2MOyyB9Xt2o4UF06U04W64cTLXtjG63eVDm
         +lrcFVq9eXfmKbcAfmzpnCcYacCqUGKrWZQ0c=
Received: by 10.213.96.226 with SMTP id i34mr2189953ebn.4.1261268142992;
        Sat, 19 Dec 2009 16:15:42 -0800 (PST)
Received: from ?192.168.2.101? (dsl-083-247-086-199.solcon.nl [83.247.86.199])
        by mx.google.com with ESMTPS id 24sm7920678eyx.22.2009.12.19.16.15.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 19 Dec 2009 16:15:42 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <8e04b5820912190538v2e9ef109me3a1515040127b39@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135509>

Ciprian Dorin, Craciun schreef:
> On Sat, Dec 19, 2009 at 2:23 PM, Thomas Johnson
> <thomas.j.johnson@gmail.com> wrote:

>> 4. Run the program, which generates a giant (10MB-4G) output text file,
>> Experiment123.log. Update my LabNotebook.txt file.

>     * even if you prefer having the logs, it's best to let Git handle
> the compression; because even if only some small parts change from the
> original txt file, I would guess that the BZip-ped file looks quite
> different;
>

Is git able to handle 4Gig files? I've heard git loads every file 
completely in memory before handling it...
