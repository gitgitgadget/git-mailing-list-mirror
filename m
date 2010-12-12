From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] get_sha1_oneline: allow to input commit_list
Date: Sun, 12 Dec 2010 11:34:11 -0600
Message-ID: <20101212173411.GA19293@burratino>
References: <1292151419-30678-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 12 18:34:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRpob-00069H-WA
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 18:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319Ab0LLReY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Dec 2010 12:34:24 -0500
Received: from mail-yw0-f66.google.com ([209.85.213.66]:48778 "EHLO
	mail-yw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657Ab0LLReX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Dec 2010 12:34:23 -0500
Received: by ywi6 with SMTP id 6so1844501ywi.1
        for <git@vger.kernel.org>; Sun, 12 Dec 2010 09:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=a80ymNCZ3gBR4So9nFgj1fxQkpVqzocKRwFrQt/aKjc=;
        b=X+Z6ArRJiwu4PI0P4l6GNza2q8AlK9QsccWgvzBUOsWn5PMMWbEGAq78GqHoUzXPG0
         +AQjOZ9W3QEiqw8DYkqsrPkaPrxOK5AeBP5/rme8RzyiL2f1kqXddIAww6w3Qc+LWc0w
         Zmpc6ECjNACurkGoBKh7yUBHtrQVvNS7aMcaw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=AgJuYXQ2/08UG+DeL+xosuKJovu6Zo4liOnPEtCM5ycV4HT5U0e7r6CMbpzXHbe9ee
         qKc46hphgWzeMbAAAKEqaVyqDcSf95bPLJ67qDiwa6IduXMWXT4npNoT8A1Q+1M0kQ7n
         eMUhO0Y/BVVrxwFfRuizBvITOH5TAuMkTD3Y0=
Received: by 10.90.74.15 with SMTP id w15mr1821906aga.47.1292175262978;
        Sun, 12 Dec 2010 09:34:22 -0800 (PST)
Received: from burratino (adsl-69-209-48-248.dsl.chcgil.sbcglobal.net [69.209.48.248])
        by mx.google.com with ESMTPS id c7sm6229696ana.17.2010.12.12.09.34.20
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 12 Dec 2010 09:34:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1292151419-30678-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163487>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> [Subject: get_sha1_oneline: allow to input commit_list]

Cryptic.  Might be simpler to squash this with the next commit,
since the best explanation I can come up with is

	prepare to extend :/foo syntax to start search at specified refs
