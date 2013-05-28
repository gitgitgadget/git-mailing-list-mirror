From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git clone depth of 0 not possible.
Date: Tue, 28 May 2013 09:31:31 -0700
Message-ID: <CAFzf2XxT5eRNDGT7fEMNMi3aAxsbi4b8aBNx=Nj=b=ziEETm4g@mail.gmail.com>
References: <1357581996-17505-1-git-send-email-stefanbeller@googlemail.com>
	<20130108062811.GA3131@elie.Belkin>
	<7vip78go6b.fsf@alter.siamese.dyndns.org>
	<CACsJy8D9+KHT=YfU0+rPCbs+AwxQOpfKzPChDhk8d-MMkRzZug@mail.gmail.com>
	<7vvcb8f6aw.fsf@alter.siamese.dyndns.org>
	<20130528091812.GG25742@login.drsnuggles.stderr.nl>
	<CAFzf2Xx2mMO5XJ8n1UsUMMpDvi+KMUt9DpRe80X4zpG=THxSPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Matthijs Kooijman <matthijs@stdin.nl>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 28 18:31:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhMoF-0002Ci-Jf
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 18:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934660Ab3E1Qbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 12:31:35 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:46854 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934576Ab3E1Qbf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 12:31:35 -0400
Received: by mail-la0-f41.google.com with SMTP id ee20so7684636lab.28
        for <git@vger.kernel.org>; Tue, 28 May 2013 09:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=BpNVVp8WmaUJ8c5UXL+koDQbv4ThKHMZ6ush41LtYRI=;
        b=GMKTjeURn29hh23DIszRWaxhUqU0x4GXf6vVK0fSmmOsTVG4pSx3TCHR3E5D3kDWoJ
         Kc7LHT09fLkVPg5zjWTaOmhDfbDofzs8BNQrzcqoHuGmn2I5HfjuZ//SvQGaXq9MJSZp
         bVieEC0hQtXR0vS6DkFKB+kUjN0vANQY1o9madC7YoSz6XgChwltC1jMSDbNDvAnP1uH
         t+DE3d3mhucKNlV1FesZAaECT0RbeD9ybBQZ8EqrPC97teJbzetrENmnqrCH/bn3s9Y2
         EHCuJ88ghfCWO+CEvyVbBHurzidXD2TQzOoZiq7eFmJzOrc4JXXVgkQcqkFguT6qwAFi
         OVIA==
X-Received: by 10.152.27.8 with SMTP id p8mr14599921lag.19.1369758691355; Tue,
 28 May 2013 09:31:31 -0700 (PDT)
Received: by 10.112.59.36 with HTTP; Tue, 28 May 2013 09:31:31 -0700 (PDT)
In-Reply-To: <CAFzf2Xx2mMO5XJ8n1UsUMMpDvi+KMUt9DpRe80X4zpG=THxSPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225659>

Jonathan Nieder wrote:

> If I remember correctly, what we discussed is just changing the
> protocol to "5 means a depth of 5". The client already trusts what the
> server provides.

(Or tweaking the protocol by adding a new capability, if unpredictable
behavior based on the version of the server won't fly. :))

Jonathan
