From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Add ERR support to smart HTTP
Date: Sun, 5 Sep 2010 19:27:30 +0000
Message-ID: <AANLkTinoEp55C3=hF6-LO5fwn2FpMxBZry-=2B6kvXc1@mail.gmail.com>
References: <1283707815-32038-1-git-send-email-ilari.liusvaara@elisanet.fi>
	<20100905174105.GB14020@burratino>
	<20100905184929.GA32735@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sun Sep 05 21:27:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsKsK-0003C1-SY
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 21:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754100Ab0IET1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 15:27:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55156 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224Ab0IET1b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 15:27:31 -0400
Received: by iwn5 with SMTP id 5so3501118iwn.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 12:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=1aOR9FUafXH1sKkICWN4gy89iRo1qZuw8OcxjSP5EVc=;
        b=DVqmRKSzEMjOTCliWzzBSIEMvYwmo/gSPq3PL1C0GZ82VbVPfGlSLi6h8DnExgCOPy
         aGERGii8Das3VKLwwdykvLicJM221/vi0zRdvNCmyey6WVAckFmppE9BHdJqbPMo8sW0
         RxGQmrfRuvYduyttrjH5GPrTzIYUav6E1yvL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=slHQ/zu2HlRmcj2aNejr7NNJM6d0nk80vIgaojftTWPWemR+2JKa2lug3QVyMkFYiL
         4jxuH73sGSO9BW2HkjVXTkSSFvgUxrHjOxi5yc6yC1i2j0WlvU5oJzQWbIZiIjYCAsIS
         J5EktH4vjRgMnRc35/CUzk9R6T5a9hACs83IQ=
Received: by 10.231.39.196 with SMTP id h4mr4856193ibe.64.1283714850329; Sun,
 05 Sep 2010 12:27:30 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sun, 5 Sep 2010 12:27:30 -0700 (PDT)
In-Reply-To: <20100905184929.GA32735@LK-Perkele-V2.elisa-laajakaista.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155476>

On Sun, Sep 5, 2010 at 18:49, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:

> AFAIK, HTTP errors don't have descriptions printed.

I don't know if this applies here but HTTP error codes can come with
any free-form \n-delimited string:

    HTTP/1.1 402 You Must Build Additional Pylons
