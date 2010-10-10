From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v3 11/14] daemon: report connection from root-process
Date: Sun, 10 Oct 2010 20:14:42 +0000
Message-ID: <AANLkTikqJKKSOS-X+d_hx0hyEdFmX3zNZBvZMV4qRMAp@mail.gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
	<1286716854-5744-12-git-send-email-kusmabite@gmail.com>
	<201010102058.16773.j6t@kdbg.org>
	<AANLkTinz69u-hh-URqBrpdcrm+84N2BC7Ov4O8xeuW73@mail.gmail.com>
	<AANLkTinEmrHMfw0z=uwOs9FDRcta3gwcEvc1MBi+_7C-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sun Oct 10 22:14:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P52IJ-0007c1-Di
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 22:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078Ab0JJUOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 16:14:43 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48474 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761Ab0JJUOn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 16:14:43 -0400
Received: by iwn6 with SMTP id 6so2529341iwn.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 13:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=yg+sxpf2zSqCD6bUWLd7Dr4nqcirDspxn5gnIfsmmi4=;
        b=VLpZ75ITKMJPxJcTpX6Nv0OvtqWhU028njW3s5JwaCvLP5XBawLA11wQk1+TgJ7FJV
         fjQy3mHYCZdH+wLdxZ36c22zmNtD/lhA450LWsKF+9eqkW77Ag1dFjN/2ROTwsFsK72/
         zjy9/0vTI22wRgkJ6T2GQN5qMaIImQzU6TxHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=WiiJyRqdPyODJSAqdQrOS7B738bbE6LKRkoTLXT6IYSwcp6niRbfk30hGXiOM0gMnN
         ukFQsRvuF7MSFzMggw8GiFbvSm5NrRGlxO9nRiD00kZZTOIDXq7TXtX4tE3b7RvTHman
         efkiR4UtJo+SCoZgMT908Ne3NiaY2T46vv/9s=
Received: by 10.42.179.136 with SMTP id bq8mr142475icb.93.1286741682376; Sun,
 10 Oct 2010 13:14:42 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sun, 10 Oct 2010 13:14:42 -0700 (PDT)
In-Reply-To: <AANLkTinEmrHMfw0z=uwOs9FDRcta3gwcEvc1MBi+_7C-@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158696>

On Sun, Oct 10, 2010 at 19:42, Erik Faye-Lund <kusmabite@gmail.com> wrote:

> -static int execute(struct sockaddr *addr)
> +static int execute()

Isn't execute(void) more portable?
