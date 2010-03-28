From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Tree with leading '0' modes in 1.7.0.3
Date: Sun, 28 Mar 2010 19:28:28 -0400
Message-ID: <4BAFE61C.7060604@gmail.com>
References: <32541b131003261656h430d77a8q753c6141297e8f86@mail.gmail.com>	 <20100327013443.GE10910@spearce.org>	 <alpine.LFD.2.00.1003262142121.694@xanadu.home>	 <d411cc4a1003270544l43f2f93dq5006efb737aa7bbc@mail.gmail.com>	 <alpine.LFD.2.00.1003270959110.694@xanadu.home>	 <20100327191405.GF10910@spearce.org> <4BAE5CB9.6020905@gmail.com>	 <20100327193222.GI10910@spearce.org> <4BAE5EEC.5090804@gmail.com>	 <4BAE601D.6010205@gmail.com> <2e24e5b91003281038u486cd966w1d9263b897e7c9b9@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>,
	Scott Chacon <schacon@gmail.com>,
	"Mike.lifeguard" <mike.lifeguard@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 01:28:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nw1uG-0003Px-89
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 01:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755361Ab0C1X2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 19:28:31 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:48314 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755336Ab0C1X2a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 19:28:30 -0400
Received: by ywh36 with SMTP id 36so3016734ywh.4
        for <git@vger.kernel.org>; Sun, 28 Mar 2010 16:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=7dXwGx0zf5aQu+sm3th/1X0/kiouYzMmXdYv59+9qs4=;
        b=YJPr65Y/vRhmvI/aBlVrHkfV8iof0vmM/uiI/Z8+THKykCvpUyv0/MfOjFpyd+HQvr
         OIK/6dEOuzjy3orI8AbCBac1BMV/+ACKjsNK33QHD8xa28GBw6gNEBx/N/4zCU/UrjpX
         J4Baf3mTsV4ioryZdu32BsgIIVdBKKW1AsXB8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=bXZTYxA7WOEnEXxREgvoTDvKllpNRGuyAoosz+AtPT0Clfc7w2PPGNYedpbOCCdF/L
         RFCY1BES+gNvpPJ8vXzfX6r1Q/2ThP41jrDfZcLZuyDIwp89gk5Pd2mfCMg+SLtvDL5H
         XgNj1C9frBJB4jnM5rufE3ES7Qp4nax/53UOM=
Received: by 10.101.11.14 with SMTP id o14mr1237220ani.196.1269818910085;
        Sun, 28 Mar 2010 16:28:30 -0700 (PDT)
Received: from [10.0.0.6] (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 15sm2219016gxk.6.2010.03.28.16.28.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Mar 2010 16:28:29 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <2e24e5b91003281038u486cd966w1d9263b897e7c9b9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143422>

Sitaram Chamarty wrote:
> On Sun, Mar 28, 2010 at 1:14 AM, A Large Angry SCM <gitzilla@gmail.com> wrote:
> 
>> My combined repository also includes Scott's progit book and examples
>> repositories. I'm guessing that git-fsck did not limit itself to just the
>> object reachable from the torvalds/linux-2.6/master ref.
> 
> <struck speechless>
> 
> You have *one* repo containing both Scott's book and the Linux kernel
> tree?  "large angry SCM" is probably an understatement then... any SCM
> has the right to be angry mixing up things that are so unrelated!
> 
> Or did I totally, *totally* misunderstand...?
> 

You understood correctly. I use that repository to track activities in a 
number of different but related projects/communities. Scott's stuff has 
since been purged until he fixes the corruption.
