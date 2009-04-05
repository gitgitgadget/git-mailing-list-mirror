From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 7/7] user-manual: simplify the user configuration
Date: Sat, 4 Apr 2009 23:36:41 -0400
Message-ID: <76718490904042036q26bebc13p91c8cffaf432c02c@mail.gmail.com>
References: <1238837909-3060-1-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-2-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-3-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-4-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-5-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-6-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-7-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-8-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 05:38:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqJBX-0003ku-8T
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 05:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756876AbZDEDgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 23:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756845AbZDEDgo
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 23:36:44 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:19871 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756802AbZDEDgo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 23:36:44 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1628914ywb.1
        for <git@vger.kernel.org>; Sat, 04 Apr 2009 20:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=w0lGzPtNy+WhHdo08gNlYwepx3Gh7okEuTMnaOKBZaI=;
        b=YjpyOP9bUzBoe7pXTkPH0IErvE7YRzc4fT6/mRz4Q7WLn/2OJ62x5qu/3CsGQTu2pg
         7yZ0A9NcN80MFukO42pcnpBS2iVI/u1Dsoum4P/QcN8X25Q2+vdd/9SMFedXI0vBbLBj
         s92akFHgRqtm+AswBlTSYbGlNBaBOFu0bunoY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wOxSJt+sn/UgDIgQmNZHZU0oGrc5Xf2bfjuRFhDV2FFik53hFgE8KGkFWjidjosFbe
         3ANDtDMv+PJjy06V0C2RGb+3I8Jz6+TRdTAlzmJe92TMglvFZLqsCEQTqcBwWqGTYmX4
         Lmmq3CagX1xArdKBJcSUqG8TmiK5QSLhDMRfI=
Received: by 10.151.11.19 with SMTP id o19mr5531927ybi.146.1238902601999; Sat, 
	04 Apr 2009 20:36:41 -0700 (PDT)
In-Reply-To: <1238837909-3060-8-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115628>

On Sat, Apr 4, 2009 at 5:38 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> This is shorter, avoids the burder to think about the format of the
> configuration file, and git config is already used in other places in
> the manual.
> [...]
>  ------------------------------------------------
> -[user]
> -       name = Your Name Comes Here
> -       email = you@yourdomain.example.com
> +$ git config --global user.name "Your Name Comes Here"
> +$ git config --global user.email you@yourdomain.example.com
>  ------------------------------------------------

This has come up before, and the idea was to hint to the reader that
.gitconfig is something they can edit themselves.

j.
