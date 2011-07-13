From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Coming from SVN world - need help
Date: Wed, 13 Jul 2011 15:17:36 +0200
Message-ID: <CABPQNSa1PO6je+4sXMRWLLwLG9sUNTD1a+SMJj=wdPF+_dUPHA@mail.gmail.com>
References: <20110713183056.1cde5b61@shiva.selfip.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "J. Bakshi" <joydeep@infoservices.in>
X-From: git-owner@vger.kernel.org Wed Jul 13 15:18:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgzKn-0007uj-5i
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 15:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478Ab1GMNSR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jul 2011 09:18:17 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:50506 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753392Ab1GMNSQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2011 09:18:16 -0400
Received: by pvg12 with SMTP id 12so4700916pvg.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 06:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=4ISMBy7JWKx3bp2O2AVHYnnH3ITlxTqotKb9/TYNSvw=;
        b=CF925TKwhe9WhSOIcvzpEApr2hhk9WKOQWi0NNKF0fhCPm8UzYWJR8NeoQvhpqJB/K
         G8Mv/BPBzO5JrMq3S2ak9y/G9+oIEnKfuFjeEyCnJdFm4V2bzDdIS2rhCggvjLx06OSl
         r39pUTSWFUUcVAQJZXWj+zWpFYJNVH7Oh8wbA=
Received: by 10.68.22.41 with SMTP id a9mr1334292pbf.506.1310563096106; Wed,
 13 Jul 2011 06:18:16 -0700 (PDT)
Received: by 10.68.48.130 with HTTP; Wed, 13 Jul 2011 06:17:36 -0700 (PDT)
In-Reply-To: <20110713183056.1cde5b61@shiva.selfip.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177039>

On Wed, Jul 13, 2011 at 3:00 PM, J. Bakshi <joydeep@infoservices.in> wr=
ote:
> And now the issues when I am trying to do the same with git
>
> [1] git init ${git_path}/<repo>.git =A0>>> ok , it is working

You probably want to add the "--bare"-flag if this is the repo that
will be published.

> [2] Problem with mapping a dir with this repo
>
> mydir $> git --username <username> --password <password> clone file:/=
//${git_path}/<repo>.git
>
> Not working --username and --password .
>

You don't need username and password to clone over the file-system,
just the correct file-system permissions.

> [3] git commit -m also not commit into master.

git commit -m"foo" commits into the local branch that HEAD points to
(should be 'master' by default). You need to do "git push" to update
the published repo.
