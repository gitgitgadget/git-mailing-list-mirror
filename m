From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 02:48:49 +0200
Message-ID: <200610180248.49713.jnareb__4216.28244589574$1161134967$gmane$org@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <20061018002523.GJ20017@pasky.or.cz> <4535778D.40006@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Sean <seanlkml@sympatico.ca>, Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 02:51:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZzbZ-0002KH-2n
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 02:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWJRAsS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 20:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWJRAsS
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 20:48:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:17297 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751201AbWJRAsR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 20:48:17 -0400
Received: by ug-out-1314.google.com with SMTP id o38so78058ugd
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 17:48:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ehnzkldHOYxC4oboI3xgEnzeCz0OmrLuyYAPRjIS540zeWLv8HhSZBUppi8yxrLnXkIq5r50OSYyoGMKdlL0gTfEGifbTWF08QlFctVQJ2aF5Tk23/9cNmc5+//4hTaKQPgytoPZtQUmxubP6Ow3TAeS72eUgJ/BK9sE61KHsXg=
Received: by 10.66.244.11 with SMTP id r11mr10812019ugh;
        Tue, 17 Oct 2006 17:48:16 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
        by mx.google.com with ESMTP id k28sm325716ugd.2006.10.17.17.48.15;
        Tue, 17 Oct 2006 17:48:16 -0700 (PDT)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
User-Agent: KMail/1.9.3
In-Reply-To: <4535778D.40006@utoronto.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29164>

Aaron Bentley wrote:
> Petr Baudis wrote:
>>> this only makes sense if
>>> you have a fast access to the repository (otherwise, you consider your
>>> local repository as a cache, and you're ready to pay the disk space
>>> price to save your bandwidth). In this case, it's often in your
>>> filesystem (local or NFS).
>>
>> So how is the light checkout actually implemented? Do you grab the
>> complete new snapshot each time the remote repository is updated?
> 
> No, the lightweight checkouts store very little.  They have
> - a copy of tree shape (filenames, paths, sha1 sums) from the last
>   commit.
> - a copy of tree shape for the current working directory
> - a map from stat values to sha-1 hashes

Ah. So in git terminology it stores index and working directory
(and perhaps the name of branch). 

-- 
Jakub Narebski
Poland
