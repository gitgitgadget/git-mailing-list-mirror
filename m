From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: Git over SSH
Date: Mon, 11 Feb 2008 12:47:57 +0000
Message-ID: <57518fd10802110447s61015144gc577d45e2fc81864@mail.gmail.com>
References: <9732aadb0802110438s2a102c8cxd4eb4d0dd9595d52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Henrik Vendelbo" <hvendelbo.dev@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 13:48:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOY5i-0005vx-JN
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 13:48:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564AbYBKMsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 07:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752094AbYBKMsE
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 07:48:04 -0500
Received: from wx-out-0506.google.com ([66.249.82.229]:53862 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbYBKMsB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 07:48:01 -0500
Received: by wx-out-0506.google.com with SMTP id h31so4764376wxd.4
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 04:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=OkElDcWXYZmBWqRTHepxVAFWxjT09q9rrZ2RHxDlkpM=;
        b=raKoZX50HL7Z4b+urf8wmEVZRy8wFqs6HZVVU5DpiY04Bz5MDDbErJZlQJErp8ttEwmiqfNpxh5MQbddExwzDi2PeYf/UEYIBajQZRu8dytMlACICVkQ6hJiX3k/aPNdNxbqYH6I0j1v1uyGhwuSCzHYlYVdbcmZIhIntv/DbW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=S08ye7QOtF0AfZ7hdib1Z4YRj2OvfhMEXsje6crmbutnbzep125eovACsGKdKC1jzHzmrnoctEn1LSJMAJCdEHo2heDYlq/xb4X2DDfXHwK9U1vAfe/T63WPkxr8Ea0USwLCRGyBNK1AU3xouRQf5NiZZbG3kUT7o4/fZqj5WyM=
Received: by 10.141.15.19 with SMTP id s19mr10554580rvi.161.1202734077381;
        Mon, 11 Feb 2008 04:47:57 -0800 (PST)
Received: by 10.141.86.15 with HTTP; Mon, 11 Feb 2008 04:47:57 -0800 (PST)
In-Reply-To: <9732aadb0802110438s2a102c8cxd4eb4d0dd9595d52@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 53bdd29b026a1ca0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73525>

On Feb 11, 2008 12:38 PM, Henrik Vendelbo <hvendelbo.dev@googlemail.com> wrote:
> I seem to have missed something quite crucial. After many weeks of
> using git locally on two machines, I still haven't managed to
> synchronise over ssh.
>
> I use Mac OS X Leopard on both and have no problem ssh'ing between
> them manually.
>
> Why I try any of the examples in the documentation I always get a
> general failure with some command not being found.
> The last one missing was git-upload-pack. Thing is though from a shell
> logged in as the same user, I can execute git-upload-pack on both
> machine, np.
>

Interactive and non-interactive shells run different scripts on ssh
login.  The real test for whether your path is set up correctly for
git over ssh would be  "ssh othermachine type git", which will run
'type git' as a non-interactive command.  You could try adding your
path to .MacOSX/environment.plist, which will set things up for both
interactive and non-interactive sessions.
