From: Matt Graham <mdg149@gmail.com>
Subject: Re: Best CI Server for Git?
Date: Mon, 2 Feb 2009 19:42:13 -0500
Message-ID: <1c5969370902021642v4e8d93djd22d5caa4aa9d1a9@mail.gmail.com>
References: <c115fd3c0902021258i61a04f74u481ba66c645fe8f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 01:44:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU9OP-0006AP-QN
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 01:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758855AbZBCAmR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Feb 2009 19:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755489AbZBCAmR
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 19:42:17 -0500
Received: from mail-bw0-f12.google.com ([209.85.218.12]:58893 "EHLO
	mail-bw0-f12.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758675AbZBCAmP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Feb 2009 19:42:15 -0500
Received: by bwz5 with SMTP id 5so1622380bwz.13
        for <git@vger.kernel.org>; Mon, 02 Feb 2009 16:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=G6qznK8inuwWONEqF3luLTIDYlLtIsb0/fS+N/Q0ld4=;
        b=nlkJ7Lq64NZ1pdkqGF/fYIvLK2Pum9f7bHQOxRSe6SHBZGMBy89Cp/x0G0WV1DalGR
         JlQLgg/bK5CoffhTx5CocCahRAPo59ASpCJVMHRgCC/qYJ78wlNXHACyMmfmcvLixIH+
         F986c2m9ubK40t4Q+LiXOtjLMZg1zGkWKfvLY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Sf5hkdPE+QDN+Nt4BdsdmPjf43IbhDSIeLygg/ARuxl8JcWxppa8P7LH2jQIOIRRkW
         l72TU9zVzDQSx07j0Lng6kWDfp/CozJz7RGAnIO7EeCJ/wxHVAahHMTircnpLJCvSjvK
         fAdyH0UV2K3WRi9OzUJwEI9OdaMPYgJpMEROs=
Received: by 10.223.106.68 with SMTP id w4mr601291fao.19.1233621733613; Mon, 
	02 Feb 2009 16:42:13 -0800 (PST)
In-Reply-To: <c115fd3c0902021258i61a04f74u481ba66c645fe8f5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108135>

On Mon, Feb 2, 2009 at 15:58, Tim Visher <tim.visher@gmail.com> wrote:
> I'm setting up a CI environment for my team and I'm wondering what CI
> Server works best with Git.  I'm actively considering Hudson and
> Cruise Control and I'm leaning towards Hudson because of a demo I saw
> Andrew Glover do at my local JUG.  It looks like it's not really
> 'officially' supported in either tool=E2=80=A6

Hudson leaves a fair amount to be implemented by plug-ins, so not
being installed out of the box doesn't really imply bad.  I would say
that there are more significant differences between Hudson and Cruise
Control than how they integrate with Git.  We are currently switching
from Cruise Control to Hudson for reasons related to ease of use.

Here is another hudson/git plugin.  It may not be quite as official
but addresses issues people have had with the more official one:
http://github.com/stephenh/hudson-git2
