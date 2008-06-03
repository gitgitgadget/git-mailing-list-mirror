From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Octopus merge: unique (?) to git, but is it useful?
Date: Tue, 3 Jun 2008 08:39:57 +0200
Message-ID: <200806030839.58214.jnareb@gmail.com>
References: <200806030314.03252.jnareb@gmail.com> <alpine.LFD.1.10.0806021845210.3473@woody.linux-foundation.org> <7vy75n3zus.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 08:41:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3QD2-0001cI-1B
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 08:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbYFCGkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 02:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752519AbYFCGkH
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 02:40:07 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:59299 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbYFCGkF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 02:40:05 -0400
Received: by nf-out-0910.google.com with SMTP id d3so536638nfc.21
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 23:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=/Q70BLKMdRycVZrIbD+uOGD3JoKgE+ZntHUjFPlpZAA=;
        b=qR9rrRVAGAkN45mqYV5vFzG6tdYboNy8BrlzoO8rmuF91l31oPxTPD6P8HeIf8vQFV0AkcUPr02LzPM5Zgio2t1pqarN9YStfxRZk6Go8j33xGr21tRSUWnd9CZxCcmPYITkZ0u+NHbZ5vIsAYb/w2UBtFe9PZquh/7VL6KZC24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lzm3OTaksinDFoDNfLoSaj8gA3JqAJ3WLDsrvEKqyUIsnWojWg5HycXtePVUtI6f3O8LFOBVsda9DIXBpDzHR6uHq+Rkya/OHl+B/C4F60JRNXzxnWLsZVjHrmveMScR/3SW1OwE5cDr46m7SgVIuW82AYqP4It03f6TRj/ZWO0=
Received: by 10.125.119.3 with SMTP id w3mr149278mkm.24.1212475204196;
        Mon, 02 Jun 2008 23:40:04 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.244.52])
        by mx.google.com with ESMTPS id 7sm36480690nfv.32.2008.06.02.23.40.01
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 23:40:02 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vy75n3zus.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83620>

On Tue, 3 June 2008, Junio C Hamano wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
>> Actually, it's trivial to convert to other SCM's, although I guess the 
>> conversion tools haven't really tried. You can always turn it into a 
>> series of multiple merges. Yes, you lose information, but it's not like 
>> you lose a huge amount.
> 
> One thing to worry about is what tree object you would give to each of
> these "artificially split" merge commits, though.

There shouldn't be, I think, a problem if octopus merge was done using
'octopus' merge strategy, which requires IIRC tree-level (trivial)
merge.  But true, it is a complication, unless we fake history more,
and always use result for octopus merge as a tree.

-- 
Jakub Narebski
Poland
