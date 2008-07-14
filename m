From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Closing the merge window for 1.6.0
Date: Mon, 14 Jul 2008 01:50:05 -0700 (PDT)
Message-ID: <m363r8u9xk.fsf@localhost.localdomain>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
	<7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
	<7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
	<7vmyn4hr8f.fsf@gitster.siamese.dyndns.org>
	<7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
	<7vabijxhk4.fsf@gitster.siamese.dyndns.org>
	<7vwslhg8qe.fsf@gitster.siamese.dyndns.org>
	<7vhccfiksy.fsf@gitster.siamese.dyndns.org>
	<7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
	<7v4p7xwsfp.fsf@gitster.siamese.dyndns.org>
	<7v3anb19n7.fsf@gitster.siamese.dyndns.org>
	<7vwskjazql.fsf@gitster.siamese.dyndns.org>
	<7vk5ggipuw.fsf@gitster.siamese.dyndns.org>
	<7vej6l3lp7.fsf@gitster.siamese.dyndns.org>
	<7vod5kd3im.fsf@gitster.siamese.dyndns.org>
	<7v3amv1e8n.fsf@gitster.siamese.dyndns.org>
	<7vprpwhp7t.fsf@gitster.siamese.dyndns.org>
	<7vlk0ffhw3.fsf@gitster.siamese.dyndns.org>
	<7vtzf1w0rj.fsf@gitster.siamese.dyndns.org>
	<7vabgqsc37.fsf@gitster.siamese.dyndns.org>
	<7vtzetjbif.fsf@gitster.siamese.dyndns.org>
	<7vzlokhpk7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 10:51:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIJm0-0003dF-4F
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 10:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755600AbYGNIuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 04:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755455AbYGNIuJ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 04:50:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:59573 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505AbYGNIuI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 04:50:08 -0400
Received: by ug-out-1314.google.com with SMTP id h2so205093ugf.16
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 01:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=gdwGD37ueJW7Ze69p1gutJRtQh5QjxZK+nxDHeZbghM=;
        b=NMkW1YJQczxoCi6Fkd8u3pyI3f49VEfqqcFitCUJDlsVOl/izvUHK2iO8gnnK4VWI3
         AOj67vMsTkqscIuLw739JoRfWyJuOHESc5+TCCFe7DMEb5Pf8+qyaQsSvqUBYgcjGjd0
         oJF/XNQtY5/b/BE3NdKSd7Udw1lyw3Jlyni8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=lhisayQ5EO/pAeJo1pnCawJAK80m+QeXi8OQk4IjnQGDoi5lqxsErcP8egdJig/Ueo
         Sett7flpfj4k5VnJjSpQQ3YPTWam+9QxAfSU7QtrSfhscIRgAwiPBWcEIcEFb0jWLzsa
         EZAcrAGWj4uEaZKipY8yYTlD7fhXpbcvgBgjU=
Received: by 10.66.245.2 with SMTP id s2mr1533969ugh.80.1216025406444;
        Mon, 14 Jul 2008 01:50:06 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.211.66])
        by mx.google.com with ESMTPS id 13sm1616188ugb.46.2008.07.14.01.50.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Jul 2008 01:50:05 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6E8o10t005441;
	Mon, 14 Jul 2008 10:50:01 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6E8nxJF005438;
	Mon, 14 Jul 2008 10:49:59 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vzlokhpk7.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88401>

Junio C Hamano <gitster@pobox.com> writes:


> GIT v1.6.0 Release Notes (draft)
> ================================

> * By default, stash entries never expire.  Set reflogexpire in [gc
>   "refs/stash"] to a reasonable value to get traditional auto-expiration
>   behaviour back

And, of course, one can set up reflog expiration per ref or per 
ref type (for example never expiring stash, making expiration for
HEAD longer than default, and for remote-tracking branches shorter).
 

> * git-stash also learned branch subcommand to create a new branch out of
>   stashed changes.

Typography: wouldn't it be better to use "learned 'branch' subcommand"?
 
-- 
Jakub Narebski
Poland
ShadeHawk on #git
