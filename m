From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: friendlier names
Date: Wed, 28 Jan 2009 03:12:16 +0100
Message-ID: <200901280312.16717.jnareb@gmail.com>
References: <87mydc6a2r.fsf@mcbain.luannocracy.com> <m37i4gy2z6.fsf@localhost.localdomain> <7vocxsy1dd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	David Abrahams <dave@boostpro.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 03:13:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRzw6-0002oM-Kh
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 03:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbZA1CMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 21:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbZA1CMS
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 21:12:18 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:31400 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbZA1CMS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 21:12:18 -0500
Received: by fg-out-1718.google.com with SMTP id 13so365537fge.17
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 18:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=slVCk8Y8r6edpzzbr0nUqMktyUYrKir3ikPFTxGpqAY=;
        b=OEgBEPYHSNcHTNYzIXKTOcpGrat0Dkgj+Y9jMunb53tZDKlSpnu4CNuXJEwEOvSgYE
         xDM37R7jNhlHIQmjtxatSR8yQq+7r9z+v4HDxkE5GFqrZh1c8HOYCd02z75NANNsdIB/
         ODRcmNy0umfOCWq5VlSiaJYSne8nYvJZwASQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=BYm/xRYepPvZJ8kpUp4sxG1bnEwhUHFFluw1F4Q8rTF1UTohMN3Fh5XYQ44TOvS+Q6
         XJ1rKp83GOSD+4rFe7zss2pF3B33V7xsdoMToQa0VvdbBVPDqrmmqUVN0AXPEp2uUQZO
         CNs0THzO+bSx4POsuj6uswTDh6M+OSQlmfCcE=
Received: by 10.86.91.3 with SMTP id o3mr1043076fgb.35.1233108736176;
        Tue, 27 Jan 2009 18:12:16 -0800 (PST)
Received: from ?192.168.1.15? (abvq8.neoplus.adsl.tpnet.pl [83.8.214.8])
        by mx.google.com with ESMTPS id l19sm570691fgb.52.2009.01.27.18.12.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jan 2009 18:12:15 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vocxsy1dd.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107452>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > It is a bit of pity that "git add" was overloaded to also add new
> > contents and not only add new file (and its contents!), instead of
> > having new command "git stage" to be porcelain version of 
> > "git update-index" porcelain.  And perhaps "git resolved" to only
> > mark resolved entries (so e.g. "git resolved ." would not add new
> > files, nor add new contents of files which were not in conflict).
> 
> I do not think so.
> 
> People who are taught with various means (including "git stage" alias)
> understand that you prepare the contents you want to record in the commit
> you are about to make by updating the contents registered in the index aka
> staging area, then you do not need "git resolved".

"Who are taught". This makes for Git to be more "user selective".
Not that this matter much, as world domination is not our goal ;-)
 
> You resolve, you have the desired content in your work tree, and you
> register the updated contents from your work tree to the index aka staging
> area, in exactly the same way as you do when you want to include updated
> contents for any commit.

While I don't think that "git resolved" is something really needed,
the difference is with "git add ." and "git resolved ." and between
"git add *" and "git resolved *", where the latter would update only
resolved merge conflict resolutions, and would not pick up independent
changes to the files that were not in conflict.

BTW with "git add" way you have to know that "git add"-ing a file
would clear 'is in merge conflict' flags (well, will hide >0 stages...).

-- 
Jakub Narebski
Poland
