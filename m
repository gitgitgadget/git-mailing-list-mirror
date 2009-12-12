From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash: Support new 'git fetch' options
Date: Sat, 12 Dec 2009 13:24:52 -0800
Message-ID: <20091212212452.GA407@spearce.org>
References: <4B236EBA.6050806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bj??rn Gustavsson <bgustavsson@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 02:36:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJdNm-00077t-SM
	for gcvg-git-2@lo.gmane.org; Sun, 13 Dec 2009 02:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933532AbZLMBgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2009 20:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933510AbZLMBgR
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Dec 2009 20:36:17 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:61643 "HELO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933501AbZLMBgR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2009 20:36:17 -0500
Received: by iwn1 with SMTP id 1so1256735iwn.33
        for <git@vger.kernel.org>; Sat, 12 Dec 2009 17:36:14 -0800 (PST)
Received: by 10.231.125.19 with SMTP id w19mr501319ibr.8.1260653096976;
        Sat, 12 Dec 2009 13:24:56 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm2255927iwn.3.2009.12.12.13.24.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 12 Dec 2009 13:24:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B236EBA.6050806@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135145>

Bj??rn Gustavsson <bgustavsson@gmail.com> wrote:
> Support the new options --all, --prune, and --dry-run for
> 'git fetch'.
> 
> As the --multiple option was primarily introduced to enable
> 'git remote update' to be re-implemented in terms of 'git fetch'
> (16679e37) and is not likely to be used much from the command
> line, it does not seems worthwhile to complicate the code
> (to support completion of multiple remotes) to handle it.
> 
> Signed-off-by: Bj??rn Gustavsson <bgustavsson@gmail.com>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

Junio, this belongs in 1.6.6 as its completion support for 1.6.6
features...

-- 
Shawn.
