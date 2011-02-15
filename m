From: Gabriel Filion <lelutin@gmail.com>
Subject: Re: Mercurial over Git no success
Date: Mon, 14 Feb 2011 19:50:42 -0500
Message-ID: <4D59CDE2.1060903@gmail.com>
References: <1297717305.19327@davidwbrown.name> <AANLkTimWfC8UqYVNjr0MiE1QE+W0fVhZYi3wfxP1e29t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: david@davidwbrown.name, git@vger.kernel.org
To: knittl <knittl89@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 01:51:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp980-0001n0-V0
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 01:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978Ab1BOAut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 19:50:49 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58771 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546Ab1BOAur (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 19:50:47 -0500
Received: by qwa26 with SMTP id 26so3567813qwa.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 16:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=fLrPTP3rmtK4AwINH1Lqi6C/+K0IlkkO2ho9t/SCP8Y=;
        b=WO4Ldft4MumLoM3oi1uGNJKdneECDN0TVByS6AgrXwArfad32tT1zXr+VC/4GR8spS
         knVSYohKp57dmky7uEFIXARZyy9ljxfTQ5274WFp6qd/fra0xhkQpqlfTXHBH0qsMvzu
         yQz9yFAVd+sbXI0Uydl3qMfJQDVmXYCngT6k8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=u4SUi5elTT1So9mOzjBvVP3Uf/BqZbTjHFwEULVUQhNkfq/t8CcElPBKA7CmC+GoWY
         Z6RLW0Fwhs18o5yH1tbCVgAEWc6fY+azMYKhg0JYAJhGbQ3liOCaLlIncZFuMA+d3BJQ
         SvlqM7GEzLAeeyTqhygWoYRirLPdByyqsu2h4=
Received: by 10.224.28.76 with SMTP id l12mr4178qac.142.1297731045195;
        Mon, 14 Feb 2011 16:50:45 -0800 (PST)
Received: from [192.168.2.203] (dsl-144-127.aei.ca [66.36.144.127])
        by mx.google.com with ESMTPS id e29sm2214497qck.39.2011.02.14.16.50.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Feb 2011 16:50:44 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <AANLkTimWfC8UqYVNjr0MiE1QE+W0fVhZYi3wfxP1e29t@mail.gmail.com>
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166802>

On 11-02-14 04:26 PM, knittl wrote:
> On Mon, Feb 14, 2011 at 10:01 PM,  <david@davidwbrown.name> wrote:
>> > [...]
>> >
>> > ./configure
>> > make
>> > make install
>> >
>> > Does not work for building Git on my local Ubuntu box (10.10 BTW). Some non-innocuous error condition as follows:
> why not simply install the version of git that comes with ubuntu?
> `sudo apt-get install git` should do the trick ...
> 

If you'd like to use git's latest release, before it gets included into
an Ubuntu release, you can use this PPA:

https://launchpad.net/~git-core/+archive/ppa

Add it with the following command:

sudo add-apt-repository ppa:git-core/ppa

Then, sudo apt-get update; sudo apt-get install git

-- 
Gabriel Filion
