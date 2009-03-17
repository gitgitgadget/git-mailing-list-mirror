From: Carlos Rica <jasampler@gmail.com>
Subject: Re: [PATCH] config: test for --replace-all with one argument and fix 
	documentation.
Date: Tue, 17 Mar 2009 12:12:55 +0100
Message-ID: <1b46aba20903170412u69041a71h3ccd97d0b61390d2@mail.gmail.com>
References: <1237283197.10001.9.camel@equipo-loli>
	 <alpine.DEB.1.00.0903171123530.6393@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: felipe.contreras@gmail.com, gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 17 12:14:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjXFc-0005iG-Vu
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 12:14:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754826AbZCQLNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 07:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754498AbZCQLM7
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 07:12:59 -0400
Received: from mail-fx0-f176.google.com ([209.85.220.176]:45900 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754327AbZCQLM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 07:12:58 -0400
Received: by fxm24 with SMTP id 24so3879404fxm.37
        for <git@vger.kernel.org>; Tue, 17 Mar 2009 04:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=a8CeNR5wOR6LtTNyxTBTO5y7e/4KQ1VLw7gr1SC1uo0=;
        b=H4ThFKgRsWg/Sw9JYQYn2H1D/Cc+VKnAJ+5lrPeeWNI0KarWfBxHqSpX05hGw6nITL
         UZHUMD7npB6sijRcAsw2QphuEqkMX0t3M5ftO9xxfpMQS0ZXc0tqQZ4ijJVUPjb3jvgo
         q9aZYFyGO893moComGQQ+fBgl1Twawd6+O+M4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jD97tgqigEZGyqxrq4UE9gYX4FviIJSbG7gSBVFmwhf7ZQ+QjgqHW/c/+Ocx6rD6Rz
         WM5adY7Ka6H8Dh2GfSIzx6l/jw6gIbFgR6TVEhEDVMhjWSgT+gVNJ6Eu3fl8gXzKnrnw
         bWZ8o6gsY/EcYixpCRqWDkQdghxoa/57h9N40=
Received: by 10.223.121.6 with SMTP id f6mr4236989far.77.1237288375917; Tue, 
	17 Mar 2009 04:12:55 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903171123530.6393@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113465>

On Tue, Mar 17, 2009 at 11:24 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 17 Mar 2009, Carlos Rica wrote:
>
>> Option --replace-all only allows at least two arguments, so
>> documentation was needing to be updated accordingly. A test showing
>> that the command fails with only one parameter is also provided.
>>
>> Signed-off-by: Carlos Rica <jasampler@gmail.com>
>
> Looks obviously correct to me.  I am actually unsure if I can ACK this
> patch, as most of builtin-config.c does not look all that familiar to me
> anymore ;-)

Thank you Johannes, I think that you don't need to do it in this
patch, I talked before with Junio and Felipe for this, and I think
that Junio is also following the whole change (my change here is not
comparable with the work of Felipe).

I just added you because Felipe Contreras said that you made some
suggestions to make this use of parse options possible.

See you!
