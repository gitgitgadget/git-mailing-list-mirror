From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: gitk doesn't always shows boths tags in "gitk tag1..tag2"
Date: Tue, 29 Jan 2013 12:25:18 -0800
Message-ID: <20130129202518.GE18266@google.com>
References: <510825B2.6070805@gmx.de>
 <20130129195718.GD18266@google.com>
 <51082CFA.4050501@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 29 21:25:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0HkX-0005uG-Od
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 21:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097Ab3A2UZY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jan 2013 15:25:24 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:43940 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958Ab3A2UZX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 15:25:23 -0500
Received: by mail-pb0-f51.google.com with SMTP id un15so493516pbc.24
        for <git@vger.kernel.org>; Tue, 29 Jan 2013 12:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=R4klc9Ka6CJHig1/R9jv5PFzTgZ658rgGoOnRG5Tois=;
        b=VWWzShtvAUzSDHZ3NLZGF+qp+NDWeko4CQGDAAvt5qSj7bEdGU6UYKet7/B2d/TstK
         07dbKItDQ3SJQI6CSVDack0Rjs0haP6/uEqD1Fh4oZ2sS29SJG+ZsJ3v8TfIK37WK0PS
         3tQtxM1tlgOMfa/HurGpk07Z+mssUfknL8QGo888hmC/tCY2Frja0+BOJDZT4feIXO97
         5HSolnreaBCFZs5EdZDMcR37QYKf9WDf/7u0XMVim2Ge+HanU4ntIjrSaKq+ZqDzfMRb
         7U58Pa4uPhcXqq36H23dOsePKWn+vzkdtiDRQki4QwKLTEPEfWA0YPS7vPEiSZTXUCl+
         3Uug==
X-Received: by 10.66.83.136 with SMTP id q8mr5529039pay.83.1359491123023;
        Tue, 29 Jan 2013 12:25:23 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id a1sm9647882pav.2.2013.01.29.12.25.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 29 Jan 2013 12:25:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <51082CFA.4050501@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214970>

Toralf F=F6rster wrote:
> On 01/29/2013 08:57 PM, Jonathan Nieder wrote:

>> As you guessed, 7.0.45 seems to live in a different area of history.=
 :)
>
> Well, seems be point to the root cause ..
>
> BTW
> $> gitk  --simplify-by-decoration  client_release_7.0.44..client_rele=
ase_7.0.45
>
> only 3 rows in the main window where=20
> $> gitk client_release_7.0.44..client_release_7.0.45

Easiest to look at

  gitk --simplify-by-decoration client_release_7.0.44...client_release_=
7.0.45

(three dots --- search for "symmetric difference" in gitrevisions(7) fo=
r
details).

Ciao,
Jonathan
