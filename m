From: Chris Packham <judge.packham@gmail.com>
Subject: Re: question (possibly) on git subtree/submodules
Date: Fri, 23 Jul 2010 11:35:10 -0700
Message-ID: <4C49E0DE.8050506@gmail.com>
References: <xotjlj92i9gr.fsf@leonardo.pit.corp.google.com> <4C49C9C6.3080409@gmail.com> <20100723171859.GG2507@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 23 20:35:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcN5h-0002Wk-DE
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 20:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279Ab0GWSfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 14:35:19 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34751 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294Ab0GWSfS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 14:35:18 -0400
Received: by pzk26 with SMTP id 26so189474pzk.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 11:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=jnPV0CPeUm/uTlB64xhELAoleSASaFmqb7jlCpxWIvA=;
        b=KYLWTqkA1YEEgzg1Y1htSW2edd4z80viHJzPXtSIzRvjxmIF750Jf6uCXbIob2NFcw
         sXSmlrWy3iWDzjl87hWG6hUoKxavygY+GKz1jr7HzWRARuv6Dv9vzCiJxxotQsmka3kW
         iWfHqhY+pqV6akMzVT4Zv0lNEWBpLI8CfmzkM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=EMRaK2UvGBFWQBpah2S6BwYpAEtEN8otZlog3V/3Br/IQD8yegKNUGozwjrSm1/da7
         irJqSuqZh98MCjL55c5Okl18Hb7JlaVkKeZMwlAmCFFa3E72liulqIQdcXSPLZ49EwF3
         b4ZY4jdA9W3D3/qQVPemVhTrBoJgyG37KQj94=
Received: by 10.114.67.14 with SMTP id p14mr5725069waa.102.1279910118320;
        Fri, 23 Jul 2010 11:35:18 -0700 (PDT)
Received: from asus-laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id c24sm844319wam.19.2010.07.23.11.35.16
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 23 Jul 2010 11:35:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.10) Gecko/20100520 SUSE/3.0.5 Thunderbird/3.0.5
In-Reply-To: <20100723171859.GG2507@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151564>

On 23/07/10 10:18, Jonathan Nieder wrote:
> Chris Packham wrote:
> 
>> The short answer is no. Nothing git has currently will let you clone a
>> subset of files. Shallow clones exist if you want all the code and the
>> last X changes. The reason for this is git, like other DVCSes, tracks
>> _changes_ rather than _files_ this is something that took me a while to
>> get my head around when I was learning git.
> 
> Not quite as cut-and-dried as it may sound, I think.  Internally git
> compresses blobs (and other objects) by comparing them to other ones,
> but I do not think that is what you are talking about, and I do not
> see what that has to do with partial clones.  In fact, the main reason
> I can see that partial clones (in the sense of getting all metadata
> but not all blobs) are not implemented is that no one has written code
> for it yet.
> 
> Here is a thread on related work[1].  Maybe someone else can find a
> more pertinent link.
> 

OK I think I must have read to much into the "tracks changes" part,
thanks for pointing it out.
