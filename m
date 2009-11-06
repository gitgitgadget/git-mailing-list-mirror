From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v3 11/12] Basic build infrastructure for Python scripts
Date: Sat, 7 Nov 2009 00:25:39 +0100
Message-ID: <fabb9a1e0911061525n7c7ad7dl2d97d979a25335bf@mail.gmail.com>
References: <1257547966-14603-1-git-send-email-srabbelier@gmail.com> 
	<1257547966-14603-5-git-send-email-srabbelier@gmail.com> <1257547966-14603-6-git-send-email-srabbelier@gmail.com> 
	<1257547966-14603-7-git-send-email-srabbelier@gmail.com> <1257547966-14603-8-git-send-email-srabbelier@gmail.com> 
	<1257547966-14603-9-git-send-email-srabbelier@gmail.com> <1257547966-14603-10-git-send-email-srabbelier@gmail.com> 
	<1257547966-14603-11-git-send-email-srabbelier@gmail.com> 
	<1257547966-14603-12-git-send-email-srabbelier@gmail.com> 
	<16cee31f0911061523v5b9754ebg9c846c0e96ac808@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
To: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 07 00:26:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6YBy-0003cF-FC
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 00:26:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758792AbZKFXZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 18:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758666AbZKFXZz
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 18:25:55 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:40136 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758516AbZKFXZz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 18:25:55 -0500
Received: by ewy3 with SMTP id 3so1576371ewy.37
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 15:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=TWxEqifkrtzhwV+7DTtZd3DtWdX3f6+0V2fFVyswhV8=;
        b=O4g6JMyphLX9XLR48Rb4Hj3AIeV4T9rC62+wrIoVjbX6qW0KjGRt2z1HLvlT6jxt6F
         Pbk2OSkKE6Dd+558iSMhN2dHlo8fSTY26tehcRqViSa4ybhfiBCz0cyw0OutPg6nIZgf
         nHpmec/gi5Bz4s3WvE4IfFhVrwr4+3sL2YsJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=p4e73Z4/moS3G50829okyyDNZEHRMWsT+KUBWj9WrYAJp/XMioIiUQvTMiqziUyxOE
         P5mFeqYLEHnYIOC0BI+wuTsN68AtCumKTZsgJSR3s8nc+eGF+xM/Asj95eaaX4THVONq
         tdnHGReAiMU0gJgQx1I7W08N1yN2GxYN5UEp0=
Received: by 10.216.91.69 with SMTP id g47mr1566512wef.167.1257549959281; Fri, 
	06 Nov 2009 15:25:59 -0800 (PST)
In-Reply-To: <16cee31f0911061523v5b9754ebg9c846c0e96ac808@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132344>

Heya,

On Sat, Nov 7, 2009 at 00:23, Andrzej K. Haczewski <ahaczewski@gmail.com> wrote:
> Does it mean, that it will be possible to write git-<cmd> scripts in
> python or, in example, port bash and / or perl scripts to python?

Technically that would be possible yes.

> I'm asking because bash+perl is a huge stopper for Windows platform,
> which requires basic unix environment to work, while python support
> for Windows is excellent and most of Windows developers already use
> python.

I don't know what the stance is on this though, currently it is
intended only for the remote helpers I think.

-- 
Cheers,

Sverre Rabbelier
