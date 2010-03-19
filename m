From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: submodule problem
Date: Fri, 19 Mar 2010 13:27:42 -0400
Message-ID: <32541b131003191027p2fbb358fvb86b7c6f18de64cc@mail.gmail.com>
References: <89030B4A18ECCD45978A3A6B639D1F2403299C8395@FL01EXMB01.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: John Dlugosz <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 18:28:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsfzX-0000fe-TA
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 18:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379Ab0CSR2G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 13:28:06 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:48553 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935Ab0CSR2E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 13:28:04 -0400
X-Greylist: delayed 607 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Mar 2010 13:28:04 EDT
Received: by ywh2 with SMTP id 2so719494ywh.33
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 10:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=qw+qAGMCZPl/8CqD+HYsg69XEdxHThOzxn13yp9SVn4=;
        b=raVCSyVFEQJLy7WlzTTyZvVw/8tc8QByLCo4mhYaRxBI6SlX238QJwjGQEqptFFaiO
         8SaXuRFzKYs/G5kabNHOS8hWPnYRnM2VSU86r1ysdATIFZPD4Ndjlq6TX2HSuLAEardS
         k+j3VGRu5LSLMgqNHHBosfaGfC0Jcw2UGR0lw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ADuRwdIhzVr4A/J2Qzf4wKpuQ1JgEcwEKIJ78okZHiaJ40w0sSRLsrp5Buy1aSITty
         QmoRIx4rdHqfOp+IFbcWV1/quSEl7XK+/bZaYpxqByw5p659xKBTKZnQXvJT64i/oWSZ
         OmGDmkr8TITbADzRWP09I4V76WpKWChC39tKw=
Received: by 10.150.252.2 with SMTP id z2mr3435122ybh.41.1269019682058; Fri, 
	19 Mar 2010 10:28:02 -0700 (PDT)
In-Reply-To: <89030B4A18ECCD45978A3A6B639D1F2403299C8395@FL01EXMB01.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142625>

On Fri, Mar 19, 2010 at 12:54 PM, John Dlugosz
<JDlugosz@tradestation.com> wrote:
> I thought I knew what I was doing, after reading the instructions.
>
> When I checked out an older version of the main project, I have to sy=
nc to the proper
> (older) version of the submodule too. =A0git admonished me to run the=
 command from
> the toplevel of the working tree, and when that was done,
>
> =A0 =A0 =A0 =A0git submodule update
>
> gives no output.
>
> =A0 =A0 =A0 =A0git submodule status

Did you run 'git submodule init'?  You generally have to do this once p=
er repo.

Avery
