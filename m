From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: clone fails: Could not get the current working directory
Date: Tue, 23 Sep 2008 17:01:08 +0200
Message-ID: <81b0412b0809230801l2e6b1a71v1210317fe636aeba@mail.gmail.com>
References: <48D59A30.5020403@cs.tamu.edu>
	 <81b0412b0809230539x340bd579q3489d5e257b9740@mail.gmail.com>
	 <48D8EDDA.3050804@cs.tamu.edu>
	 <81b0412b0809230712u4a1cbe0fo69f558cbe9a26aae@mail.gmail.com>
	 <48D90125.3090703@cs.tamu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "John Freeman" <jfreeman@cs.tamu.edu>
X-From: git-owner@vger.kernel.org Tue Sep 23 17:02:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki9PC-00028s-Ek
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 17:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbYIWPBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 11:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752046AbYIWPBK
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 11:01:10 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:28595 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbYIWPBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 11:01:09 -0400
Received: by yx-out-2324.google.com with SMTP id 8so319788yxm.1
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 08:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=AMr+n7P+Ms5FgHaCwVAIlmxInorryIs1QRKVCxRpkWM=;
        b=oX5KrguoqxaU+/zcPEw3/U43QDwJzXRl/0sjNBzXqGS+niFDRsdCEFDe8lyoWOCJda
         bb1Gt4VX/z2sC4bGqu6cK0UdpYu9N9RpoFMs+np4y4jvBgwnBbT2sjlL+e/9gIadQ5UX
         EOsx7RS/MFjkPFsVXUgXOIknPSTZm//UpSZF4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=cGd7cX5/UyWjf3Y2szHNIVsl+cnfwyFzRRlAd8Aw/iM0Cmri/uGSod5oW3x+jbLZHC
         /N2C71sdI/4XowVMUIQkypz0rvRB29/42adhz4MjSMuL72Opd1RnVawrQBL9KV3K0+tj
         z3DdG4SqI4M7hjmFFRUXbaafuD1maTxnykPMo=
Received: by 10.151.85.9 with SMTP id n9mr9362746ybl.35.1222182068327;
        Tue, 23 Sep 2008 08:01:08 -0700 (PDT)
Received: by 10.151.107.13 with HTTP; Tue, 23 Sep 2008 08:01:08 -0700 (PDT)
In-Reply-To: <48D90125.3090703@cs.tamu.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96574>

2008/9/23 John Freeman <jfreeman@cs.tamu.edu>:
> Alex Riesen wrote:
>>
>> Saw them. .bashrc (/etc/bashrc too) is not used for non-interactive
>> sessions,
>> like yours (of course, you can source them from
>> .profile/.bash_login/.bash_profile).
>>
>> Have you tried the commands exactly? (Even more interesting would be to
>> try
>> a simple getpwd program which prints errno)
>>
>
> I have.  I'm convinced that the problem is not missing commands; if it were,
> I'd be getting a "missing command," or "file not found," or similar error.

I actually expected "ls -R" giving error about unable to read the directory
(permissions).

>  Like I've said, I am able to get this to work when the repo is in my home
> directory.  It only fails when the repo is on another path in the system for
> which I do not have read privileges all the way down - only at the end.

Again: try a simple program which just does getpwd for this pathname
