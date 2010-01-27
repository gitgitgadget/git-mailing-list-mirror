From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2] Fix remote.<remote>.vcs
Date: Wed, 27 Jan 2010 19:09:10 +0100
Message-ID: <fabb9a1e1001271009m283bd725v9582b7c0c0acbad2@mail.gmail.com>
References: <1264614797-22394-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Jan 27 19:11:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaCKi-0002qY-Sc
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 19:09:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755964Ab0A0SJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 13:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755886Ab0A0SJb
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 13:09:31 -0500
Received: from mail-pz0-f190.google.com ([209.85.222.190]:47362 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755864Ab0A0SJb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 13:09:31 -0500
Received: by pzk28 with SMTP id 28so2134931pzk.4
        for <git@vger.kernel.org>; Wed, 27 Jan 2010 10:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=hcMejnw4ranC/L/D0Tu16ky0Mc+k0cGLoaGKDVdp2fQ=;
        b=FJeR92h4gwZJuV54v0tQtd45XDmUxXuhf0b81luPb7F1efifyNqlyB1BGV2eeX/UfY
         W/w1HUc1mzBZncUlLfR45qN2c9lT6IKqVJ0te4qgV4FEYD0YymWsbj3qssjszc5Jy1tk
         EQu2mzbDQ/hsqI1ijH/zlh6+RUkvOCvnVburI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=bC+LOvDObnA5K/EMJApkr8pI8gbOcu6bOkpazcb3ONqr1E+ZfCcbRU0mrXyW33g8fq
         IoCN29dzkaYZTJYDCyWLPcD2WWxWW5WNdELsYnENSv6cazZdOE3lwX2bXU5/1oK8Qz2h
         k4V7zIshB5uRLEOxdK1enIsGKRB6k3xS5BUjA=
Received: by 10.142.248.36 with SMTP id v36mr2324249wfh.228.1264615770389; 
	Wed, 27 Jan 2010 10:09:30 -0800 (PST)
In-Reply-To: <1264614797-22394-1-git-send-email-ilari.liusvaara@elisanet.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138179>

Heya,

On Wed, Jan 27, 2010 at 18:53, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> Fix this by making VCS set by URL to be volatile w.r.t. transport_get()
> instead.

Patch looks good (didn't test it though), but I had to read this line
twice; I'm afraid I don't have any suggestions on how to improve it
though.

-- 
Cheers,

Sverre Rabbelier
