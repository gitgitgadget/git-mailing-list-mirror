From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Technical details about the index file format.
Date: Tue, 31 Aug 2010 09:23:59 -0500
Message-ID: <20100831142359.GB2315@burratino>
References: <1202711335-12026-1-git-send-email-robin.rosenberg@dewire.com>
 <loom.20100831T025714-111@post.gmane.org>
 <20100831070851.GA7543@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 16:26:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqRmh-0007r8-DF
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 16:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757441Ab0HaOZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 10:25:45 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56525 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757389Ab0HaOZo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 10:25:44 -0400
Received: by gxk23 with SMTP id 23so2530051gxk.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 07:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6UXDU6MgT1HfyRcSlKOKtZ56BnZ9plWPePdiuL5SiWE=;
        b=h5rEE4OnmuxfByOX/qoKtcIhSOSzVU2/4l7TcDZwy6NgzhegtLoxKvyCcbhmZCVWnR
         ZQZ1FcWYsqH2WH9Wkz3bcWV49T5HvOPdHrtBob3LFM3FKY+8hkYQH3+AXdFqapvu6TKT
         gYBzm4hVeIm5a/Fhzf06YiaEoXpiDOrbMuiWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BvmzbaVW49Sp1noznszgO2sdnGS6LvprvFNQvy4byhYTaceLCkNayTbtIPJNTZoRcJ
         NdKYfVdVAcHwqzGeERKObWZunlV0npu8KUiNhO/h57/7APoP6THw8/Fjz7d1Vje1mgC3
         CNKb6u4BnC8ld977b3PFqxSjWGEzlqFEA223k=
Received: by 10.229.1.170 with SMTP id 42mr4112702qcf.252.1283264743482;
        Tue, 31 Aug 2010 07:25:43 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id t4sm9763982qcs.16.2010.08.31.07.25.42
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 07:25:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100831070851.GA7543@kytes>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154900>

Ramkumar Ramachandra wrote:

> Don't we already have this in Documentation/technical/pack-format.txt?

No; this is about the .git/index file rather than .git/objects/pack/*.idx.
