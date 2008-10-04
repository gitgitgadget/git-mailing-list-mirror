From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: How to list versioned files with modification status
Date: Sun, 5 Oct 2008 00:34:31 +0200
Message-ID: <81b0412b0810041534o7b38507qe63db47cd07fdc16@mail.gmail.com>
References: <20081004131256.586a5fbf@smartavionics.com>
	 <81b0412b0810041440w131647aeo9c14f55cd38da635@mail.gmail.com>
	 <loom.20081004T215458-15@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Mark Burton" <markb@ordern.com>
X-From: git-owner@vger.kernel.org Sun Oct 05 00:36:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmFiz-0000ym-6p
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 00:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149AbYJDWef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 18:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754083AbYJDWee
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 18:34:34 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:34820 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849AbYJDWee (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2008 18:34:34 -0400
Received: by gxk9 with SMTP id 9so3850383gxk.13
        for <git@vger.kernel.org>; Sat, 04 Oct 2008 15:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=AwEmWR+NQ8wp6FhBFgpKT0vld9RQhaqSEMUBLlMMmwM=;
        b=PhHAJ7i3xSD28XK3nhD6+sd5hvSiKVdLyqTVWlYYdNbbKkwFc/boJHQos2CTUEIHX2
         ESIz7uVS8wTd7+1Vv+wZpNBogWgAnRW6KvkF4KgT2t4rwyXOZz8ZSSTANPmVV+BfGH73
         q8U2vbkMqRLOav/H0Ru3UoSFbXaeAjDI9ZqlE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=QgSqFy7HWGgppglmt/hOCNg2+ZqYf4+rir0537jpSPoclKVVrvIhBgDB0c5HugyDs4
         h1XF3xw5fXrwiAnxbjiI342V0qj/k5uOPnkP6M4NLFvjmkUiT/VNL3IXBIBWpdjexrs0
         nHib/Z2jKBbxTYQIVUy+vkyeAn8mxT8E0cJoY=
Received: by 10.100.228.17 with SMTP id a17mr85266anh.158.1223159672000;
        Sat, 04 Oct 2008 15:34:32 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Sat, 4 Oct 2008 15:34:31 -0700 (PDT)
In-Reply-To: <loom.20081004T215458-15@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97481>

2008/10/5 Mark Burton <markb@ordern.com>:
> Alex Riesen <raa.lkml <at> gmail.com> writes:
>> 2008/10/4 Mark Burton <markb <at> smartavionics.com>:
>> > I would like to be able to easily find those files in a git tree that
>> > don't have pending modifications. Although ls-files can list the
>> > files that are modified, it can't list those that aren't or list all
>> > files with their modification status.
>>
>> Maybe if you look at git diff and diff-index,  you will find something
>> what suits you better? Because "modification" is just a difference
>> between a known (recorded in a commit or index) state and your
>> working tree.
>
> 'git diff --name-status' looks useful but it only shows the files that have
> changed - I would like to see the names of the files that haven't changed.

There is nothing to do something like that, but...

> Even svn could do that (svn status).

what exactly are trying to achieve? It is just strange that no one
asked for something like this before...
