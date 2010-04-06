From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] Documentation/remote-helpers: Fix some typos
Date: Tue, 6 Apr 2010 08:16:43 +0530
Message-ID: <i2vf3271551004051946i26856d58lb5d093a5656c3953@mail.gmail.com>
References: <f3271551003281104h9b672abk1a8ecccd7a4f8964@mail.gmail.com> 
	<7vpr2dmu9y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 04:47:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nyyop-0004Vd-7k
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 04:47:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757178Ab0DFCrH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 22:47:07 -0400
Received: from mail-yx0-f200.google.com ([209.85.210.200]:35930 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757102Ab0DFCrF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Apr 2010 22:47:05 -0400
Received: by yxe38 with SMTP id 38so1016781yxe.22
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 19:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=CQv+If6Zh/UutAIQtZKE8rAVfHLMuJiCYsisBuj01iY=;
        b=P9AjDnxplfL4SS83rTPHy+k7qzxAi/d3zL9Z85Sx3cZGwwJu5PsAzdIJpmfDxcqlvT
         4yfLWtlHpRv8CjsEIf9NhsiHMk6pYaiHbTW/tAu+BdFjNFXjg3wcY6ALaPrCUHvngqwp
         f72pmupUhN6l21eHChOGoSUGsqpg2IoNfF7sg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Ua1SFJgAj98VU4VlGgar6PDOQi9YZTQRS5Km49UPA6xZmieVVnLg7UTCDjG7q5z2w0
         EzpDmowJ3QYZk+QPrHPOmqahieCfx2/j2WMhLkLWBCqwSZW8nUxx2jO2sqJsgANPKqAn
         je+iHbcjM1/WyMyCRwW0cXMwokdmX4M2wVtAY=
Received: by 10.90.69.14 with HTTP; Mon, 5 Apr 2010 19:46:43 -0700 (PDT)
In-Reply-To: <7vpr2dmu9y.fsf@alter.siamese.dyndns.org>
Received: by 10.91.147.7 with SMTP id z7mr1474567agn.2.1270522023094; Mon, 05 
	Apr 2010 19:47:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144087>

On Tue, Apr 6, 2010 at 3:33 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> This not just fixes typo but changes what is being said, doesn't it? =
=A0The
> point of the original about the "error" is that the caller does not h=
ave
> to issue a redundant error message when the helper closes the connect=
ion
> without reporting the status back, but that information which probabl=
y is
> critical when maintaining the caller (and writing a new callee) is lo=
st.

Yes, I think you're right. Kindly revert this hunk.

-- Ram
