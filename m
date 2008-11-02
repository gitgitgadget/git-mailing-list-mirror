From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: libgit2 - a true git library
Date: Sat, 1 Nov 2008 17:26:28 -0700
Message-ID: <d411cc4a0811011726h1fb1ad0ct5c37af753940f4a4@mail.gmail.com>
References: <alpine.LFD.2.00.0810311558540.13034@xanadu.home>
	 <20081031234115.GD14786@spearce.org>
	 <alpine.DEB.1.10.0810311738100.5851@asgard.lang.hm>
	 <20081101010011.GG14786@spearce.org>
	 <alpine.DEB.1.10.0810311802360.5851@asgard.lang.hm>
	 <20081101010824.GE29036@artemis.corp>
	 <alpine.LFD.2.00.0810312121000.13034@xanadu.home>
	 <20081101014336.GI14786@spearce.org>
	 <alpine.LFD.2.00.0810312150200.13034@xanadu.home>
	 <20081101225714.GD15463@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Pierre Habouzit" <madcoder@debian.org>, david@lang.hm,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Nov 02 01:31:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwQs0-0006G0-1E
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 01:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbYKBA0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 20:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbYKBA0a
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 20:26:30 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:8126 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbYKBA03 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 20:26:29 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1062520wah.21
        for <git@vger.kernel.org>; Sat, 01 Nov 2008 17:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=RWPgizTEEZexa3PRpkgHmZh+HDnxOhUhCM9ZoHphPBA=;
        b=M0JDPkP0JfhQuLFdRyuMZmzQew9W+fYGgLbHGgQ57Gl8ac7/etZI8EAD3Lgte46nN8
         yiLFytz+K1izZTABe58T0ir8V3L+NJccCjsaRUVL8SHDtiwC/kwsZpp67J9kAUb0tY65
         imNG59pFw39I97yfUg5Vn7e5sWxQ6bUjiN5GI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=oqYDR33u4j+bpCY5UGbMrCEVPN+Es31uGG/RD8A8k65H9rctRJyVSMlG7OXU/xbJqq
         KGuhBoeB7ABcaPpuraolJMTp74fmc+rLo1wueLpLA9iM1ohnm7+lv9IEAUMIsaOEHTfV
         R8VYYQ/ypzKFV1iauFccL2PMhKb4NhPqew2qA=
Received: by 10.114.178.1 with SMTP id a1mr11474234waf.20.1225585588427;
        Sat, 01 Nov 2008 17:26:28 -0700 (PDT)
Received: by 10.114.135.18 with HTTP; Sat, 1 Nov 2008 17:26:28 -0700 (PDT)
In-Reply-To: <20081101225714.GD15463@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99790>

I'm sorry - why is that better than LGPL?  Wouldn't it be better to
use a license that people have heard of rather than one that can't be
looked up or it's implications easily researched?  What is this
affording the library that offsets the headaches of everyone trying to
figure out if they can use it or not?

Scott

On Sat, Nov 1, 2008 at 3:57 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Nicolas Pitre <nico@cam.org> wrote:
>> On Fri, 31 Oct 2008, Shawn O. Pearce wrote:
>>
>> > My take on the consensus for the license part of the discussion is
>> > that libgit2 should be under the "GPL gcc library" license.
>> >
>> > BTW, I can't actually find a copy of that license; the only thing
>> > I can locate in the GCC SVN tree is a copy of the LGPL.
>>
>> The exception is usually found at the top of files constituting
>> libgcc.a.  One example is gcc/config/arm/ieee754-df.S.  ;-)
>
> Headers updated.  Its now GPL+gcc library exception.
>
> Not that the 5 lines of useful code there really needs copyright,
> but hey, whatever.
>
> --
> Shawn.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
