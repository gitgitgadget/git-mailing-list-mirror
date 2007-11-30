From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Thu, 29 Nov 2007 21:17:27 -0500
Message-ID: <474F72B7.9000305@gmail.com>
References: <20071127160423.GA22807@laptop> <Pine.LNX.4.64.0711271617350.27959@racer.site> <20071128000731.GD9174@efreet.light.src> <7v8x4jb295.fsf@gitster.siamese.dyndns.org> <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com> <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org> <20071129150849.GA32296@coredump.intra.peff.net> <fcaeb9bf0711291205h125dadbbp8e8ae392e9b5b751@mail.gmail.com> <20071129211409.GA16625@sigill.intra.peff.net> <Pine.LNX.4.64.0711292218240.27959@racer.site> <20071129231444.GA9616@coredump.intra.peff.net> <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org> <7veje8twt2.fsf@gitster.siamese.dyndns.org> <474F5E90.9040505@gmail.com> <alpine.LFD.0.99999.0711291959510.9605@xanadu.home>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Nov 30 03:17:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxvRw-0002ke-Vw
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 03:17:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760917AbXK3CRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 21:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758190AbXK3CRc
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 21:17:32 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:42651 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759873AbXK3CRb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 21:17:31 -0500
Received: by an-out-0708.google.com with SMTP id d31so436279and
        for <git@vger.kernel.org>; Thu, 29 Nov 2007 18:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=YLy4R/8fWEd4GSNPEd4wJqP2FzkKBlrqqnw1SV6Ej0U=;
        b=PJasLnMaagn7wOJSgMT5VyjuwmKbt1AGg1bS4i2UBffyVFYxeE5awAGE7SdyKnyK2I74+R3/bE8pvg5ek6w6/kU4tuKcwwGSTeHwank5R3hpdwiN1h2hY1j90YzhEs9mqnAMz8kS16OGpdXRKcT1I/6us5BzVyw/TPoyHB/6H7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=uRZ9QsSKEBlEHz4+xAF/0BBQDUPl40eFCQqjUtDhm5hK7Jxl1W/aU0s2VbPAol+y7Te4Cqqts5XIBoHDwZC598wXuetxDPe9KiBPW2rW6Ye8/aFACYD2zpe4/UblGQk6cDNQf0avW65g1hfBUTbJoU2HRE3KtW+kQ+PG0lbaaJ4=
Received: by 10.100.252.16 with SMTP id z16mr13064257anh.1196389050085;
        Thu, 29 Nov 2007 18:17:30 -0800 (PST)
Received: from ?10.0.0.6? ( [66.177.19.100])
        by mx.google.com with ESMTPS id 45sm7924936wri.2007.11.29.18.17.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Nov 2007 18:17:29 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <alpine.LFD.0.99999.0711291959510.9605@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66603>

Nicolas Pitre wrote:
> On Thu, 29 Nov 2007, A Large Angry SCM wrote:
> 
>> Again, there needs to remain support in the Makefile to install the "dashed"
>> versions of the commands for those that want it; and be able to set
>> gitexecdir=$(binder) without editing the Makefile.
> 
> Well, if you want a "non standard" installation, maybe you just can edit 
> a line or two in the Makefile?

Why do you object to a "install-dashed" Makefile target?
