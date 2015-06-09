From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: GIT for Microsoft Access projects
Date: Tue, 09 Jun 2015 19:24:51 +0530
Message-ID: <5576F02B.4040002@gmail.com>
References: <20150608094517.GY06Y.31914.root@txifep02> <20150608191458.9f6a93b0259a8ca0324c8dc0@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Konstantin Khomoutov <kostix+git@007spb.ru>, hackerp@suddenlink.net
X-From: git-owner@vger.kernel.org Tue Jun 09 15:55:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2JzZ-00015M-Nl
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 15:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059AbbFINy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 09:54:58 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33420 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbbFINy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 09:54:56 -0400
Received: by pdjn11 with SMTP id n11so15807452pdj.0
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 06:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=v0HRHrjedB24N3Rd5IATfsom6NIZxhOrc0QpwF64epg=;
        b=hp+QefWga2Wxc8rIIPm25VEzUa0NQ48/SfJb5QYEZJ7jfmP2YCZIW61Qlkk6RsS/Qj
         BPYwoEK+/xQEtm+jf7dR5TDWmosRBIkfKTpyfHH8IW1thSvnFOlaOZyDcJcTEGfLIUxW
         grMlOUwkH1ERTlx0EwL/JbqnEAh+n720B303mMDycdH+RVlKvu0Am9Po4mpWLxOFe+Qn
         hZjnd0RVeQoKUTH074Vq6VmGTr5Sr1V4y6jt9qSQFEJ8R72vrCBW9BVkfyXJZwGTrAog
         LhwV3i/et4Yugsfvg5xXbTuNPlqQw8wgsqTEwjTP4LRro0YFu9mnNvv9EX/jSe7bLVtK
         AZJw==
X-Received: by 10.66.65.200 with SMTP id z8mr39694730pas.16.1433858096381;
        Tue, 09 Jun 2015 06:54:56 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([117.195.191.155])
        by mx.google.com with ESMTPSA id fk10sm5794158pab.18.2015.06.09.06.54.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2015 06:54:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <20150608191458.9f6a93b0259a8ca0324c8dc0@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271179>

On 06/08/2015 09:44 PM, Konstantin Khomoutov wrote:
> On Mon, 8 Jun 2015 9:45:17 -0500
> <hackerp@suddenlink.net> wrote:
> 
> [...]
>> My question is, will GIT work with MS access forms, queries, tables,
>> modules, etc?
> [...]
> 
> Git works with files.  So in principle it will work with *files*
> containing your MS access stuff.
> 
> But Git will consider and treat those files as opaque blobs of data.
> That is, you will get no "fancy diffing" like asking Git to graphically

More importantly, you won't get any *merging*, which means you need to
be careful about two developers making changes to the same file.

This is the only situation where locking (a feature that is inherently
at odds with the idea of a *distributed* VCS) is useful.

> (or otherwise) show you what exact changes have been made to a
> particular form or query between versions X and Y of a given MS access
> document -- all it will be able to show you is commit messages
> describing those changes.
> 
> So... If you're fine with this setting, Git will work for you,
> but if not, it won't.
> 
> One last note: are you really sure you want an SCM/VCS tool to manage
> your files and not a document management system (DMS) instead?
> I mean stuff like Alfresco (free software by the way) and the like.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
