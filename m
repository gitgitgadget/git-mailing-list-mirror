From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Multiblobs
Date: Wed, 28 Apr 2010 18:10:38 -0500
Message-ID: <o2ub4087cc51004281610sdaba4276u9726cfaca6bff5ad@mail.gmail.com>
References: <loom.20100428T164432-954@post.gmane.org> <k2y32541b131004281107u6d15ed4ex54b5e5c138cc0e24@mail.gmail.com> 
	<loom.20100428T204406-308@post.gmane.org> <k2x32541b131004281427o2101720at3d324f5e94f05327@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sergio Callegari <sergio.callegari@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 29 01:11:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7GPO-0003hR-7o
	for gcvg-git-2@lo.gmane.org; Thu, 29 Apr 2010 01:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323Ab0D1XLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 19:11:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:16714 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932309Ab0D1XK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 19:10:59 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3551269fgg.1
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 16:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=PFpzXNGxFV8XsFCWgjpTVoaMppz2cpoMgnJq5RnhWsA=;
        b=pbsVJjeRcWh46CAxkDgy2JujI7om2XIHj+4EKYFUeSMPL5q2PagQKsN/b8iQ58bgKy
         JKOHN5rxsAdl3fJt+ps9N73IdvGTRC1UnIC7DDj3z6Mi6JziFb/Q1fjaV88f6VDiYZzy
         PnCDjqy+LgttAedsge0ACtGmAx42DkS949voY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ZcLDe/q1lf36EpZ19Wvk+243oXgeWaun6wYGE9lDSw4B66rnuslGYrHOUD+BT7eCpH
         f9IQ4IUn2uA4aoMOo2eLn+TQNFc34OI4zy3B+6paMbsqWjTXU4VeNZrf7dpRIUoWw04H
         bJ+ZyEZlW3pMk90amWmHL80Ww7ZnWuHMfC+hQ=
Received: by 10.239.185.203 with SMTP id d11mr75130hbh.213.1272496258069; Wed, 
	28 Apr 2010 16:10:58 -0700 (PDT)
Received: by 10.239.189.143 with HTTP; Wed, 28 Apr 2010 16:10:38 -0700 (PDT)
In-Reply-To: <k2x32541b131004281427o2101720at3d324f5e94f05327@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146019>

On Wed, Apr 28, 2010 at 16:27, Avery Pennarun <apenwarr@gmail.com> wrote:
>
> But then you're digging around inside the pdf file by hand, which is a
> lot of pdf-specific work that probably doesn't belong inside git.

Core git could provide just the mechanisms for easily defining
'plugins' for handling different formats.
