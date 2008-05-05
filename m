From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v3 5/6] fn_out_diff_words_aux: Handle common diff line more carefully
Date: Mon, 5 May 2008 22:18:09 +0800
Message-ID: <46dff0320805050718n1a57c691w8c33e26c59fe829c@mail.gmail.com>
References: <1209815828-6548-1-git-send-email-pkufranky@gmail.com>
	 <1209874815-14411-1-git-send-email-pkufranky@gmail.com>
	 <1209874815-14411-2-git-send-email-pkufranky@gmail.com>
	 <1209874815-14411-3-git-send-email-pkufranky@gmail.com>
	 <1209874815-14411-4-git-send-email-pkufranky@gmail.com>
	 <1209874815-14411-5-git-send-email-pkufranky@gmail.com>
	 <1209874815-14411-6-git-send-email-pkufranky@gmail.com>
	 <alpine.DEB.1.00.0805041053380.30431@racer>
	 <46dff0320805040953i4230a686j8e8d63eaa6728c2f@mail.gmail.com>
	 <alpine.DEB.1.00.0805051310550.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 05 16:19:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt1Ww-0008N9-I6
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 16:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755920AbYEEOSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 10:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755938AbYEEOSN
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 10:18:13 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:18518 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755788AbYEEOSM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 10:18:12 -0400
Received: by an-out-0708.google.com with SMTP id d40so547016and.103
        for <git@vger.kernel.org>; Mon, 05 May 2008 07:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=PftpSmYc++zcug4DtpnIG7IcngHc5fZTSI5rhYtay0o=;
        b=WMksG188afaKq2DlcpP/A/5nS0rPQTZT0PHnUUrFqljW7oVw7TLUb5M4ige44SrpdPTFVuavzSjWuG/49B2QZegF7nD1y6srCeh6lrMkyx61B2klMWOtsGHUD4kv2RS8P/2YyKQ0/9QxwLpDQnuFU35MnCZ0oeBjomWNVMjvVAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YUnPic/rn3ObwNIwgDw5sv4ImYuAivyGfAOfShL34gH1LKZaHiL7EG6NJkM7wla047AJXZSmJlHJT+3nZmEFZXNeio8lPiSPCUShYM3xdFaarAWCCmdhbiMrc3I2Ej7kA/1Ia6E8fEyV49q+BSiqTWhogMErBAZA+MyhDeiBYuw=
Received: by 10.100.42.4 with SMTP id p4mr7647072anp.118.1209997089384;
        Mon, 05 May 2008 07:18:09 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Mon, 5 May 2008 07:18:09 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805051310550.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81285>

On Mon, May 5, 2008 at 8:11 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>  >
>  > Because we need recover the replaced character.
>  >
>  > Say, for a common diff line " foo", after restoring the replaced
>  > character, the corresponding line in minus and plus may be different.
>  > For example, "foo(" and "foo)".
>
>  Why do I have to spend time trying to figure out what you meant, write an
>  email, and get the explanation only in a response (i.e. not the commit
>  message, where it belongs)?
>

Since the new solution from junio has risen up, i think this patch
doesn't deserve us spending more time.



-- 
Ping Yin
