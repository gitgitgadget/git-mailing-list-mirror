From: Eric Raible <raible@gmail.com>
Subject: Re: [msysgit? bug] crlf double-conversion on win32
Date: Wed, 14 Oct 2009 13:46:46 -0700
Message-ID: <279b37b20910141346p7915ae84qcb5b9c39e89f5d30@mail.gmail.com>
References: <38cfaa83fdf80dec3a3d81ed3e0de0e2.squirrel@intranet.linagora.com>
	 <loom.20091014T001602-378@post.gmane.org>
	 <alpine.DEB.1.00.0910141601580.4985@pacific.mpi-cbg.de>
	 <7vfx9lersc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 22:52:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyAoe-0007lo-PL
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 22:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758856AbZJNUrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 16:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757219AbZJNUrY
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 16:47:24 -0400
Received: from mail-vw0-f203.google.com ([209.85.212.203]:39570 "EHLO
	mail-vw0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756212AbZJNUrX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 16:47:23 -0400
Received: by vws41 with SMTP id 41so77286vws.4
        for <git@vger.kernel.org>; Wed, 14 Oct 2009 13:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=o4+14irCx9fDwPRA962dpxPnNtvWR/S2pjb7a+DPFZo=;
        b=dNW4yHfuezWhpZzlKvC1nPWcngxKtOZNJsoTttgvvLeh4yIKokIwqWJuKC6rZyFaRW
         Y5GqofwSsu6sdVnq1CpW+SQ39MF7amln59F11d/XZOmULe76NK1k2gJLjS6VyJbwWcvJ
         cCjKvM11K5gpzjQZQn9ZnKm/JWMr/Wo4FKym0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=qNcJFBot0bu0r7bNmm5ECzT15FDK2Gy4Cc/qdRkrZ096F5ezSxw8rsK85zxviEUiCv
         BmWZ5I5hJ3oZrRSOTgn8AZhWoSbKD4FtFn18s5MrwGl4+424efogVF47ca7VcJ6Jv+/W
         K2ZZkvBxtZQi+Zmf3xEFwqiHqlH47NbfB+/3w=
Received: by 10.220.108.105 with SMTP id e41mr10302656vcp.114.1255553206877; 
	Wed, 14 Oct 2009 13:46:46 -0700 (PDT)
In-Reply-To: <7vfx9lersc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130337>

On Wed, Oct 14, 2009 at 11:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Obviously, I am not seriously suggesting "--hard-without-cached-stat-info"
> as the name of this mode of operation, and you need to come up with a
> better one.

Since we already have --soft and --hard, how about --throbbing?
