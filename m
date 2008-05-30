From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] perl/Git.pm: add rev_parse method
Date: Fri, 30 May 2008 09:03:15 +0200
Message-ID: <483FA6B3.4070607@gmail.com>
References: <1212122585-7350-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 09:04:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1yep-00032Z-Ue
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 09:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730AbYE3HDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 03:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754256AbYE3HDT
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 03:03:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:9230 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035AbYE3HDS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 03:03:18 -0400
Received: by fg-out-1718.google.com with SMTP id 19so54506fgg.17
        for <git@vger.kernel.org>; Fri, 30 May 2008 00:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=GjkpKcoePTafDMl8+J7z2JdPg++Kga3o3jAHL8a5wz0=;
        b=ko3ysSf25w4MXEdv1Uui8Q3h1i4wXxGxneMcsiAuzNVPGStsaa33l+tWvYkTiyXOfSp2Dh3cLPPPR4Ka3X/RL5vcVH6wGPFesavhuX9r8ytaR8YLPiWoX7OWG1S9hjsk8mYzpA/whAduEPK0wal+/96YSfrHI72Fqzq2+VB3c9E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=DTl7NWIfrjrlyRzp5kGcCUObJvIRtZxZAkVUCBp+JssMNyy6Y8sTR+f2JZJ/S3tlxuFpY7Mg12m8GpoOENL8v7GXYWGe1Pm19UHHRp5pdY4po7id4W8cnzkBSLGGc5o0K1Tb/+wsUzWwX/b/IDmQ6GuFPoCg0LdwbSqz8SGhbck=
Received: by 10.86.96.18 with SMTP id t18mr946321fgb.17.1212130997282;
        Fri, 30 May 2008 00:03:17 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.225.53])
        by mx.google.com with ESMTPS id e20sm205093fga.7.2008.05.30.00.03.15
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 May 2008 00:03:15 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <1212122585-7350-1-git-send-email-LeWiemann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83269>

I wrote:
> [Commit:] The rev_parse method translates a revision name to a SHA1 hash, like
> the git-rev-parse command.

Oh, here's one problem: I'll probably do a lot of changes to Git.pm, and 
it might be handy for me to be able to change my own methods later.   I 
definitely wouldn't like to see Git.pm end up in some release while I'm 
in the middle of a major refactoring.

Should I perhaps stay on my branch with these changes, and then merge 
when it has stabilized (in 1-3 months)?

One thing I'd be concerned about is that I might introduce fundamental 
issues in my API, since I'm neither a Git nor a Perl expert (yet ^^). 
What's the best way to avoid discovering such issues only at the Big 
Merge?  Is there anyone who'd be willing to monitor my commits and give 
me feedback on a semi-continuous basis?

(I'm working on this more-or-less fulltime as part of a Google Summer of 
Code project.)

Best,

     Lea
