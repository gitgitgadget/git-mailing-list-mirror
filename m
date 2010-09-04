From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: usage for git-p2p (was: git pack/unpack over bittorrent - works!)
Date: Sat, 04 Sep 2010 17:08:28 +0200
Message-ID: <4C8260EC.9000404@gmail.com>
References: <AANLkTin0-Zjy7Chvntf2pNj5iCQ-4Y5u=bu8r7DSejeu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>, Ted Ts'o <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 04 17:08:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OruMD-0002xW-QS
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 17:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753755Ab0IDPIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 11:08:36 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33063 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443Ab0IDPIf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 11:08:35 -0400
Received: by wwj40 with SMTP id 40so4189753wwj.1
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 08:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=4aTdqsUpV2mmxZzhLbES2Ypw013NTA0J+87BQjR3Wv0=;
        b=yCVQCmSulTC1Q3KlFDuicFOpjgf64MKxopmPzQkVLy1lNxizsKRx9Q/cbB1ITsS/8c
         BksRZvdWVMxvn+nSWwS2zLUmvhUVmEBzKGgS4DmjcmdajvU5l+ATjM0RFLA0qoz0tEbW
         5VrdnE/lGKpRvllgC1ySNiXGLBUQ1P4/tS0+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=oa8V4ZpT3DToaaPUPbiVwUip3bJ03vvQjPvrPTXPfAHg6uatd9P5E3oXIvuBo9LogT
         NgksaZQpH1+deYTcTDY7R87nvlGbaEzFpb5N15t0e/HlPEJuwcgg4MxGwVFBoJngARr4
         opzMtZmi5bGxKc0xzyt1aeZokTZzNUzV9lSE8=
Received: by 10.216.154.133 with SMTP id h5mr1886714wek.93.1283612911559;
        Sat, 04 Sep 2010 08:08:31 -0700 (PDT)
Received: from [172.19.43.221] (ip-89-174-124-83.multimo.pl [89.174.124.83])
        by mx.google.com with ESMTPS id w29sm2041616weq.42.2010.09.04.08.08.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 08:08:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.9pre) Gecko/20100819 Lightning/1.0b2 Lanikai/3.1.3pre
In-Reply-To: <AANLkTin0-Zjy7Chvntf2pNj5iCQ-4Y5u=bu8r7DSejeu@mail.gmail.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155331>

On 09/04/10 13:54, Luke Kenneth Casson Leighton wrote:
> On Sat, Sep 4, 2010 at 2:52 AM, Artur Skawina <art.08.09@gmail.com> wrote:
>> Hmm, taking a few steps back, what is the expected usage of git-p2p?
>> Note it's a bit of a trick question; what i'm really asking is what _else_,
>> other than pulling/tracking Linus' kernel tree will/can be done with it?
> 
>  i'm _so_ glad you asked :)  please note - for all of these i'm keenly
> aware that GPG signing is required (and nicolas has pointed out that
> you only need a 20-byte hash to be securely transferred by some OOB
> mechanism)
> 
>  * distribution of large mailing lists and reduction of load on SMTP

>  * distributed wikis.  there are lots of wikis now using git: ikiwiki

>  * distributed bugtrackers.  the one that i know of which i believe

>  * of course there's source management for other projects other than
> linux-2.6 :)

I'm not sure that git fits well any of the above; it may be convenient
to reuse git as it already exists and can be more or less easily plugged
in, but it's probably not the best backend choice. The one that might
map relatively closely to git is wikis, but there i'm not sure something
more scalable wouldn't be better (eg how would wikipedia map onto git..)


The one other use case for git-p2p that i can see is distributing the
object store over a LAN. But it's really about a _remote_ object store,
not so much a distributed one.
IOW, having git-checkout trying to reach "/tmp/.git-unix/G0" and then any
remote object store in addition to ".git/objects" would be very useful.
But, do you actually want to spread the objects on _every_ developer
desktop on the LAN? Wouldn't it much more make sense to have two or three
dedicated "object servers", which would give you enough redundancy and,
because of the higher chances of finding the required objects in cache,
also perform better?

For the case of an ad-hoc group of developers, the protocol described in
my previous email would work well, they only need to find one peer and
then can move objects back and forth in the swarm.


One of the advantages that git-p2p could bring is better packing -- instead
of everyone running git-repack with a limited window, each peer in the swarm
could better use its resources by looking much deeper for the perfect delta
candidate, but only for a subset of the objects, and then share the results
with the rest. As a "git-repack -a -f" can eg shrink the gcc.git repo by ~15%
(~100M) the savings could be noticeable.

artur
