From: Phil Hord <phil.hord@gmail.com>
Subject: git submodule sync --recursive
Date: Tue, 16 Oct 2012 19:20:42 -0400
Message-ID: <CABURp0obPcS=KZJ4xaVouHBS_O+OuWGYxYwSU9wwnQrL5Huwzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 17 01:21:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOGRp-0004RR-FW
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 01:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755823Ab2JPXVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 19:21:06 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:52772 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755504Ab2JPXVF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 19:21:05 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so4585176lag.19
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 16:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=tK7wP9txUbrDF+5hnX+ciW9lxEOdCq80Uo8MZmJg/Ek=;
        b=mAkQg8hs4EEltX7XDhdUzubPkiB3ErsmjZ+f2f0FQBvQ+QNDwwvqXGG7K6Dr/go263
         5cVfAUkZmYD+v6csuPQIbbnMGv6WteCWai16nFXtOwiROD+G1c4IXUdN34mM3EbxMDPB
         IWc49xUxsuNRTo2G5RmdCK1Gmg+hls5eC68iDucrr0hqdsAfWSmtmFfcYvB8qTpES8/J
         1dP4A0NK9vY5pWHe1xla1M6TGl4VpojQVAZAPBV/W1yFTaEU/4UvJuybClk2rG+EKjs+
         2a+LXnoZP+m9+SkcpDFKG5gWyC+Sxxr0632jVLTlv6f+7y+4iUSp6CzSVfyYwBcRItbg
         BJtQ==
Received: by 10.112.39.170 with SMTP id q10mr5727093lbk.120.1350429662735;
 Tue, 16 Oct 2012 16:21:02 -0700 (PDT)
Received: by 10.114.26.166 with HTTP; Tue, 16 Oct 2012 16:20:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207885>

I noticed that this is not supported:

    git submodule sync --recursive


I do not see any discussion in the relevant commits about why it
cannot or should not be supported.  Is it just an itch no one has
scratched?

Phil
