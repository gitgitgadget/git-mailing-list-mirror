From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Thu, 29 Nov 2007 21:03:40 -0500
Message-ID: <474F6F7C.5050409@gmail.com>
References: <20071127160423.GA22807@laptop> <Pine.LNX.4.64.0711271617350.27959@racer.site> <20071128000731.GD9174@efreet.light.src> <7v8x4jb295.fsf@gitster.siamese.dyndns.org> <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com> <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org> <20071129150849.GA32296@coredump.intra.peff.net> <fcaeb9bf0711291205h125dadbbp8e8ae392e9b5b751@mail.gmail.com> <20071129211409.GA16625@sigill.intra.peff.net> <Pine.LNX.4.64.0711292218240.27959@racer.site> <20071129231444.GA9616@coredump.intra.peff.net> <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org> <7veje8twt2.fsf@gitster.siamese.dyndns.org> <474F5E90.9040505@gmail.com> <Pine.LNX.4.64.0711300053260.27959@racer.site>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 30 03:04:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxvF6-0008AH-Ms
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 03:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933255AbXK3CDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 21:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761824AbXK3CDr
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 21:03:47 -0500
Received: from el-out-1112.google.com ([209.85.162.182]:44519 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761361AbXK3CDp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 21:03:45 -0500
Received: by el-out-1112.google.com with SMTP id v27so1004932ele
        for <git@vger.kernel.org>; Thu, 29 Nov 2007 18:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=lKfPYNGcys/QTl4nqiTf1OH07D9g8BAxyvCw4AqiNE0=;
        b=anmT/NVEEHlHmFL7HDJnPvYtUP4SHzY0O/ZnezGpn4aH7v5W2t17ZjPbA3rqzgqA3g1V/PtKV6CkS9SVgEUf5QpQkahrcCzDQf1oWFaek6/o+tP6GmiP5G96NTSuNQrTbD2FqSMoBrdys0c8XE9WgeiIKlR+rLX3d5LeBp0rs2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=kqzMD/8a1+QkPd+fbhjTB8xNzUSZX2zWVU2g0tHLcXha8JWLf3UOVhhLUTf8HAQwshp6TRlYa5TiOLahvU2kfsRUboqPoHbR+QU6XMoHKosPo36kEjHlt3HL1fOpEY61bpNre2rN6q60jx9FSfRZoQSa15ITSPyYswXbQXUz/8Y=
Received: by 10.70.111.15 with SMTP id j15mr101875wxc.1196388224124;
        Thu, 29 Nov 2007 18:03:44 -0800 (PST)
Received: from ?10.0.0.6? ( [66.177.19.100])
        by mx.google.com with ESMTPS id i11sm8957201wxd.2007.11.29.18.03.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Nov 2007 18:03:43 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <Pine.LNX.4.64.0711300053260.27959@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66602>

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 29 Nov 2007, A Large Angry SCM wrote:
[...]
>> Again, there needs to remain support in the Makefile to install the "dashed"
>> versions of the commands for those that want it; and be able to set
>> gitexecdir=$(binder) without editing the Makefile.
> 
> Umm.  Why?  If there is no compelling reason (and you named none, but 
> there were quite a few reasons against it), why should the Makefile 
> support the dash form after 1.5.6?

Not all shells support customized command completion (check the 
archives); "bang" history (check the archives); etc.
