From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Notes on supporting Git operations in/on partial Working Directories
Date: Sun, 17 Sep 2006 13:01:35 -0700
Message-ID: <450DA99F.8000009@gmail.com>
References: <4509A7EC.9090805@gmail.com>	<7vu03a2po8.fsf@assigned-by-dhcp.cox.net> <4509B954.60101@gmail.com>	<7v8xkl26kb.fsf@assigned-by-dhcp.cox.net> <450AEDBF.9050307@gmail.com> <7vvenm3h9f.fsf@assigned-by-dhcp.cox.net> <450D9847.4080308@gmail.com> <eek5l4$kaa$1@sea.gmane.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 22:02:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GP2qS-0003mL-7P
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 22:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWIQUBi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 16:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWIQUBi
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 16:01:38 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:36645 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932379AbWIQUBh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 16:01:37 -0400
Received: by wx-out-0506.google.com with SMTP id s14so3758713wxc
        for <git@vger.kernel.org>; Sun, 17 Sep 2006 13:01:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=dMoM7nrNeYlX1rhUkjiu7wlQIcD0FCOlm7/vLe5/ptQMEMhKkPt2N/3U2lEjGwrhDH4yaQ5TrQIhybeLtKorWdc5aqiUvEW6xm1+yd5EEdxyHdTZDatdjJTRcgH7YHi9fDr2wIRoATrVUFOtD8CzWHuinbK++azSTsMDYehc8xE=
Received: by 10.70.42.16 with SMTP id p16mr16961307wxp;
        Sun, 17 Sep 2006 13:01:37 -0700 (PDT)
Received: from ?10.0.0.6? ( [67.20.86.89])
        by mx.gmail.com with ESMTP id h8sm4015117wxd.2006.09.17.13.01.36;
        Sun, 17 Sep 2006 13:01:36 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eek5l4$kaa$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27201>

Jakub Narebski wrote:
> A Large Angry SCM wrote:
> 
>> There is no fundamental reason Git can not support partial 
>> checkouts/working directories. In fact, there is no fundamental reason 
>> Git can not support operations on partial (sparse?) repositories in both 
>> space (working content/state, etc.) and time (history); it's just a 
>> matter of record keeping[*1*]. That isn't how the Linux kernel 
>> developers want to use their VCS but it _is_ how others want to use
>> theirs. 
> 
> There is perhaps not much trouble with partial checkouts, but there is
> problem with partial _commits_, at least for snapshot based SCM (as opposed
> to patchset based SCM). 

By "partial commit" I take it you mean a commit with only partial 
information about the new (content) state? If so, the missing 
information about the new state can be assumed to have not changed from 
the previous recorded state (commit).
