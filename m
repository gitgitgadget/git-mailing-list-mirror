From: "Evan Carroll" <me@evancarroll.com>
Subject: Re: git-peek-remote vs git-pull (error in latter)
Date: Mon, 13 Aug 2007 17:32:06 -0500
Message-ID: <428b865e0708131532x2140298dq3ac8242e51ad72c7@mail.gmail.com>
References: <428b865e0708131501m45b6e2f9t9926821cf93b7abc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 14 00:32:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKiSR-0007Zf-2G
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 00:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115AbXHMWcM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 18:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752671AbXHMWcK
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 18:32:10 -0400
Received: from rv-out-0910.google.com ([209.85.198.186]:50587 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336AbXHMWcI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 18:32:08 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1283353rvb
        for <git@vger.kernel.org>; Mon, 13 Aug 2007 15:32:07 -0700 (PDT)
Received: by 10.141.63.20 with SMTP id q20mr2733241rvk.1187044326142;
        Mon, 13 Aug 2007 15:32:06 -0700 (PDT)
Received: by 10.141.212.7 with HTTP; Mon, 13 Aug 2007 15:32:06 -0700 (PDT)
In-Reply-To: <428b865e0708131501m45b6e2f9t9926821cf93b7abc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55792>

It appears as if the error is from git-ls-remote which has a bug
(somewhere) in its --upload-pack

On 8/13/07, Evan Carroll <me@evancarroll.com> wrote:
> I'm having a *major* problem with git-pull and ssh locations. Notice
> the bottom works, and the top not so much can't find --upload-pack. As
> an aside, an error when people try ssh://user@location/ an error would
> be nice. die "Bad ssh-location syntax" if $cmd =~ /^ssh:/
>
> ecarroll@x60s:~/Desktop/scraper$ git pull
> --upload-pack=/home/dealermade/bin/git-upload-pack
> dealermade@chason:/home/dealermad
> /Desktop/scraper/.git
> sh: /home/dealermade/bin/git-upload-pack: not found
> fatal: The remote end hung up unexpectedly
> Cannot get the repository state from origin
>
> ecarroll@x60s:~/Desktop/scraper$ git-peek-remote
> --upload-pack=/home/dealermade/bin/git-upload-pack
> dealermade@chason:/home/dealermade/Desktop/scraper/.git
> 00af556bab4850c1f52eb259445688689f1dd4ff        HEAD
> 00af556bab4850c1f52eb259445688689f1dd4ff        refs/heads/master
> fe0e395cc4161071ac871215919563edc8de59c3        refs/heads/origin
>
> Please cc me in all correspondence, me@evancarroll.com
>
> Thanks again!
>
> --
> Evan Carroll
> System Lord of the Internets
> me@evancarroll.com
> 832-445-8877
>


-- 
Evan Carroll
System Lord of the Internets
me@evancarroll.com
832-445-8877
