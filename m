From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Undocumented git-diff syntax
Date: Mon, 11 Oct 2010 09:57:48 -0700 (PDT)
Message-ID: <m3wrpoekha.fsf@localhost.localdomain>
References: <20101011150342.292ad725@chalon.bertin.fr>
	<AANLkTinqPiGf1nbo0oOvDD5edgLBdO8xZfjGeFC4q0MU@mail.gmail.com>
	<20101011161721.35940919@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-15?q?Santi_B=E9jar?= <santi@agolina.net>,
	git@vger.kernel.org
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Mon Oct 11 18:57:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5LhE-0006Hx-S2
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 18:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755495Ab0JKQ5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 12:57:52 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44142 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755492Ab0JKQ5v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 12:57:51 -0400
Received: by fxm4 with SMTP id 4so553034fxm.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 09:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=teKBKDv3viMvfmU+BB94OBcbRT1sMWPF2eE6WCUh2lQ=;
        b=qHkjBu2jnMSKFUOskWHUu9jHa+7K24nRNudYtPBRgD4OTHOOXALdsPnW7d3oPmKJi1
         hkZRzARwmHLhENtKkO5TUuqDRK+gybWu6DUx0bTwOO0i/4VQXL8oqTZWOX/Hvn6GUyNR
         q5ULtqL+Yo9dP0gR3gWj6VR5CaC9Q2Fr0zDog=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=pZoXU1grAPUnWesiUAkIDdV7T3Pyau6WdiV+nq4UsP5iU52dbe6GqPHaq93QPAjEtF
         WoIlM898DV8VH0Q0hkWR37EtR1xHpgrctf8Fxf7lArveoxktS4KoO6hcJKjz13Kqq2nE
         k4X73O0zoApnf1ZrMI/i1vt/wF8MRFe70vCbM=
Received: by 10.223.106.142 with SMTP id x14mr2048659fao.21.1286816269188;
        Mon, 11 Oct 2010 09:57:49 -0700 (PDT)
Received: from localhost.localdomain (abwu155.neoplus.adsl.tpnet.pl [83.8.244.155])
        by mx.google.com with ESMTPS id a7sm3289603faa.21.2010.10.11.09.57.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 09:57:48 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9BGvADc017391;
	Mon, 11 Oct 2010 18:57:21 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9BGunT2017387;
	Mon, 11 Oct 2010 18:56:49 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20101011161721.35940919@chalon.bertin.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158781>

Yann Dirson <dirson@bertin.fr> writes:

> That said, this two-path construct would surely deserve its own
> synopsis.

Something like this?  Just kidding...


 SYNOPSIS
 --------
+[verse]
 'git diff' [<common diff options>] <commit>{0,2} [--] [<path>...]
+'git diff' [<common diff options>] <tree-ish> <tree-ish> [--] [<path>...]
+'git diff' [<common diff options>] <blob-or-path> <blob-or-path>

Possibly that <tree-ish> can be also a <directory> (on filesystem).

You can e.g. use

  git diff HEAD:git-gui/ 00e9de7^^
           ^^^^^^^^^^^^^ ~~~~~~~~~
           \-- tree       \-- commit (in subtree-merged history)

-- 
Jakub Narebski
Poland
ShadeHawk on #git
