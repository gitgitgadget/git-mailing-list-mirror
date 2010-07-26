From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] config --get --path: check for unset $HOME
Date: Mon, 26 Jul 2010 12:08:37 -0500
Message-ID: <20100726170837.GC4399@burratino>
References: <20100723003456.2976.899.reportbug@dr-wily.mit.edu>
 <20100723012322.GA27113@burratino>
 <20100725085939.GA5281@radis.liafa.jussieu.fr>
 <20100726005111.GA29755@burratino>
 <20100726140756.GH12476@radis.liafa.jussieu.fr>
 <20100726150651.GA4021@burratino>
 <AANLkTimf73aczIILlQ5N_id97kJNmGAUf0QLlMl8my2r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julien Cristau <jcristau@debian.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 19:09:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdRBc-0003J1-Hv
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 19:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281Ab0GZRJw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 13:09:52 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:57599 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144Ab0GZRJv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 13:09:51 -0400
Received: by qyk8 with SMTP id 8so2056316qyk.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 10:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=DiDL8teSJJMRhQNW3fef/iwA7xVrTAK+/BbVzuJvSdo=;
        b=Yn/F45X5iwhLVXv3yN5KxpVZ17j4zXXrSROHF7ADmzB9uewksNlQZyctQUaVjVNPyj
         OvHtmjKGDBVq2dZfu/U/gStFCSBbGn+wVaOPDwKH+KDHW31IbPIrXPhR4EUtLIwLnTTM
         V99Fe2FM+XMkX87L9OynhYcLkqCNdcM2TX5Fs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Gf+0eOXPx2tPiintMjmtb6blcRpWRz6JKHcPLgbtCCtRFH7bNaIaR0u0xkNGZJPrHp
         TGMfiCWWNKldNh0ETa/S0NVlyD4EssHhBWnaWDt9JciHUlgawpECLsS+syhPJOlIA3xi
         DL5SLx4cv3j8poZDPFS5tTc2UTR6mgNsF+n7o=
Received: by 10.220.62.5 with SMTP id v5mr4328809vch.102.1280164190242;
        Mon, 26 Jul 2010 10:09:50 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id z2sm878810vcj.42.2010.07.26.10.09.48
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 10:09:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimf73aczIILlQ5N_id97kJNmGAUf0QLlMl8my2r@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151859>

=C6var Arnfj=F6r=F0 Bjarmason wrote:

> Should we maybe fall back on checking pw_dir in getpwuid() if $HOME i=
sn't set?

Maybe.  Why?  On Unix I suspect it is such a rare case as to not
justify complicating the rules, but I do not know if it would help on
other platforms.

Jonathan
