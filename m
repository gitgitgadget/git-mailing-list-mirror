From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] builtin/merge_recursive.c: Add an usage string and
 make use of it.
Date: Tue, 31 Aug 2010 18:42:26 -0500
Message-ID: <20100831234226.GF6747@burratino>
References: <20100830024259.GC4010@burratino>
 <b58adc6cdfd6a5753fac1dde3371b3745b1f58b1.1283138840.git.tfransosi@gmail.com>
 <7vk4n8hc05.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 01:44:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqaV5-0006aI-2L
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 01:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458Ab0HaXoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 19:44:14 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59499 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969Ab0HaXoN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 19:44:13 -0400
Received: by vws3 with SMTP id 3so5929540vws.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 16:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/7b7WPXELUrWH3jYzluxsMutvDuZGePMZViVFLnp6hA=;
        b=KP0E/AzVUohq/crBuzyMi2cdGpKFDzRezyuHUg/T/6WiUBBbcSPLLWmTB0SxUG051f
         3Oe+v6WnNCUUU68Mh1IO30cX3Y4hmS248UF9a2hYLXBG8pdKxHDG+8GEik0JuU96daTl
         /QYW/NIC0z8oCFol1sbfauvREFyNUim5rDusE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IERHXLVfX7SAlMpCj1twgN7pwPJnH7sjTh3BRtPazOLUSZsdweit73EfNP6EP0Btlo
         ZY2cjBVo0gKy9+Xtsi6pSQ+EdL2rA6Ur5LJLBRH+UGWUXUM8YL/aDd/a/Pbq5GFhnuWP
         l8tV5IvM5DClheMF58vEIYXkXKa9UAXEIF2bM=
Received: by 10.220.128.132 with SMTP id k4mr3937753vcs.257.1283298252080;
        Tue, 31 Aug 2010 16:44:12 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id u2sm3184599vcr.8.2010.08.31.16.44.10
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 16:44:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vk4n8hc05.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154996>

Junio C Hamano wrote:

> Hmm, why isn't this a single liner
>
>> -		usagef("%s <base>... -- <head> <remote> ...", argv[0]);
>> +		usagef("git %s <base>... -- <head> <remote> ...", argv[0]);

I can't speak for Thiago, but I assume it's for unity of style with
more complicated commands like "git fetch" that include a usage
message at the top of the file as:

 - a quick introduction for people who don't like to scroll

 - a variable that can be used from other functions when command-line
   mistakes are noticed late.

I would have gone for the one-liner, myself.
