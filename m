From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] grep: -L should show empty files
Date: Wed, 13 Jan 2010 17:04:18 +0100
Message-ID: <fabb9a1e1001130804s4716587l57d56884b5d0d068@mail.gmail.com>
References: <7vtyv4cpna.fsf@alter.siamese.dyndns.org> <7vvdf9402f.fsf@alter.siamese.dyndns.org> 
	<alpine.LFD.2.00.1001110739280.13040@localhost.localdomain> 
	<alpine.LFD.2.00.1001110748560.13040@localhost.localdomain> 
	<7vtyusr4r7.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001110830070.13040@localhost.localdomain> 
	<7v63774tfd.fsf@alter.siamese.dyndns.org> <7vvdf73eql.fsf_-_@alter.siamese.dyndns.org> 
	<fabb9a1e1001121327s392f7311t2a7f11081ed70ff8@mail.gmail.com> 
	<7vpr5esdbp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Miles Bader <miles@gnu.org>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 17:04:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV5i7-0003UE-NM
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 17:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755330Ab0AMQEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 11:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755160Ab0AMQEj
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 11:04:39 -0500
Received: from mail-px0-f174.google.com ([209.85.216.174]:57087 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850Ab0AMQEi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 11:04:38 -0500
Received: by pxi4 with SMTP id 4so5704744pxi.33
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 08:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=+XwjqagRU0wW6e0NJZze9SX+vWcNElZvMNO/dwhZF9I=;
        b=Ek6zHUTDLx8NLFkIOPICXVRMLp5Cqcq9X2q/qHdmLjdDyUD01squ8TIoUz8OGNx+L7
         frEoFezgQ+sOIYuoHmXBJf2PMrJ88bTXYR1nK0j9WYAemSr0mwiOgorLlH0RALBKFTcz
         bo0ATFva4Osq2j8E5gb6vFK/rM4mPj0nJ0ZSA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=TfZUu/OG6S5K4L9AYTKPhX1DC0D6WaOqhxIN4R20SFlAByiS/KHPM2nRYsRMp0V6ig
         TD42p0WHCPlta8W1VV0iOQ6PTX9/6rpBl4DDAUaK2a+7iJNVdKqsTpmNC575qtoNiv+o
         c9dXUJL6X30WsKzdM0+KrlmzOm+26njX529ts=
Received: by 10.142.9.11 with SMTP id 11mr2957123wfi.101.1263398678133; Wed, 
	13 Jan 2010 08:04:38 -0800 (PST)
In-Reply-To: <7vpr5esdbp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136835>

Heya,

On Wed, Jan 13, 2010 at 07:56, Junio C Hamano <gitster@pobox.com> wrote:
> It's Ok as the price we pay for producing correct result is to open those
> empty files, read them, and look for matches which we will never find ;-)

I'm not that familiar with the code, but wouldn't it be possible to
keep the early abort, but make it dependent on not using the '-L'
flag?

-- 
Cheers,

Sverre Rabbelier
