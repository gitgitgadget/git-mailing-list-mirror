From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 10:14:01 +0200
Message-ID: <4860ACC9.3050407@gmail.com>
References: <alpine.LFD.1.10.0806232213360.2979@xanadu.home>	<willow-jeske-01l5PFjPFEDjCfzf-01l5ciVtFEDjCaD9> <willow-jeske-01l5e9cgFEDjCh3F>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: David Jeske <jeske@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 10:15:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB3gA-0003GR-BT
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 10:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272AbYFXIOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 04:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbYFXIOK
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 04:14:10 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:5655 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbYFXIOI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 04:14:08 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2674701fkq.5
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 01:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=6n4C/T6nGPStZJy7H86iYL+zfr5DsX7dlRHkUqR+2Jw=;
        b=XEkc4NtBKriJDTRuUzWEYNblJ+61uaGojUIdJVJbestgS4kvQBrlxB0O5EZsuzVfla
         hIEVSZyvko8tY4ZvR3gyQkSie2qVovf6HUABgWaEOB3fY6E8S+QpEgNCVQMVdRn0I48S
         LzTz3ueGVauPm5SIbJysUiOAw0EjhqOtszO/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=LsqRiA4K73p+OWKk6iX3IY3eQu84mq3rpoeTHcwjKfCMdUZCfobM9q7uMUfSPxUXIZ
         kNr/PHQ+dSOPlGJ4/hfm1quEfXRYoQ9W59bBsrXlldGrdMLvgMhx6YHEyGo8rWJvZ3iI
         4cMczvf6EfBFsLcaG7HkyM9YYxKV870T5POSE=
Received: by 10.78.155.4 with SMTP id c4mr3206021hue.19.1214295243560;
        Tue, 24 Jun 2008 01:14:03 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.198.167])
        by mx.google.com with ESMTPS id 35sm9587778huc.37.2008.06.24.01.14.01
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 01:14:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <willow-jeske-01l5e9cgFEDjCh3F>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86011>

David Jeske wrote:
> ... or we expect "human parsing of the the log" is a valid common
> user-interface for non-git developers.

As a side note, the reflog is not only a valid user interface, but an 
important one: As a local developer that feeds patches to the mailing 
list, I frequently change the history in my local repository (using 
rebase, reset and am, or pull --rebase) to keep the commits clean when 
they finally get merged upstream.  I *want* and *need* at least basic 
versioning for the various states my history is in.

IOW, I not only make changes to the tree and commit them to my master 
branch, but I also make changes to my master branch and "commit" them to 
(store them in) the reflog.

That's not an interesting use case if you're working on a branch that 
other people pull from, but for a local clone it's very useful.  (And 
it's a feature I haven't seen in any VCSes, FWIW.)

Best,

     Lea
