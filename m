From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Thu, 22 Apr 2010 21:08:10 +0200
Message-ID: <u2ifabb9a1e1004221208je2520cefo952367f02f51ec0e@mail.gmail.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain> 
	<20100422155806.GC4801@progeny.tock> <87wrvzs590.fsf@frosties.localdomain> 
	<alpine.LFD.2.00.1004221445310.7232@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Goswin von Brederlow <goswin-v-b@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Apr 22 21:08:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O51lP-0002FT-Jv
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 21:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755101Ab0DVTIe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 15:08:34 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:43002 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169Ab0DVTId convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Apr 2010 15:08:33 -0400
Received: by fg-out-1718.google.com with SMTP id 19so7729fgg.1
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 12:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=c6FatzNXRQb5R/pnOAFhi9uZPs2/6Ed9TZ72NmtiJ8Q=;
        b=Pxpf6X+IsglePIp1Sv+fUViy88dSxfq+s+RRDGJAtfksW/cYAXTNYuRTdmbkp0ARU1
         m3uymFqy4cgl12jpizleHcrRdpfTWqBL39TFU4sUiznxwA+rbmusFioksbQv7PoX/iYK
         54c1l165+rkRN9adFeFL7/YPIyRF5mwiZFSFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=fkHLji0b/NUHY856/KcTYMvUBVwKl7T8tPUqHPjPl0o9CfyNDhf++STTndspk1+DgG
         V4/66H7s7fjyHu63tmgSnxprQuq34VqnXN2p7/kcjH99oHnRwdJicpjRRuIvK0UfsaKB
         LkZrpRhuwYvj1px19+DQsAT54IZnkHMvKlvVQ=
Received: by 10.86.72.19 with HTTP; Thu, 22 Apr 2010 12:08:10 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1004221445310.7232@xanadu.home>
Received: by 10.87.66.15 with SMTP id t15mr944338fgk.37.1271963310340; Thu, 22 
	Apr 2010 12:08:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145549>

Heya,

On Thu, Apr 22, 2010 at 21:03, Nicolas Pitre <nico@fluxnic.net> wrote:
> Good for you. =C2=A0I'm not that disciplined. Hence I often end up wo=
rking on
> more than one thing in parallel. =C2=A0The index is just so incredibl=
y useful
> in that case. =C2=A0I'm also a big fan of 'git add -e'.

Speaking of which... how about having just 'git commit' drop you in
interactive commit mode?

--=20
Cheers,

Sverre Rabbelier
