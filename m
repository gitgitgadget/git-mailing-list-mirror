From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: Resumable clone/Gittorrent (again)
Date: Fri, 7 Jan 2011 15:59:56 +0000
Message-ID: <AANLkTikKn1+2OX1KPy+9US_yX=E6+CiaCTTB6yqnAWwW@mail.gmail.com>
References: <AANLkTinUV9Z_w85Gz13J+bm8xqnxJ9jBJXJm9bn5Y2ec@mail.gmail.com>
	<alpine.LFD.2.00.1101061956470.22191@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Jan 07 17:00:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbEjU-0003Ec-AU
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 17:00:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189Ab1AGP76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 10:59:58 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:50214 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065Ab1AGP76 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 10:59:58 -0500
Received: by qyj19 with SMTP id 19so617727qyj.19
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 07:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=9lgXv1cnfTF0xSPPRpABKawYCAzio5aQ0cWodHFpoUY=;
        b=Sat1zgEvQ2FCixYX/NAOwURHqAuk2PwTG0nUQRV74j1Ej4ESxsDeBddRaU9gxhna3w
         HRSbUTLCrCAW8Bdhnpl8tihoL6XRy4PZccOXEMX2maYZdykkLaKQK1TB14CUUlgBj3no
         XH2hesJxGVurXrsV8VsRIitiRMY3ZP1djPwDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=KlAMru6vPO9dvvYZIF3yabGzQ0lKEuYdollwBdWcRp/cbGIovytHqNnZFeemje24BP
         hyMMlKbO9WxJP3rYrUKTMDfKGfQffdFp3GVWOMJ7Xh0/DSc8rSSQqOs5ejnZfY1VsjDp
         tb7TU5hMjHQMkr08zfLZvHElvPJwHqgyYzVdQ=
Received: by 10.229.251.139 with SMTP id ms11mr1229551qcb.198.1294415997341;
 Fri, 07 Jan 2011 07:59:57 -0800 (PST)
Received: by 10.220.190.203 with HTTP; Fri, 7 Jan 2011 07:59:56 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1101061956470.22191@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164719>

On Fri, Jan 7, 2011 at 3:21 AM, Nicolas Pitre <nico@fluxnic.net> wrote:

>> The last thing I like about these chains is that the number of chains
>> is reasonable. It won't increase too fast over time (as compared to
>> the number of commits). As such it maps well to BitTorrent's "pieces".
>
> My problem right now is that I don't see how this maps well to Git.

 bittorrent as "just another file getting method" maps very well.

 only with some modifications to the bittorrent protocol would the
concept map well to bittorrent "pieces" because the pieces are at
present a) fixed size b) defined by a heuristic based on the file size
(logarithmic) so that the number of pieces are kept to within a
reasonable limit.

 bottom line: my take on this is (sorry to say, nguyen) that i don't
believe bittorrent "pieces" map well to the chains concept, unless the
chains are perfectly fixed identical sizes [which they could well be?
am i mistaken about this?]

 l.
