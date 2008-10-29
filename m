From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: Do most people feel tracking branches useful?
Date: Wed, 29 Oct 2008 17:58:05 +0800
Message-ID: <490833AD.70806@gmail.com>
References: <49082514.9050405@gmail.com> <buoprlj4vle.fsf@dhapc248.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Wed Oct 29 10:59:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kv7po-0003j5-D2
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 10:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752994AbYJ2J6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 05:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752810AbYJ2J6P
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 05:58:15 -0400
Received: from ti-out-0910.google.com ([209.85.142.185]:46677 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792AbYJ2J6O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 05:58:14 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1642658tic.23
        for <git@vger.kernel.org>; Wed, 29 Oct 2008 02:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=n6OTOWb/AxD3ixsiZ2YySRp27TA2XdTpnMiUpKTVvj4=;
        b=Vrra7QqQ0N7whUYFlzGmGkyk2mvVZvgUK2gbcPhyfnqr7ep7e/k45/L5jqFcM05ftv
         gRb2b2+fz53YvwYwLlA/rL8AQWXLErGBQMxr1Zbxi6HWwqdQOaiX4cSsbYhOx1YKnFth
         5iVGxhYPPKhOPVWirLEd7gIiETUKdwuUTjNMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Ff2+43IgT2cFoeA3KAuPQIu+sbkS8X4e5wYVsdvOkdGgVv1Ea4o4QahqjPzy5QViAU
         xawhnsRE6OuStRSDtETCfN/kNYKTioImn8k46JseLhXv+34CjqxnxZE+nylLYr35T4/R
         5jPnmMA0BLCalT69PPQiIIvduY8Xk8Pa3/I6c=
Received: by 10.110.7.18 with SMTP id 18mr5582234tig.47.1225274291883;
        Wed, 29 Oct 2008 02:58:11 -0700 (PDT)
Received: from ?10.64.1.142? ([211.157.41.194])
        by mx.google.com with ESMTPS id b4sm6281048tic.2.2008.10.29.02.58.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Oct 2008 02:58:10 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <buoprlj4vle.fsf@dhapc248.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99355>

Miles Bader wrote:
> Liu Yubao <yubao.liu@gmail.com> writes:
>> do most people feel tracking branches useful?
> 
> Extremely useful.  I usually keep local branches closely synchronized
> with a remote "central" version, and tracking branches make the frequent
> push/pull much more convenient.
> 
In my work flow, I don't keep changes in local branch for long time,
I rebase it regularly and push them to central branch or discard them
if the upstream rejects.

You are right, I realize tracking branches is useful for people who keeps
local changes for long time and track the upstream branch at the same time.

But I guess an auto-rebasing policy is more sensible than auto-merging policy
because I won't get many useless "Merge branch 'xxx' of ..." messages in the
history.

Another problem about tracking branch is `git pull` won't merge tracking branch
with remote branch when the current branch isn't tracking branch, it warns me
"You asked me to pull without telling me which branch you ....". It's not
convenient to checkout tracking branch and execute `git pull` then switch back
to my working branch.
