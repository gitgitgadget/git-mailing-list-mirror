From: Allan Caffee <allan.caffee@gmail.com>
Subject: Re: [RFC/PATCH v2] graph API: Use horizontal lines for more
	compact graphs
Date: Wed, 22 Apr 2009 17:28:12 -0400
Message-ID: <20090422212812.GA30830@linux.vnet>
References: <alpine.DEB.1.00.0904211010410.10279@pacific.mpi-cbg.de> <20090421124701.GA25982@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 23:30:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwk1C-0002eO-Nh
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 23:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755871AbZDVV2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 17:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755317AbZDVV2T
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 17:28:19 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:7728 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753856AbZDVV2S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 17:28:18 -0400
Received: by wf-out-1314.google.com with SMTP id 26so162686wfd.4
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 14:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=+Pi+a6SDG3M7h9MS6GJ6rs/X40gCnnETZ1DSZRpPfw4=;
        b=uLbqM7y6jPYQ+OHfQqK+0kdzGAiD7Yo8D+q/vHKuYKQqf0G0oH9WlVEnxP3juxuBqY
         2X/TAZPfCEp1ustSgGYb2zwnKpdqm4V9SPhEB8yJW7T7aLGr8O3dx142fwwo1bwEyqHo
         hXvJESLMlhgcC9Ho6OXQNUtkR3t+5RfXsOnQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=c6ynbkxMhg7V+fpqXzjt2ClrraBe1FB4oKyxiEDacsCXiQOASKAV0mrMYO2eEfdyHh
         Bp3Uj3wEix3Df2iJEezDq+VbPyYfR5R51XvY17moNRpOF1sSoy+Q4cs8Wprfj7VSxUhG
         MpUIKYP6wiK4J++Viu8aK2sJrHy4CNuTvXXCY=
Received: by 10.142.12.14 with SMTP id 14mr75036wfl.63.1240435698332;
        Wed, 22 Apr 2009 14:28:18 -0700 (PDT)
Received: from linux.vnet (pool-71-185-49-127.phlapa.fios.verizon.net [71.185.49.127])
        by mx.google.com with ESMTPS id 29sm904674wfg.15.2009.04.22.14.28.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Apr 2009 14:28:16 -0700 (PDT)
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20090421124701.GA25982@linux.vnet>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117270>

On Tue, 21 Apr 2009, Allan Caffee wrote:

> Use horizontal lines instead of long diagonal during graph collapsing
> and precommit for more compact and legible graphs.

Please replace this message with:
----8<----------------
Use horizontal lines instead of long diagonal lines during the
collapsing state of graph rendering.  For example what used to be:

 | | | | |
 | | | |/
 | | |/|
 | |/| |
 |/| | |
 | | | |
is now
 | | | | |
 | |_|_|/
 |/| | |
 | | | |

This results in more compact and legible graphs.
---->8----------------

Notice that I dropped out the part about precommits.  Originally I
intended to utilize horizontal lines in pre_commit_line's as well.  But
partway through I decided to just do collapsing_line's for now since (a)
collapsing_line edges tend to extend much longer and (b)
pre_commit_line's are less common since they only occur when there is a
merge with at least three parents, and (c) the change for
pre_commit_lines is liable to be more complicated and error-prone.
