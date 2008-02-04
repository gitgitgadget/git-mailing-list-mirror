From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-rebase.sh: Update USAGE string (No. 1)
Date: Mon, 4 Feb 2008 13:53:23 +0100
Message-ID: <200802041353.25592.jnareb@gmail.com>
References: <prvd3i9e.fsf@blue.sea.net> <200802041115.22409.jnareb@gmail.com> <20080204115741.GA23834@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Feb 04 13:54:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM0pt-00007A-J2
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 13:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752820AbYBDMxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 07:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbYBDMxg
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 07:53:36 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:58130 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbYBDMxf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 07:53:35 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1141515ugc.16
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 04:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=dNxCwjgpJ3Tvv6llGIy8tk8ar+POy63smJJPs7L3enE=;
        b=wY+A/PARejXiZYHoholkqghmcRFc1DP/pmoGE63zkI16L1AoEDJ4d2htYDN2pHZ/+/DIp/BanvW8pJ+1oEkuxZKcr5nDKk0DW23xBQAOnQlW9yCv8r2bngoesdokXSNKq07ijwPIolRnMtDdUlLJyjdlcg92477OrF/q0ok8U+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mjp0exC/NRppE1cbt7iPl9tOZV8ChTeMkYMB9dXtIfSy1aWQ58UJT5REjUxYKcegZY+rV99BH/A/PK3ovX0e5w3WOZ6GWBwK/+i4suIAETINlhgQKUKLM3IzmhppAuAuJBey2qEwq3GPVRvUyum4joU1Tl5iKVQkPHJXuK4UUMk=
Received: by 10.67.116.15 with SMTP id t15mr1310605ugm.21.1202129614256;
        Mon, 04 Feb 2008 04:53:34 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.221.201])
        by mx.google.com with ESMTPS id 30sm20054557ugf.31.2008.02.04.04.53.31
        (version=SSLv3 cipher=OTHER);
        Mon, 04 Feb 2008 04:53:33 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20080204115741.GA23834@glandium.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72500>

On Mon, 4 Feb 2008, Mike Hommey wrote:
> On Mon, Feb 04, 2008 at 11:15:20AM +0100, Jakub Narebski <jnareb@gmail.com> wrote:
>> Junio C Hamano wrote:

>>> Unfortunately, the majority of, if not all of, our existing
>>> documents use () instead for that purpose.
>>>
>>> So pros-and-cons are that [...] (2) our use of (), as we
>>> consistently use them, does not hurt readability (neutral); and

The above was re-added by me.

>> Actually we are not entirely consistent here.  git-init(1) has 
>>   --shared[={false|true|umask|group|all|world|everybody}]
>> in the option description, git-rev-list(1) has
>>   [ --date={local|relative|default|iso|rfc|short} ]
> 
> What is inconsistent here ? The first tells you you can use --shared without
> an argument. And it's [--shared[=<permissions>]] in the synopsis, so you
> may omit --shared, or use in alone, or specify permissions. The second tells
> you can't use --date without an additional argument.

You have cut a bit too much when quoting. The inconsistency is between
git-branch(1) using () to delimit mutually exclusive options:

   git-branch (-m | -M) [<oldbranch>] <newbranch>

and git-init(1) (and git-rev-list(1)) using {} for that:

   --shared[={false|true|umask|group|all|world|everybody}]

-- 
Jakub Narebski
Poland
