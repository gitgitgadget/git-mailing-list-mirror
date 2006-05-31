From: Matthias Kestenholz <lists@spinlock.ch>
Subject: Re: format-patch signoff argument no longer works
Date: Wed, 31 May 2006 13:28:03 +0200
Message-ID: <20060531112803.GB3877@spinlock.ch>
References: <93c3eada0605310332p19241861g466e1516a2aaf0df@mail.gmail.com> <93c3eada0605310411r712dab8au9b1c7d8ecb595a66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 31 13:55:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlPHo-0002dk-DT
	for gcvg-git@gmane.org; Wed, 31 May 2006 13:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWEaLyV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 07:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWEaLyV
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 07:54:21 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:62443 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S932478AbWEaLyU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 May 2006 07:54:20 -0400
Received: from spinlock.ch (80-218-7-29.dclient.hispeed.ch [80.218.7.29])
	by smtp.hispeed.ch (8.12.11.20060308/8.12.6/taifun-1.0) with SMTP id k4VBsDBt016463;
	Wed, 31 May 2006 13:54:14 +0200
Received: (nullmailer pid 6059 invoked by uid 1000);
	Wed, 31 May 2006 11:28:03 -0000
To: geoff@austrics.com.au
Content-Disposition: inline
In-Reply-To: <93c3eada0605310411r712dab8au9b1c7d8ecb595a66@mail.gmail.com>
X-Editor: Vim http://www.vim.org/
X-Operating-System: GNU/Linux 2.6.17-rc4-g2f880b65 (i686)
X-GPG-Fingerprint: 249B 3CE7 E6AE 4A1F F24A  DC44 B546 3304 690B 13F9
User-Agent: Mutt/1.5.11+cvs20060403
X-Virus-Scanned: ClamAV version 0.88.2, clamav-milter version 0.88.2 on smtp-07.tornado.cablecom.ch
X-Virus-Status: Clean
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-07.tornado.cablecom.ch 1378;
	Body=2 Fuz1=2 Fuz2=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21062>

* Geoff Russell (geoffrey.russell@gmail.com) wrote:
> The --signoff argument no longer works in git-format-patch.  Was this
> intentional?
> It still appears in the documentation for the command.
> 
> It appears to have got lost when the shell script got converted to C.
> 

Yes, this was intentional. You should sign off your changes while
committing (git commit -s|--signoff)

Thanks,
Matthias
