From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/5] t/t5150: remove space from sed script
Date: Tue, 1 Jun 2010 23:12:46 -0500
Message-ID: <20100602041246.GA8245@progeny.tock>
References: <Wt_M4qptcPdpY0Q3jqUbfIk6yMCN9Ja5RCtRUsADK5OJGrz7R_Cq1oGpeQoN7A9uCvw38jm63Jo@cipher.nrlssc.navy.mil>
 <Wt_M4qptcPdpY0Q3jqUbfHdhdVVIWdBL2foeesc5htUYUB0CGsjKfyMiphDZSQ95SVoPotS07S0@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jun 02 06:21:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJfSP-0006Kc-W6
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 06:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843Ab0FBEUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 00:20:23 -0400
Received: from mail-yw0-f179.google.com ([209.85.211.179]:33244 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751Ab0FBEUW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 00:20:22 -0400
Received: by ywh9 with SMTP id 9so4597305ywh.17
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 21:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kCvYLBFA84QKcM+jEq3i07cHeldVJWWXu/VMBpOc7eU=;
        b=UzkhAHP9+D4hloLNqF62yBbm5H4JjzkYJH2516OO8BzFM5KGhokNaJUPlmcA0sz1+1
         Rxvc/V+RoErs5PpMbuM/vGakqFczYGCu2HLpIeXzp82SOteHodGm73rghEU8kL6yLjE1
         EWQ2imQcpBg4+4Jhg0X6FacNKAa3QOOvoWbRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BbwOIdkc3QvuwBdM1yVhLhRF9RiRa3SBfGgrnVGoR6V3o/wciUWB1m78ibTUDZQvoO
         IMh4qIoDX2xu0NuoIMJmUPoNz35d/L1DSvMCw6pZuFl/DU/ukPgHccoxeHOZo7psWG5s
         Gnd9uiLDP28D0LGAg5lI+lN1AyP2g9UGSuk44=
Received: by 10.42.8.79 with SMTP id h15mr1080022ich.1.1275451961829;
        Tue, 01 Jun 2010 21:12:41 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r12sm34572958ibi.2.2010.06.01.21.12.39
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 21:12:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Wt_M4qptcPdpY0Q3jqUbfHdhdVVIWdBL2foeesc5htUYUB0CGsjKfyMiphDZSQ95SVoPotS07S0@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148191>

Brandon Casey wrote:

> Solaris's xpg4/sed and IRIX's sed fail to parse these negated matching
> expressions when the '!' is separated from the command that follows.
> 
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>

Good catch, thanks.

Acked-by: Jonathan Nieder <jrnieder@gmail.com>
