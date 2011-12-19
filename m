From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: [PATCH] Fix capitalization of "renamelimit" in docs to agree
 with code
Date: Sun, 18 Dec 2011 17:13:23 -0800
Message-ID: <4EEE8FB3.7070206@pcharlan.com>
References: <4EEE86AC.2030802@pcharlan.com> <7vsjkhnzkt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 19 02:13:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcRnN-0007CQ-0S
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 02:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055Ab1LSBN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Dec 2011 20:13:26 -0500
Received: from caibbdcaaaaf.dreamhost.com ([208.113.200.5]:51148 "EHLO
	homiemail-a80.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752053Ab1LSBNY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Dec 2011 20:13:24 -0500
X-Greylist: delayed 2311 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Dec 2011 20:13:24 EST
Received: from homiemail-a80.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a80.g.dreamhost.com (Postfix) with ESMTP id 11CF637A06B;
	Sun, 18 Dec 2011 17:13:24 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pcharlan.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=pcharlan.com;
	 b=CVWxlu0KmMs5BT/WCd0ZYZf6ywBoMZbhCjaPJvL9NdDImu7rpaAmm3mar7IMd
	SpdTVBj8gJngaISPnCyfTf39e5Ay5GsAJouLknv64iODbAsqdnxBkGOwcH7O5ygi
	Xmrc3lFqAML5j/pO+d0LUGwfRWWaqDoJbWogqel2pgXe0I=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pcharlan.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=pcharlan.com; bh=lZaq
	UNYNJu4ufSuGnf7Kc6r5oEI=; b=edHO1X03DQMZiFyj37v6Qcb8fQ16W+rdktbQ
	4YZFpXtHvQlFYyijp9eC2/ZDNI3dh5wioGEjrM2ddjLUOiP9iKoNJH6Wb6fX6zBo
	f+KnCS6FxAw6FGrN3L970roXUHCMEqLxuTcmQQlOtuAUUsplpBZaQMYzqlsT/cz/
	hIniPNg=
Received: from [192.168.0.101] (185.132-78-65.ftth.swbr.surewest.net [65.78.132.185])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pgit@pcharlan.com)
	by homiemail-a80.g.dreamhost.com (Postfix) with ESMTPSA id EB4BE37A065;
	Sun, 18 Dec 2011 17:13:23 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20111124 Thunderbird/8.0
In-Reply-To: <7vsjkhnzkt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187433>

On 12/18/2011 05:02 PM, Junio C Hamano wrote:
> Pete Harlan <pgit@pcharlan.com> writes:
> 
>> Signed-off-by: Pete Harlan <pgit@pcharlan.com>
>> ---
>> The documentation and bash-completion have always capitalized
>> "renamelimit" as "renameLimit".  The code has always lowercased the
>> whole name.  Repair the docs.
> 
> Please don't do this.

Sorry for the spam.  There was a circumstance at work where it appeared
clear that case wasn't being ignored and it bit us twice.  Obviously our
problem lies elsewhere; please forgive the intrusion.

SubmittingPatches says to send to you directly if (and only if) the
patch is ready for inclusion.  Next time I won't presume that a patch is
ready without review however obvious that may seem to me at the time.

--Pete

> Exactly because we treat the variable name part (and the top-level section
> part of three-part names) case insensitively, the code lowercases before
> comparing as an implementation detail.
> 
> However, you will be naming the same variable whether you spell it using
> all lowercase, or using camelCase (i.e. it does not really matter what
> case the user uses). The camelCase makes it slightly easier to see where
> the word boundaries are than alllowercase, and that is why we try to use
> it in our documentes, which is after all meant to be read by humans.
> 
> I would also appreciate if people tried not to overflow my mailbox with an
> incorrect patch that hasn't been discussed and hasn't seen concensus on
> the list that the particular change is a good thing to do, unless the
> patch is about an area that I am an area expert (you can see who the area
> experts are by asking "git shortlog --no-merges -n" or "git blame").
> 
> Thanks.
