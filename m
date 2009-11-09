From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2] Show usage string for 'git http-push -h'
Date: Mon, 9 Nov 2009 21:56:51 +0800
Message-ID: <be6fef0d0911090556u77dbc1fah458e6a8b37ffa2cb@mail.gmail.com>
References: <20080125173149.GA10287@edna.gwendoline.at>
	 <20091108071152.GA20741@progeny.tock>
	 <20091108072604.GA21367@progeny.tock>
	 <be6fef0d0911090052s158ac720ha1fac70da748106d@mail.gmail.com>
	 <20091109104732.GA15519@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 14:56:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7Ujr-0007yc-AI
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 14:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755925AbZKIN4q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Nov 2009 08:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755871AbZKIN4q
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 08:56:46 -0500
Received: from mail-iw0-f180.google.com ([209.85.223.180]:55915 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755865AbZKIN4p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2009 08:56:45 -0500
Received: by iwn10 with SMTP id 10so2347152iwn.4
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 05:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TqDRBb/4uqt3qJiFcPQ17Hd5U1Aiu2E42CbU39ztXPg=;
        b=dL8POitYe83/jB3u2WDgPAO7bZbA/B8thYox2v5vhLLCigOjzyk44qIjjGOUhwea4z
         e6ucgvxlBjoIlHD0bKlJuhU5EtUL1CmAY5bZtgMXew0gB3LDPHCWrdwLbT7OEsatoMCw
         sGDhYnQgU80Cx/KWZkAJwoekfr1w5PKG3FWjs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=u2j/pFA3bubbSFvrni9iuFoLznxsRDBLJXI/G2nSKxsFVa/JOqVBLMqSLJWwuaplAa
         IKy+IVXDKR2vdL7reJIRrkajIhBC+ds8n5OUfoW2/Ogu4EZS6JfUd7SpHGkENM3RJR9j
         ioBUqogmK/WMksxR7WCLlukpLHe+1SBRmF3qA=
Received: by 10.231.48.210 with SMTP id s18mr578417ibf.3.1257775011127; Mon, 
	09 Nov 2009 05:56:51 -0800 (PST)
In-Reply-To: <20091109104732.GA15519@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132460>

Hi,

On Mon, Nov 9, 2009 at 6:47 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> (I was making sure "git http-push -h" would work without a git
> directory by putting the check for -h before setup_git_directory().
> But nothing in the argv loop requires a git repository, so it is
> better and simpler to move the setup_git_directory() call to after th=
e
> loop. =A0Thanks for the catch.)

Actually, I didn't notice the removal of the "is in a git directory
for -h" requirement; I was only looking at the argument mix.

Thanks.

Acked-by: Tay Ray Chuan <rctay89@gmail.com>

--=20
Cheers,
Ray Chuan
