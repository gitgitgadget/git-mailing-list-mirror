From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: CGit and repository list
Date: Sat, 13 Sep 2008 22:02:26 +0200
Message-ID: <8c5c35580809131302w1f51f4ebsede59eb2ae36a99c@mail.gmail.com>
References: <19449377.post@talk.nabble.com>
	 <20080912145804.GF10544@machine.or.cz>
	 <8c5c35580809120810s69e8ec4fnf2a629d4cf575901@mail.gmail.com>
	 <200809121812.40920.johan@herland.net>
	 <20080912224817.GF10360@machine.or.cz>
	 <8c5c35580809121620x2de1828cq498b3709f7b0bd1b@mail.gmail.com>
	 <20080913194938.GI10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johan Herland" <johan@herland.net>, git@vger.kernel.org,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Kristian H??gsberg" <hoegsberg@gmail.com>
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Sep 13 22:03:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KebLD-00086x-77
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 22:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbYIMUC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2008 16:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752625AbYIMUC2
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Sep 2008 16:02:28 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:38284 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752583AbYIMUC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2008 16:02:27 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1421302rvb.1
        for <git@vger.kernel.org>; Sat, 13 Sep 2008 13:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=LF2hnNX9m4L+oYiMLTJ7YEfhZQ0FO56eEy/81PHVLPc=;
        b=iN7ls1Cbnga3R+wGYBSzd30SHJz1EvafngUxW5R8CraCghpCG70kv8GRMoNzo3XutE
         JrtWsAf+QXvsOrN4GZkhza2trgOVSEKXBBt3GXUIWmtESZbiJxyjdmQMDBv1gFtRoZVR
         yB/lVJuVpIOns6iizh3HTv70nkWHCsus4lzUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=o21TNeHuRfc1+t6nKZv36hMGm24r9xJrrauqkQpntV0pDahi0GjxkSvsCeiMPfhyxL
         KqIWE6fPTg81DeLV6wA4uHqqblLyqdDkf1+2JZiECAezRzb6D7L1In5Za2od2smhTIqA
         pILQialz2qtwu3gKQXFs5oIXPcKBtt+3jMD6c=
Received: by 10.115.108.1 with SMTP id k1mr4635863wam.78.1221336146434;
        Sat, 13 Sep 2008 13:02:26 -0700 (PDT)
Received: by 10.114.166.20 with HTTP; Sat, 13 Sep 2008 13:02:26 -0700 (PDT)
In-Reply-To: <20080913194938.GI10360@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95814>

On Sat, Sep 13, 2008 at 9:49 PM, Petr Baudis <pasky@suse.cz> wrote:
> On Sat, Sep 13, 2008 at 01:20:50AM +0200, Lars Hjemli wrote:
>> I guess I could add support for something like
>>
>>   scan-paths=/pub/git
>>
>> in cgitrc (and optionally store the result of the scan as another
>> cgitrc-file in the cache directory). Would that improve things for
>> you?
>
> Yes, certainly.

Ok, I'll try to come up with something.


> I wonder why
>
>        http://repo.or.cz/c/libc.git/
>
> has such a funny-looking summary page.

I suppose you mean http://repo.or.cz/c/glibc.git/? It looks like cgit
dies when trying to process the tags in this repo. I'll clone it and
see if I can reproduce/fix the problem.


> Let me know if you want me to update cgit there sometime. In the next
> days I will add some means for switching between cgit and gitweb views.

Cool, I'll keep you posted ;-)

--
larsh
