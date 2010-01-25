From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Handle UNC paths everywhere
Date: Mon, 25 Jan 2010 11:22:19 +0100
Message-ID: <fabb9a1e1001250222n6912905fqfd2e76f8d4496bb7@mail.gmail.com>
References: <201001250155.47664.robin.rosenberg@dewire.com> 
	<fabb9a1e1001250136n2fb0043av7348db9177f4d096@mail.gmail.com> 
	<40aa078e1001250211w2dcc5e97vf89f64f136bd2f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Jan 25 11:22:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZM5l-0007LV-Gm
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 11:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484Ab0AYKWk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jan 2010 05:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753322Ab0AYKWk
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 05:22:40 -0500
Received: from mail-pz0-f190.google.com ([209.85.222.190]:49094 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932107Ab0AYKWk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jan 2010 05:22:40 -0500
Received: by pzk28 with SMTP id 28so315947pzk.4
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 02:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=N03XhLdiNEelhgWhUfT2ydJqGx8X/Uw6vFcv2LoebLI=;
        b=e8mo1kxAF0n1O0JojmCWmQZM8nWBKIf398R7NcyjSQicEzkg+y5IRMZmqjPH66x4kT
         Bxt9Els1WqrCZ+sNhF2OojK5vvpw5W1HYbxio9tUV7tasCrljqn96rnOvaGcf70OZVZz
         meu80+CyZXQdvvZKvOFJWmgsoXSqG6iBEAX0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=rBAXfwD26eVfdHAaGjpVW7IyxNnp5JzioyOozKyFWMTKWyEHwspcSRb9hFE8pekfll
         PwYVg5CmPEf6iHDY+oOwFoVhmh9odoJLKr2FyzL9OP3nGcJDoEbGOnxHwEEtfkVBhxlR
         NqXqiJsWh+N/UyKJ7vk06+9CP+pnP1uOhMcFc=
Received: by 10.142.75.6 with SMTP id x6mr4387453wfa.72.1264414959090; Mon, 25 
	Jan 2010 02:22:39 -0800 (PST)
In-Reply-To: <40aa078e1001250211w2dcc5e97vf89f64f136bd2f0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137946>

Heya,

On Mon, Jan 25, 2010 at 11:11, Erik Faye-Lund <kusmabite@googlemail.com=
> wrote:
> C:\Users\kusma>dir \\mongo\code
> The request is not supported.
>
> C:\Users\kusma>explorer \\mongo\code
> <login on the gui>
>
> C:\Users\kusma>dir \\mongo\code
> =A0Volume in drive \\mongo\code is Code
> =A0Volume Serial Number is 04C3-0225

Ah, that's very interesting. Not sure that will help MSysGit a lot thou=
gh.

--=20
Cheers,

Sverre Rabbelier
